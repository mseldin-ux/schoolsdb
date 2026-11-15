const { test, expect } = require('@playwright/test');

test.beforeEach(async ({ page }) => {
  const errors = [];
  page.on('pageerror', error => errors.push(error.message));
  page.testErrors = errors;
});

async function login(page, user) {
  await page.goto('/controller.php');
  await page.getByLabel('User name:').fill(user);
  await page.getByLabel('Password:').fill('test-password');
  await page.getByRole('button', { name: 'Log In', exact: true }).click();
}

test('owner edits quoted text without admin fields or script execution', async ({ page }) => {
  await login(page, 'owner');
  await expect(page.getByRole('heading', { name: 'Edit School' })).toBeVisible();
  await expect(page.locator('[name=recpass]')).toHaveCount(0);
  await expect(page.locator('[name=schooltype]')).toHaveCount(0);
  const name = 'Browser "Quoted" School <img src=x onerror=alert(1)>';
  await page.locator('[name=schoolname]').fill(name);
  await page.getByRole('button', { name: 'Save School' }).click();
  await expect(page.getByRole('heading', { name: /Saved school/ })).toBeVisible();
  await page.getByRole('link', { name: 'Return to school' }).click();
  await expect(page.locator('[name=schoolname]')).toHaveValue(name);
  await expect(page.locator('img')).toHaveCount(0);
  expect(page.testErrors).toEqual([]);
  await page.getByRole('button', { name: 'Log Out' }).click();
  await expect(page.getByRole('heading', { name: 'Logged Out' })).toBeVisible();
});

test('manager creates, reviews, deletes and restores a school', async ({ page }) => {
  await login(page, 'manager');
  await page.getByRole('link', { name: 'Create School', exact: true }).click();
  await page.locator('[name=schoolname]').fill('Browser Created School');
  await page.locator('[name=address1]').fill('NORESULT');
  await page.locator('[name=city]').fill('Testville');
  await page.locator('[name=infoemail]').fill('UNKNOWN');
  await page.locator('[name=web]').fill('UNKNOWN');
  await page.getByRole('button', { name: 'Save School' }).click();
  await expect(page.getByRole('alert')).toContainText('without coordinates');
  await page.goto('/controller.php?action=adminlist&keywords=Browser%20Created');
  const row = page.locator('.school-listing').filter({ hasText: 'Browser Created School' });
  await expect(row).toHaveCount(1);
  const schoolId = await row.getAttribute('data-school-id');
  const actions = row.locator('.school-action-controls');
  await expect(actions.getByRole('button')).toHaveText(['Edit', 'Add New Review', 'Delete']);
  const actionBoxes = await actions.getByRole('button').evaluateAll(buttons =>
    buttons.map(button => ({ x: button.getBoundingClientRect().x, y: button.getBoundingClientRect().y })));
  expect(actionBoxes[1].x).toBeGreaterThan(actionBoxes[0].x);
  expect(actionBoxes[2].x).toBeGreaterThan(actionBoxes[1].x);
  expect(actionBoxes[1].y).toBe(actionBoxes[0].y);
  expect(actionBoxes[2].y).toBe(actionBoxes[0].y);
  const popupPromise = page.waitForEvent('popup');
  await row.getByRole('button', { name: 'Edit', exact: true }).click();
  const editTab = await popupPromise;
  await expect(editTab.getByRole('heading', { name: 'Edit School' })).toBeVisible();
  await expect(editTab.locator('[name=schoolname]')).toHaveValue('Browser Created School');
  await expect(row).toBeVisible();
  await editTab.close();
  const reviews = page.locator(`.school-reviews[data-school-id="${schoolId}"]`);
  await expect(row).toHaveCSS('background-color', 'rgb(238, 238, 238)');
  await expect(reviews).toHaveCSS('background-color', 'rgb(255, 255, 255)');
  await expect(reviews.locator('.school-review-table')).toHaveCSS('background-color', 'rgb(255, 255, 255)');
  await expect(row.locator('form[data-review]')).toHaveCount(0);
  const addReview = row.getByRole('button', { name: 'Add New Review', exact: true });
  await expect(reviews.locator('[name=comments]')).toBeHidden();
  await expect(addReview).toHaveAttribute('aria-expanded', 'false');
  await addReview.click();
  await expect(addReview).toHaveAttribute('aria-expanded', 'true');
  await expect(reviews.locator('[name=comments]')).toBeFocused();
  await reviews.locator('[name=comments]').fill('Draft review');
  await addReview.click();
  await expect(reviews.locator('[name=comments]')).toHaveValue('Draft review');
  const listingBox = await row.boundingBox();
  const reviewsBox = await reviews.boundingBox();
  expect(reviewsBox.y).toBeGreaterThanOrEqual(listingBox.y + listingBox.height);
  expect(reviewsBox.width).toBeCloseTo(listingBox.width, 0);
  await reviews.locator('[name=comments]').fill('Browser review & Unicode: é');
  await reviews.getByRole('button', { name: 'Add review', exact: true }).click();
  await expect(reviews.getByRole('status')).toContainText('OK');
  await reviews.locator('[name=comments]').fill('Browser updated review');
  await reviews.getByRole('button', { name: 'Update review', exact: true }).click();
  await expect(reviews.getByRole('status')).toContainText('OK');
  await page.reload();
  await expect(reviews.locator('form[data-review]')).toHaveCount(2);
  await expect(reviews.locator('small').first()).toHaveText(/\d{4}-\d{2}-\d{2}/);
  await expect(reviews.locator('[name=comments]').first()).toHaveValue('Browser updated review');
  page.once('dialog', async dialog => {
    expect(dialog.type()).toBe('confirm');
    expect(dialog.message()).toContain('Delete this school?');
    await dialog.dismiss();
  });

  await row.getByRole('button', { name: 'Delete', exact: true }).click();
  await expect(row).toBeVisible();
  await page.reload();
  await expect(row).toBeVisible();
  page.once('dialog', dialog => dialog.accept());
  await row.getByRole('button', { name: 'Delete', exact: true }).click();
  await expect(page.getByRole('heading', { name: 'Deleted school' })).toBeVisible();
  await page.goto('/controller.php?action=adminlist&deleted=1&keywords=Browser%20Created');
  await expect(page.locator('.school-listing')).toHaveCSS('background-color', 'rgb(238, 238, 238)');
  await expect(page.locator('.school-reviews')).toHaveCount(0);
  await expect(page.getByRole('button', { name: 'Add New Review', exact: true })).toHaveCount(0);
  await page.getByRole('button', { name: 'Restore', exact: true }).click();
  await expect(page.getByRole('heading', { name: 'Restored school' })).toBeVisible();
  expect(page.testErrors).toEqual([]);
});

test('admin finds schools without geolocations and retries an individual school', async ({ page }) => {
  await login(page, 'admin');
  await page.getByRole('link', { name: 'Create School', exact: true }).click();
  await page.locator('[name=schoolname]').fill('Missing Location School');
  await page.locator('[name=address1]').fill('NORESULT');
  await page.locator('[name=city]').fill('Testville');
  await page.locator('[name=infoemail]').fill('UNKNOWN');
  await page.locator('[name=web]').fill('UNKNOWN');
  await page.getByRole('button', { name: 'Save School' }).click();
  await expect(page.getByRole('alert')).toContainText('without coordinates');
  await page.goto('/controller.php?action=adminlist');
  await page.getByRole('link', { name: 'Schools without geolocations', exact: true }).click();
  await expect(page.getByLabel('Missing geolocation only')).toBeChecked();
  const row = page.locator('.school-listing').filter({ hasText: 'Missing Location School' });
  await expect(row).toBeVisible();
  const id = await row.getAttribute('data-school-id');
  const popupPromise = page.waitForEvent('popup');
  await row.getByRole('button', { name: 'Edit', exact: true }).click();
  const editTab = await popupPromise;
  await editTab.locator('[name=stateprovince]').selectOption({ label: 'Quebec' });
  await expect(editTab.locator('[name=stateprovince]')).toHaveValue('Quebec');
  await editTab.close();
  await row.getByRole('button', { name: 'Retry geolocation', exact: true }).click();
  await expect(page.getByRole('alert')).toContainText('without coordinates');
  await expect(page.getByRole('heading', { name: 'Processed 1 listings' })).toBeVisible();
  await page.getByRole('link', { name: 'Return to schools without geolocations' }).click();
  await expect(page.locator(`.school-listing[data-school-id="${id}"]`)).toBeVisible();
  expect(page.testErrors).toEqual([]);
});

test('only reviews beyond the newest two are collapsed and remain editable', async ({ page }) => {
  await login(page, 'reviewer');
  await page.goto('/controller.php?action=adminlist&idtarget=2');
  const reviews = page.locator('.school-reviews[data-school-id="2"]');
  await expect(reviews.locator('details')).toHaveCount(0);
  const csrf = await reviews.locator('[name=csrf]').first().inputValue();
  for (let index = 1; index <= 4; index++) {
    const response = await page.request.post('/controller.php', {
      form: { action: 'addreview', csrf, schoolid: '2',
        reviewstatus: 'Reviewed - OK', comments: `Collapsible review ${index}` },
    });
    expect(response.ok()).toBeTruthy();
    await page.reload();
    if (index <= 2) {
      await expect(reviews.locator('details')).toHaveCount(0);
    }
  }
  const older = reviews.locator('details.older-reviews');
  await expect(older).not.toHaveAttribute('open', '');
  await expect(reviews.locator('form[data-review]:visible')).toHaveCount(2);
  await expect(reviews.locator('[name=comments]').nth(0)).toHaveValue('Collapsible review 4');
  await expect(reviews.locator('[name=comments]').nth(1)).toHaveValue('Collapsible review 3');
  await expect(older.locator('form[data-review]')).toHaveCount(2);
  await expect(older.locator('form').first()).toBeHidden();
  await expect(reviews.getByRole('button', { name: 'Add review', exact: true })).toBeHidden();
  await page.locator('.school-listing[data-school-id="2"]')
    .getByRole('button', { name: 'Add New Review', exact: true }).click();
  await expect(reviews.getByRole('button', { name: 'Add review', exact: true })).toBeVisible();
  await expect(older.locator('form').first()).toBeHidden();
  await older.locator('summary').click();
  await expect(older.locator('form').first()).toBeVisible();
  await expect(older.locator('[name=comments]').first()).toHaveValue('Collapsible review 2');
  await expect(older.locator('[name=comments]').last()).toHaveValue('Collapsible review 1');
  const form = older.locator('form').last();
  await form.locator('[name=comments]').fill('Edited older review');
  await form.getByRole('button', { name: 'Update review' }).click();
  await expect(form.getByRole('status')).toContainText('OK');
  await older.locator('summary').click();
  await expect(form).toBeHidden();
  await page.reload();
  await expect(older.locator('form').first()).toBeHidden();
  expect(await reviews.locator('[name=comments]').evaluateAll(inputs => inputs.map(input => input.value)))
    .toContain('Edited older review');
  expect(page.testErrors).toEqual([]);
});
