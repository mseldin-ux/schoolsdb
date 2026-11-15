-- Review-only repairs generated from reports/garbled-entries.csv.
-- Target: MySQL schools table in the database you explicitly select.
-- This file has NOT been executed against the database.
-- Back up the target database before applying any changes.
-- Includes active AND soft-deleted schools, as recorded in the CSV.
-- Each UPDATE repairs one value only when the id AND original UTF-8 bytes match.
-- Already repaired or subsequently changed values are therefore skipped.
-- Hex literals avoid dependence on connection encoding or SQL backslash-escape mode.
-- Readable original/proposed values are provided in comments above each statement.
-- lastmodified is explicitly preserved to avoid changing historical edit timestamps.
-- Lost characters are updated only with manually supplied corrections (marked as such).
-- SAFETY: this transaction ends with ROLLBACK. After review, replace the final
-- ROLLBACK with COMMIT only if you intend to persist the changes.
-- If running selected UPDATE statements by hand, manage your transaction explicitly.

START TRANSACTION;

-- Entry 1: school id 14224, column `city`, deleted=yes
-- School (as reported): "Ecole Montessori de PÃ©tion Ville"
-- Original: "PÃ©tion Ville"
-- Proposed: "Pétion Ville"
UPDATE `schools` SET `city` = CONVERT(X'50C3A974696F6E2056696C6C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14224 AND CAST(`city` AS BINARY) = X'50C383C2A974696F6E2056696C6C65';

-- Entry 2: school id 14224, column `schoolname`, deleted=yes
-- School (as reported): "Ecole Montessori de PÃ©tion Ville"
-- Original: "Ecole Montessori de PÃ©tion Ville"
-- Proposed: "Ecole Montessori de Pétion Ville"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F72692064652050C3A974696F6E2056696C6C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14224 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F72692064652050C383C2A974696F6E2056696C6C65';

-- Entry 3: school id 14264, column `schoolname`, deleted=yes
-- School (as reported): "MozaÃ¯ek College"
-- Original: "MozaÃ¯ek College"
-- Proposed: "Mozaïek College"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F7A61C3AF656B20436F6C6C656765' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14264 AND CAST(`schoolname` AS BINARY) = X'4D6F7A61C383C2AF656B20436F6C6C656765';

-- Entry 4: school id 14273, column `city`, deleted=yes
-- School (as reported): "Centro Alba Montessori"
-- Original: "RÃ­o Piedras"
-- Proposed: "Río Piedras"
UPDATE `schools` SET `city` = CONVERT(X'52C3AD6F2050696564726173' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14273 AND CAST(`city` AS BINARY) = X'52C383C2AD6F2050696564726173';

-- Entry 5: school id 14534, column `schoolname`, deleted=yes
-- School (as reported): "ChildrenÃ•s Montessori Center"
-- Original: "ChildrenÃ•s Montessori Center"
-- Proposed: "ChildrenÕs Montessori Center"
UPDATE `schools` SET `schoolname` = CONVERT(X'4368696C6472656EC39573204D6F6E746573736F72692043656E746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14534 AND CAST(`schoolname` AS BINARY) = X'4368696C6472656EC383E280A273204D6F6E746573736F72692043656E746572';

-- Entry 6: school id 14606, column `headofschoolname`, deleted=no
-- School (as reported): "Canandaigua Montessori School"
-- Original: "Mrs.Grace PeÃ±a"
-- Proposed: "Mrs.Grace Peña"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D72732E4772616365205065C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14606 AND CAST(`headofschoolname` AS BINARY) = X'4D72732E4772616365205065C383C2B161';

-- Entry 7: school id 14700, column `infoemail`, deleted=no
-- School (as reported): "Penn-Mont Academy"
-- Original: "info@pennmontacademy.comÂ "
-- Decoded (before cleanup): "info@pennmontacademy.com "
-- Cleanup: replaced U+00A0 NO-BREAK SPACE with a normal space
-- Cleanup: removed spaces (not allowed in URLs/email addresses)
-- Proposed: "info@pennmontacademy.com"
UPDATE `schools` SET `infoemail` = CONVERT(X'696E666F4070656E6E6D6F6E7461636164656D792E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14700 AND CAST(`infoemail` AS BINARY) = X'696E666F4070656E6E6D6F6E7461636164656D792E636F6DC382C2A0';

-- Entry 8: school id 14710, column `web`, deleted=no
-- School (as reported): "Montessorischool Heerhugowaard"
-- Original: "montessorischool-hhw.nlâ€Ž"
-- Decoded (before cleanup): "montessorischool-hhw.nl‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessorischool-hhw.nl"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F72697363686F6F6C2D6868772E6E6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14710 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F72697363686F6F6C2D6868772E6E6CC3A2E282ACC5BD';

-- Entry 9: school id 14746, column `schoolname`, deleted=yes
-- School (as reported): "Himalayan Institute ChildrenÃ•s School"
-- Original: "Himalayan Institute ChildrenÃ•s School"
-- Proposed: "Himalayan Institute ChildrenÕs School"
UPDATE `schools` SET `schoolname` = CONVERT(X'48696D616C6179616E20496E73746974757465204368696C6472656EC39573205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14746 AND CAST(`schoolname` AS BINARY) = X'48696D616C6179616E20496E73746974757465204368696C6472656EC383E280A273205363686F6F6C';

-- Entry 10: school id 14778, column `schoolname`, deleted=yes
-- School (as reported): "Horsham Montessori ChildrenÃ•s House"
-- Original: "Horsham Montessori ChildrenÃ•s House"
-- Proposed: "Horsham Montessori ChildrenÕs House"
UPDATE `schools` SET `schoolname` = CONVERT(X'486F727368616D204D6F6E746573736F7269204368696C6472656EC3957320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 14778 AND CAST(`schoolname` AS BINARY) = X'486F727368616D204D6F6E746573736F7269204368696C6472656EC383E280A27320486F757365';

-- Entry 11: school id 15153, column `address1`, deleted=no
-- School (as reported): "Montessori-Verein Osterholz e.V."
-- Original: "c/o Lange StraÃŸe 89"
-- Proposed: "c/o Lange Straße 89"
UPDATE `schools` SET `address1` = CONVERT(X'632F6F204C616E67652053747261C39F65203839' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15153 AND CAST(`address1` AS BINARY) = X'632F6F204C616E67652053747261C383C5B865203839';

-- Entry 12: school id 15247, column `schoolname`, deleted=yes
-- School (as reported): "Honea Path Elementary Watkinsâ€Ž"
-- Original: "Honea Path Elementary Watkinsâ€Ž"
-- Decoded (before cleanup): "Honea Path Elementary Watkins‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "Honea Path Elementary Watkins"
UPDATE `schools` SET `schoolname` = CONVERT(X'486F6E6561205061746820456C656D656E74617279205761746B696E73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15247 AND CAST(`schoolname` AS BINARY) = X'486F6E6561205061746820456C656D656E74617279205761746B696E73C3A2E282ACC5BD';

-- Entry 13: school id 15329, column `address1`, deleted=yes
-- School (as reported): "La maison des enfants"
-- Original: "5 Bd FrÃ©dÃ©ric Mistral"
-- Proposed: "5 Bd Frédéric Mistral"
UPDATE `schools` SET `address1` = CONVERT(X'35204264204672C3A964C3A9726963204D69737472616C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15329 AND CAST(`address1` AS BINARY) = X'35204264204672C383C2A964C383C2A9726963204D69737472616C';

-- Entry 14: school id 15431, column `web`, deleted=no
-- School (as reported): "Orlando Montessori Bilingual Academy- Oviedo"
-- Original: "oviedomontessori.comâ€Ž"
-- Decoded (before cleanup): "oviedomontessori.com‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "oviedomontessori.com"
UPDATE `schools` SET `web` = CONVERT(X'6F766965646F6D6F6E746573736F72692E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15431 AND CAST(`web` AS BINARY) = X'6F766965646F6D6F6E746573736F72692E636F6DC3A2E282ACC5BD';

-- Entry 15: school id 15565, column `web`, deleted=no
-- School (as reported): "Montessori Preparatory School"
-- Original: "montessoriacademies.comâ€Ž"
-- Decoded (before cleanup): "montessoriacademies.com‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessoriacademies.com"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F726961636164656D6965732E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15565 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F726961636164656D6965732E636F6DC3A2E282ACC5BD';

-- Entry 16: school id 15617, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessori de Rennes"
-- Original: "Marie Franï¿½oise Crouan"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Marie Françoise Crouan"
UPDATE `schools` SET `contactname` = CONVERT(X'4D61726965204672616EC3A76F6973652043726F75616E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15617 AND CAST(`contactname` AS BINARY) = X'4D61726965204672616EC3AFC2BFC2BD6F6973652043726F75616E';

-- Entry 17: school id 15617, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori de Rennes"
-- Original: "Marie Franï¿½oise Crouan"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Marie Françoise Crouan"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D61726965204672616EC3A76F6973652043726F75616E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15617 AND CAST(`headofschoolname` AS BINARY) = X'4D61726965204672616EC3AFC2BFC2BD6F6973652043726F75616E';

-- Entry 18: school id 15624, column `city`, deleted=no
-- School (as reported): "Sozialdienst katholischer Frauen e.V. GieÃŸen"
-- Original: "GieÃŸen"
-- Proposed: "Gießen"
UPDATE `schools` SET `city` = CONVERT(X'476965C39F656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15624 AND CAST(`city` AS BINARY) = X'476965C383C5B8656E';

-- Entry 19: school id 15624, column `schoolname`, deleted=no
-- School (as reported): "Sozialdienst katholischer Frauen e.V. GieÃŸen"
-- Original: "Sozialdienst katholischer Frauen e.V. GieÃŸen"
-- Proposed: "Sozialdienst katholischer Frauen e.V. Gießen"
UPDATE `schools` SET `schoolname` = CONVERT(X'536F7A69616C6469656E7374206B6174686F6C6973636865722046726175656E20652E562E20476965C39F656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15624 AND CAST(`schoolname` AS BINARY) = X'536F7A69616C6469656E7374206B6174686F6C6973636865722046726175656E20652E562E20476965C383C5B8656E';

-- Entry 20: school id 15776, column `address1`, deleted=no
-- School (as reported): "Stadtische Montessori-Grundschule"
-- Original: "LindenstraÃŸe 102"
-- Proposed: "Lindenstraße 102"
UPDATE `schools` SET `address1` = CONVERT(X'4C696E64656E73747261C39F6520313032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15776 AND CAST(`address1` AS BINARY) = X'4C696E64656E73747261C383C5B86520313032';

-- Entry 21: school id 15813, column `address1`, deleted=no
-- School (as reported): "Don Bosco Grundschule mit Montessorizweig"
-- Original: "SalierstraÃŸe 37"
-- Proposed: "Salierstraße 37"
UPDATE `schools` SET `address1` = CONVERT(X'53616C69657273747261C39F65203337' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15813 AND CAST(`address1` AS BINARY) = X'53616C69657273747261C383C5B865203337';

-- Entry 22: school id 15813, column `city`, deleted=no
-- School (as reported): "Don Bosco Grundschule mit Montessorizweig"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15813 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 23: school id 15813, column `contactname`, deleted=no
-- School (as reported): "Don Bosco Grundschule mit Montessorizweig"
-- Original: "Birgitt KrÃ¤hling"
-- Proposed: "Birgitt Krähling"
UPDATE `schools` SET `contactname` = CONVERT(X'42697267697474204B72C3A4686C696E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15813 AND CAST(`contactname` AS BINARY) = X'42697267697474204B72C383C2A4686C696E67';

-- Entry 24: school id 15819, column `city`, deleted=no
-- School (as reported): "Katholischen Integrativen Montessori Kinderhaus St Theresia "
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15819 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 25: school id 15819, column `headofschoolname`, deleted=no
-- School (as reported): "Katholischen Integrativen Montessori Kinderhaus St Theresia "
-- Original: "Marion KÃ¶ntges-Spangler"
-- Proposed: "Marion Köntges-Spangler"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D6172696F6E204BC3B66E746765732D5370616E676C6572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15819 AND CAST(`headofschoolname` AS BINARY) = X'4D6172696F6E204BC383C2B66E746765732D5370616E676C6572';

-- Entry 26: school id 15820, column `address1`, deleted=no
-- School (as reported): "Pfarrei St. Maria Rosenkranz Pintgen Montessori Kinderhaus"
-- Original: "Roderbirkener StraÃŸe 19"
-- Proposed: "Roderbirkener Straße 19"
UPDATE `schools` SET `address1` = CONVERT(X'526F6465726269726B656E65722053747261C39F65203139' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15820 AND CAST(`address1` AS BINARY) = X'526F6465726269726B656E65722053747261C383C5B865203139';

-- Entry 27: school id 15820, column `city`, deleted=no
-- School (as reported): "Pfarrei St. Maria Rosenkranz Pintgen Montessori Kinderhaus"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15820 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 28: school id 15823, column `address1`, deleted=no
-- School (as reported): "Fritz-Henkel-Schule"
-- Original: "Stettiner StraÃŸe 98"
-- Proposed: "Stettiner Straße 98"
UPDATE `schools` SET `address1` = CONVERT(X'5374657474696E65722053747261C39F65203938' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15823 AND CAST(`address1` AS BINARY) = X'5374657474696E65722053747261C383C5B865203938';

-- Entry 29: school id 15823, column `city`, deleted=no
-- School (as reported): "Fritz-Henkel-Schule"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15823 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 30: school id 15825, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus St. MatthÃ¤us"
-- Original: "Carlo-Schmid-StraÃŸe 24"
-- Proposed: "Carlo-Schmid-Straße 24"
UPDATE `schools` SET `address1` = CONVERT(X'4361726C6F2D5363686D69642D53747261C39F65203234' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15825 AND CAST(`address1` AS BINARY) = X'4361726C6F2D5363686D69642D53747261C383C5B865203234';

-- Entry 31: school id 15825, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus St. MatthÃ¤us"
-- Original: "Montessori-Kinderhaus St. MatthÃ¤us"
-- Proposed: "Montessori-Kinderhaus St. Matthäus"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D4B696E646572686175732053742E204D61747468C3A47573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15825 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D4B696E646572686175732053742E204D61747468C383C2A47573';

-- Entry 32: school id 15836, column `address1`, deleted=no
-- School (as reported): "Montessori Kindergarten Mettmann e.V"
-- Original: "TeichstraÃŸe 6"
-- Proposed: "Teichstraße 6"
UPDATE `schools` SET `address1` = CONVERT(X'546569636873747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15836 AND CAST(`address1` AS BINARY) = X'546569636873747261C383C5B8652036';

-- Entry 33: school id 15859, column `address1`, deleted=yes
-- School (as reported): "Institut mÃ©dico pÃ©dagogique"
-- Original: "16 passage du prÃ© aux soeurs"
-- Proposed: "16 passage du pré aux soeurs"
UPDATE `schools` SET `address1` = CONVERT(X'31362070617373616765206475207072C3A92061757820736F65757273' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15859 AND CAST(`address1` AS BINARY) = X'31362070617373616765206475207072C383C2A92061757820736F65757273';

-- Entry 34: school id 15859, column `schoolname`, deleted=yes
-- School (as reported): "Institut mÃ©dico pÃ©dagogique"
-- Original: "Institut mÃ©dico pÃ©dagogique"
-- Proposed: "Institut médico pédagogique"
UPDATE `schools` SET `schoolname` = CONVERT(X'496E737469747574206DC3A96469636F2070C3A96461676F6769717565' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15859 AND CAST(`schoolname` AS BINARY) = X'496E737469747574206DC383C2A96469636F2070C383C2A96461676F6769717565';

-- Entry 35: school id 15936, column `schoolname`, deleted=yes
-- School (as reported): "Espace de soin psychothÃ©rapique d'Ã©ducation et de rÃ©insertion"
-- Original: "Espace de soin psychothÃ©rapique d'Ã©ducation et de rÃ©insertion"
-- Proposed: "Espace de soin psychothérapique d'éducation et de réinsertion"
UPDATE `schools` SET `schoolname` = CONVERT(X'45737061636520646520736F696E2070737963686F7468C3A972617069717565206427C3A96475636174696F6E2065742064652072C3A9696E73657274696F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15936 AND CAST(`schoolname` AS BINARY) = X'45737061636520646520736F696E2070737963686F7468C383C2A972617069717565206427C383C2A96475636174696F6E2065742064652072C383C2A9696E73657274696F6E';

-- Entry 36: school id 15995, column `address1`, deleted=no
-- School (as reported): "Elsa-BrÃ¤ndstrÃ¶m-Gymnasium"
-- Original: "Christian-Steger-StraÃŸe 11"
-- Proposed: "Christian-Steger-Straße 11"
UPDATE `schools` SET `address1` = CONVERT(X'43687269737469616E2D5374656765722D53747261C39F65203131' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15995 AND CAST(`address1` AS BINARY) = X'43687269737469616E2D5374656765722D53747261C383C5B865203131';

-- Entry 37: school id 15995, column `schoolname`, deleted=no
-- School (as reported): "Elsa-BrÃ¤ndstrÃ¶m-Gymnasium"
-- Original: "Elsa-BrÃ¤ndstrÃ¶m-Gymnasium"
-- Proposed: "Elsa-Brändström-Gymnasium"
UPDATE `schools` SET `schoolname` = CONVERT(X'456C73612D4272C3A46E64737472C3B66D2D47796D6E617369756D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 15995 AND CAST(`schoolname` AS BINARY) = X'456C73612D4272C383C2A46E64737472C383C2B66D2D47796D6E617369756D';

-- Entry 38: school id 16042, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus 1 - Moers-Asberg"
-- Original: "BonifatiusstraÃŸe 96"
-- Proposed: "Bonifatiusstraße 96"
UPDATE `schools` SET `address1` = CONVERT(X'426F6E6966617469757373747261C39F65203936' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16042 AND CAST(`address1` AS BINARY) = X'426F6E6966617469757373747261C383C5B865203936';

-- Entry 39: school id 16191, column `address1`, deleted=no
-- School (as reported): "Montessori Hauptschule"
-- Original: "BorsigstraÃŸe 13"
-- Proposed: "Borsigstraße 13"
UPDATE `schools` SET `address1` = CONVERT(X'426F7273696773747261C39F65203133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16191 AND CAST(`address1` AS BINARY) = X'426F7273696773747261C383C5B865203133';

-- Entry 40: school id 16191, column `city`, deleted=no
-- School (as reported): "Montessori Hauptschule"
-- Original: "KÃ¶ln"
-- Proposed: "Köln"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B66C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16191 AND CAST(`city` AS BINARY) = X'4BC383C2B66C6E';

-- Entry 41: school id 16208, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule ReumontstraÃŸe GGS"
-- Original: "Montessori-Schule ReumontstraÃŸe GGS"
-- Proposed: "Montessori-Schule Reumontstraße GGS"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C65205265756D6F6E7473747261C39F6520474753' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16208 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C65205265756D6F6E7473747261C383C5B86520474753';

-- Entry 42: school id 16225, column `address1`, deleted=no
-- School (as reported): "Montessori-Grundschule MatarÃ©straÃŸe Aachen"
-- Original: "MatarÃ©straÃŸe 11"
-- Proposed: "Mataréstraße 11"
UPDATE `schools` SET `address1` = CONVERT(X'4D61746172C3A973747261C39F65203131' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16225 AND CAST(`address1` AS BINARY) = X'4D61746172C383C2A973747261C383C5B865203131';

-- Entry 43: school id 16225, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Grundschule MatarÃ©straÃŸe Aachen"
-- Original: "Montessori-Grundschule MatarÃ©straÃŸe Aachen"
-- Proposed: "Montessori-Grundschule Mataréstraße Aachen"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D4772756E64736368756C65204D61746172C3A973747261C39F652041616368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16225 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D4772756E64736368756C65204D61746172C383C2A973747261C383C5B8652041616368656E';

-- Entry 44: school id 16234, column `address1`, deleted=no
-- School (as reported): "Montessori Elternverein Stolberg Regenbogen Kinderhaus"
-- Original: "Konrad-Adenauer-StraÃŸe 80-82"
-- Proposed: "Konrad-Adenauer-Straße 80-82"
UPDATE `schools` SET `address1` = CONVERT(X'4B6F6E7261642D4164656E617565722D53747261C39F652038302D3832' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16234 AND CAST(`address1` AS BINARY) = X'4B6F6E7261642D4164656E617565722D53747261C383C5B8652038302D3832';

-- Entry 45: school id 16271, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Oberpleis e.V."
-- Original: "Herresbacher StraÃŸe 6"
-- Proposed: "Herresbacher Straße 6"
UPDATE `schools` SET `address1` = CONVERT(X'4865727265736261636865722053747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16271 AND CAST(`address1` AS BINARY) = X'4865727265736261636865722053747261C383C5B8652036';

-- Entry 46: school id 16271, column `city`, deleted=no
-- School (as reported): "Montessori Kinderhaus Oberpleis e.V."
-- Original: "KÃ¶nigswinter"
-- Proposed: "Königswinter"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B66E69677377696E746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16271 AND CAST(`city` AS BINARY) = X'4BC383C2B66E69677377696E746572';

-- Entry 47: school id 16276, column `address1`, deleted=no
-- School (as reported): "Evangelishes Integrative Montessori Kinderhaus Wahlscheid"
-- Original: "DiemstraÃŸe 10"
-- Proposed: "Diemstraße 10"
UPDATE `schools` SET `address1` = CONVERT(X'4469656D73747261C39F65203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16276 AND CAST(`address1` AS BINARY) = X'4469656D73747261C383C5B865203130';

-- Entry 48: school id 16277, column `address1`, deleted=no
-- School (as reported): "Montessori Verein Troisdorf e. V."
-- Original: "HaberstraÃŸe 20"
-- Proposed: "Haberstraße 20"
UPDATE `schools` SET `address1` = CONVERT(X'486162657273747261C39F65203230' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16277 AND CAST(`address1` AS BINARY) = X'486162657273747261C383C5B865203230';

-- Entry 49: school id 16285, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Petrisberg"
-- Original: "Max-Planck-StraÃŸe 23"
-- Proposed: "Max-Planck-Straße 23"
UPDATE `schools` SET `address1` = CONVERT(X'4D61782D506C616E636B2D53747261C39F65203233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16285 AND CAST(`address1` AS BINARY) = X'4D61782D506C616E636B2D53747261C383C5B865203233';

-- Entry 50: school id 16631, column `address1`, deleted=no
-- School (as reported): "Les Pouces Verts"
-- Original: "131 allÃ©e du domaine (Castellaras)"
-- Proposed: "131 allée du domaine (Castellaras)"
UPDATE `schools` SET `address1` = CONVERT(X'31333120616C6CC3A96520647520646F6D61696E65202843617374656C6C6172617329' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16631 AND CAST(`address1` AS BINARY) = X'31333120616C6CC383C2A96520647520646F6D61696E65202843617374656C6C6172617329';

-- Entry 51: school id 16677, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus St. Mauritius"
-- Original: "MoltkestraÃŸe 33"
-- Proposed: "Moltkestraße 33"
UPDATE `schools` SET `address1` = CONVERT(X'4D6F6C746B6573747261C39F65203333' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16677 AND CAST(`address1` AS BINARY) = X'4D6F6C746B6573747261C383C5B865203333';

-- Entry 52: school id 16712, column `schoolname`, deleted=yes
-- School (as reported): "MozaÃ¯ek College Arnhem"
-- Original: "MozaÃ¯ek College Arnhem"
-- Proposed: "Mozaïek College Arnhem"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F7A61C3AF656B20436F6C6C6567652041726E68656D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16712 AND CAST(`schoolname` AS BINARY) = X'4D6F7A61C383C2AF656B20436F6C6C6567652041726E68656D';

-- Entry 53: school id 16727, column `address1`, deleted=no
-- School (as reported): "Montessori Zentrum Heidelberg e.V. - Turnerstrasse "
-- Original: "TurnerstaÃŸe 133"
-- Proposed: "Turnerstaße 133"
UPDATE `schools` SET `address1` = CONVERT(X'5475726E6572737461C39F6520313333' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16727 AND CAST(`address1` AS BINARY) = X'5475726E6572737461C383C5B86520313333';

-- Entry 54: school id 16770, column `address1`, deleted=no
-- School (as reported): "Montessori Kindergarten e.V"
-- Original: "KeÃŸlerweg 4"
-- Proposed: "Keßlerweg 4"
UPDATE `schools` SET `address1` = CONVERT(X'4B65C39F6C65727765672034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16770 AND CAST(`address1` AS BINARY) = X'4B65C383C5B86C65727765672034';

-- Entry 55: school id 16803, column `address1`, deleted=no
-- School (as reported): "Montessori PÃ¤dagogik Waiblingen e.V."
-- Original: "Im SÃ¤mann 88"
-- Proposed: "Im Sämann 88"
UPDATE `schools` SET `address1` = CONVERT(X'496D2053C3A46D616E6E203838' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16803 AND CAST(`address1` AS BINARY) = X'496D2053C383C2A46D616E6E203838';

-- Entry 56: school id 16803, column `schoolname`, deleted=no
-- School (as reported): "Montessori PÃ¤dagogik Waiblingen e.V."
-- Original: "Montessori PÃ¤dagogik Waiblingen e.V."
-- Proposed: "Montessori Pädagogik Waiblingen e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692050C3A46461676F67696B20576169626C696E67656E20652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16803 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692050C383C2A46461676F67696B20576169626C696E67656E20652E562E';

-- Entry 57: school id 16864, column `address1`, deleted=no
-- School (as reported): "Montessori-Schulle"
-- Original: "GartenstraÃŸe 25"
-- Proposed: "Gartenstraße 25"
UPDATE `schools` SET `address1` = CONVERT(X'47617274656E73747261C39F65203235' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16864 AND CAST(`address1` AS BINARY) = X'47617274656E73747261C383C5B865203235';

-- Entry 58: school id 16871, column `address1`, deleted=yes
-- School (as reported): "ECOLE MONTESSORI"
-- Original: "23 Rue St ExupÃ©ry"
-- Proposed: "23 Rue St Exupéry"
UPDATE `schools` SET `address1` = CONVERT(X'3233205275652053742045787570C3A97279' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16871 AND CAST(`address1` AS BINARY) = X'3233205275652053742045787570C383C2A97279';

-- Entry 59: school id 16875, column `address1`, deleted=yes
-- School (as reported): "The Bilingual Montessori School of Paris/ Mouffetard"
-- Original: "28 rue du Fer Ã  moulin"
-- Proposed: "28 rue du Fer à moulin"
UPDATE `schools` SET `address1` = CONVERT(X'3238207275652064752046657220C3A0206D6F756C696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16875 AND CAST(`address1` AS BINARY) = X'3238207275652064752046657220C383C2A0206D6F756C696E';

-- Entry 60: school id 16886, column `address1`, deleted=no
-- School (as reported): "Plaisir d'Enfance- Paris 19"
-- Original: "56/60 rue du PrÃ© St Gervais"
-- Proposed: "56/60 rue du Pré St Gervais"
UPDATE `schools` SET `address1` = CONVERT(X'35362F363020727565206475205072C3A92053742047657276616973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16886 AND CAST(`address1` AS BINARY) = X'35362F363020727565206475205072C383C2A92053742047657276616973';

-- Entry 61: school id 16966, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus Karlsruhe"
-- Original: "Mrs. LÃ¶rz"
-- Proposed: "Mrs. Lörz"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D72732E204CC3B6727A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 16966 AND CAST(`headofschoolname` AS BINARY) = X'4D72732E204CC383C2B6727A';

-- Entry 62: school id 17037, column `address1`, deleted=no
-- School (as reported): "Montessori Kindergarten"
-- Original: "6 rue RÃ©aumur"
-- Proposed: "6 rue Réaumur"
UPDATE `schools` SET `address1` = CONVERT(X'36207275652052C3A961756D7572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17037 AND CAST(`address1` AS BINARY) = X'36207275652052C383C2A961756D7572';

-- Entry 63: school id 17064, column `address1`, deleted=no
-- School (as reported): "Integratives Kinderhaus Maria Montessori Ottersweier "
-- Original: "HauptstraÃŸe 8"
-- Proposed: "Hauptstraße 8"
UPDATE `schools` SET `address1` = CONVERT(X'486175707473747261C39F652038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17064 AND CAST(`address1` AS BINARY) = X'486175707473747261C383C5B8652038';

-- Entry 64: school id 17068, column `schoolname`, deleted=no
-- School (as reported): "Ecole Saint BenoÃ®t"
-- Original: "Ecole Saint BenoÃ®t"
-- Proposed: "Ecole Saint Benoît"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65205361696E742042656E6FC3AE74' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17068 AND CAST(`schoolname` AS BINARY) = X'45636F6C65205361696E742042656E6FC383C2AE74';

-- Entry 65: school id 17096, column `schoolname`, deleted=yes
-- School (as reported): "Colegio Montessori Ã’Consuelo Zertouche De GarzaÃ“"
-- Original: "Colegio Montessori Ã’Consuelo Zertouche De GarzaÃ“"
-- Proposed: "Colegio Montessori ÒConsuelo Zertouche De GarzaÓ"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F204D6F6E746573736F726920C392436F6E7375656C6F205A6572746F75636865204465204761727A61C393' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17096 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F204D6F6E746573736F726920C383E28099436F6E7375656C6F205A6572746F75636865204465204761727A61C383E2809C';

-- Entry 66: school id 17105, column `contactname`, deleted=no
-- School (as reported): "Lycee International Montessori Bailly"
-- Original: "Sylvie d'Esclaibes and JoÃ«l Philippin"
-- Proposed: "Sylvie d'Esclaibes and Joël Philippin"
UPDATE `schools` SET `contactname` = CONVERT(X'53796C7669652064274573636C616962657320616E64204A6FC3AB6C205068696C697070696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17105 AND CAST(`contactname` AS BINARY) = X'53796C7669652064274573636C616962657320616E64204A6FC383C2AB6C205068696C697070696E';

-- Entry 67: school id 17105, column `headofschoolname`, deleted=no
-- School (as reported): "Lycee International Montessori Bailly"
-- Original: "Sylvie d'Esclaibes and JoÃ«l Philippin"
-- Proposed: "Sylvie d'Esclaibes and Joël Philippin"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'53796C7669652064274573636C616962657320616E64204A6FC3AB6C205068696C697070696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17105 AND CAST(`headofschoolname` AS BINARY) = X'53796C7669652064274573636C616962657320616E64204A6FC383C2AB6C205068696C697070696E';

-- Entry 68: school id 17125, column `city`, deleted=no
-- School (as reported): "Ecole Montessori Etre et DÃ©couvrir Maternelle et Elementaire"
-- Original: "Saint-Nom-la-BretÃ¨che"
-- Proposed: "Saint-Nom-la-Bretèche"
UPDATE `schools` SET `city` = CONVERT(X'5361696E742D4E6F6D2D6C612D42726574C3A8636865' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17125 AND CAST(`city` AS BINARY) = X'5361696E742D4E6F6D2D6C612D42726574C383C2A8636865';

-- Entry 69: school id 17125, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori Etre et DÃ©couvrir Maternelle et Elementaire"
-- Original: "Ecole Montessori Etre et DÃ©couvrir Maternelle et Elementaire"
-- Proposed: "Ecole Montessori Etre et Découvrir Maternelle et Elementaire"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920457472652065742044C3A9636F7576726972204D617465726E656C6C6520657420456C656D656E7461697265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17125 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920457472652065742044C383C2A9636F7576726972204D617465726E656C6C6520657420456C656D656E7461697265';

-- Entry 70: school id 17207, column `address1`, deleted=no
-- School (as reported): "English Montessori Preschool Kinder Center"
-- Original: "PerhamerstraÃŸe 49"
-- Proposed: "Perhamerstraße 49"
UPDATE `schools` SET `address1` = CONVERT(X'50657268616D657273747261C39F65203439' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17207 AND CAST(`address1` AS BINARY) = X'50657268616D657273747261C383C5B865203439';

-- Entry 71: school id 17218, column `address1`, deleted=no
-- School (as reported): "Campus di Monaco â€“ Internationale Montessorischule MÃ¼nchen"
-- Original: "SchwanthalerstraÃŸe 2"
-- Proposed: "Schwanthalerstraße 2"
UPDATE `schools` SET `address1` = CONVERT(X'53636877616E7468616C657273747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17218 AND CAST(`address1` AS BINARY) = X'53636877616E7468616C657273747261C383C5B8652032';

-- Entry 72: school id 17218, column `city`, deleted=no
-- School (as reported): "Campus di Monaco â€“ Internationale Montessorischule MÃ¼nchen"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17218 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 73: school id 17218, column `schoolname`, deleted=no
-- School (as reported): "Campus di Monaco â€“ Internationale Montessorischule MÃ¼nchen"
-- Original: "Campus di Monaco â€“ Internationale Montessorischule MÃ¼nchen"
-- Proposed: "Campus di Monaco – Internationale Montessorischule München"
UPDATE `schools` SET `schoolname` = CONVERT(X'43616D707573206469204D6F6E61636F20E2809320496E7465726E6174696F6E616C65204D6F6E746573736F7269736368756C65204DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17218 AND CAST(`schoolname` AS BINARY) = X'43616D707573206469204D6F6E61636F20C3A2E282ACE2809C20496E7465726E6174696F6E616C65204D6F6E746573736F7269736368756C65204DC383C2BC6E6368656E';

-- Entry 74: school id 17223, column `address1`, deleted=no
-- School (as reported): "Aktion Sonnenschein"
-- Original: "HeiglhofstraÃŸe 63"
-- Proposed: "Heiglhofstraße 63"
UPDATE `schools` SET `address1` = CONVERT(X'486569676C686F6673747261C39F65203633' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17223 AND CAST(`address1` AS BINARY) = X'486569676C686F6673747261C383C5B865203633';

-- Entry 75: school id 17223, column `city`, deleted=no
-- School (as reported): "Aktion Sonnenschein"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17223 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 76: school id 17238, column `address1`, deleted=no
-- School (as reported): "Montessori-Kindergarten MIA"
-- Original: "EspenstraÃŸe 1A"
-- Proposed: "Espenstraße 1A"
UPDATE `schools` SET `address1` = CONVERT(X'457370656E73747261C39F65203141' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17238 AND CAST(`address1` AS BINARY) = X'457370656E73747261C383C5B865203141';

-- Entry 77: school id 17238, column `city`, deleted=no
-- School (as reported): "Montessori-Kindergarten MIA"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17238 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 78: school id 17239, column `address1`, deleted=no
-- School (as reported): "Montessori Kindergarten Gauting e.V"
-- Original: "GrubmÃ¼hlerfeldstr. 32"
-- Proposed: "Grubmühlerfeldstr. 32"
UPDATE `schools` SET `address1` = CONVERT(X'477275626DC3BC686C657266656C647374722E203332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17239 AND CAST(`address1` AS BINARY) = X'477275626DC383C2BC686C657266656C647374722E203332';

-- Entry 79: school id 17241, column `schoolname`, deleted=no
-- School (as reported): "Montessori Association FÃ¼rstenfeldbruck e. V."
-- Original: "Montessori Association FÃ¼rstenfeldbruck e. V."
-- Proposed: "Montessori Association Fürstenfeldbruck e. V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204173736F63696174696F6E2046C3BC727374656E66656C64627275636B20652E20562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17241 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204173736F63696174696F6E2046C383C2BC727374656E66656C64627275636B20652E20562E';

-- Entry 80: school id 17244, column `city`, deleted=no
-- School (as reported): "Montessori Kinderhaus WÃ¶rthsee"
-- Original: "WÃ¶rthsee"
-- Proposed: "Wörthsee"
UPDATE `schools` SET `city` = CONVERT(X'57C3B6727468736565' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17244 AND CAST(`city` AS BINARY) = X'57C383C2B6727468736565';

-- Entry 81: school id 17244, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus WÃ¶rthsee"
-- Original: "Montessori Kinderhaus WÃ¶rthsee"
-- Proposed: "Montessori Kinderhaus Wörthsee"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E646572686175732057C3B6727468736565' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17244 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E646572686175732057C383C2B6727468736565';

-- Entry 82: school id 17245, column `schoolname`, deleted=no
-- School (as reported): "Montessori FÃ¶rdergemeinschaft Landkreis Starnberg e.V."
-- Original: "Montessori FÃ¶rdergemeinschaft Landkreis Starnberg e.V."
-- Proposed: "Montessori Fördergemeinschaft Landkreis Starnberg e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692046C3B67264657267656D65696E736368616674204C616E646B7265697320537461726E6265726720652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17245 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692046C383C2B67264657267656D65696E736368616674204C616E646B7265697320537461726E6265726720652E562E';

-- Entry 83: school id 17252, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Penzberg"
-- Original: "Seeshaupter StraÃŸe 32"
-- Proposed: "Seeshaupter Straße 32"
UPDATE `schools` SET `address1` = CONVERT(X'53656573686175707465722053747261C39F65203332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17252 AND CAST(`address1` AS BINARY) = X'53656573686175707465722053747261C383C5B865203332';

-- Entry 84: school id 17256, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Wolfratshausen e.V"
-- Original: "Ludwig-Thoma-StraÃŸe 7b"
-- Proposed: "Ludwig-Thoma-Straße 7b"
UPDATE `schools` SET `address1` = CONVERT(X'4C75647769672D54686F6D612D53747261C39F65203762' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17256 AND CAST(`address1` AS BINARY) = X'4C75647769672D54686F6D612D53747261C383C5B865203762';

-- Entry 85: school id 17345, column `address1`, deleted=no
-- School (as reported): "Montessori Zentrum Freising"
-- Original: "Gute Ã„nger 32"
-- Proposed: "Gute Änger 32"
UPDATE `schools` SET `address1` = CONVERT(X'4775746520C3846E676572203332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17345 AND CAST(`address1` AS BINARY) = X'4775746520C383E2809E6E676572203332';

-- Entry 86: school id 17372, column `city`, deleted=yes
-- School (as reported): "Montessori Kinderhaus"
-- Original: "Augsburg/Neus_Â§"
-- Proposed: "Augsburg/Neus_§"
UPDATE `schools` SET `city` = CONVERT(X'41756773627572672F4E6575735FC2A7' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17372 AND CAST(`city` AS BINARY) = X'41756773627572672F4E6575735FC382C2A7';

-- Entry 87: school id 17373, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Henisiuspark"
-- Original: "HenisiusstraÃŸe 1"
-- Proposed: "Henisiusstraße 1"
UPDATE `schools` SET `address1` = CONVERT(X'48656E697369757373747261C39F652031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17373 AND CAST(`address1` AS BINARY) = X'48656E697369757373747261C383C5B8652031';

-- Entry 88: school id 17373, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Henisiuspark"
-- Original: "Sabine HÃ¤ÃŸlein"
-- Proposed: "Sabine Häßlein"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'536162696E652048C3A4C39F6C65696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17373 AND CAST(`headofschoolname` AS BINARY) = X'536162696E652048C383C2A4C383C5B86C65696E';

-- Entry 89: school id 17382, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Dinkelscherban - Montessori Haus fÃ¼r Kinder"
-- Original: "BrunstÃ¤tter StraÃŸe 1"
-- Proposed: "Brunstätter Straße 1"
UPDATE `schools` SET `address1` = CONVERT(X'4272756E7374C3A4747465722053747261C39F652031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17382 AND CAST(`address1` AS BINARY) = X'4272756E7374C383C2A4747465722053747261C383C5B8652031';

-- Entry 90: school id 17382, column `schoolname`, deleted=no
-- School (as reported): "Montessori Schule Dinkelscherban - Montessori Haus fÃ¼r Kinder"
-- Original: "Montessori Schule Dinkelscherban - Montessori Haus fÃ¼r Kinder"
-- Proposed: "Montessori Schule Dinkelscherban - Montessori Haus für Kinder"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920536368756C652044696E6B656C736368657262616E202D204D6F6E746573736F726920486175732066C3BC72204B696E646572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17382 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920536368756C652044696E6B656C736368657262616E202D204D6F6E746573736F726920486175732066C383C2BC72204B696E646572';

-- Entry 91: school id 17426, column `schoolname`, deleted=no
-- School (as reported): "Montessori-PÃ¤dagogik in Ulm und Neu-Ulm"
-- Original: "Montessori-PÃ¤dagogik in Ulm und Neu-Ulm"
-- Proposed: "Montessori-Pädagogik in Ulm und Neu-Ulm"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D50C3A46461676F67696B20696E20556C6D20756E64204E65752D556C6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17426 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D50C383C2A46461676F67696B20696E20556C6D20756E64204E65752D556C6D';

-- Entry 92: school id 17514, column `contactname`, deleted=yes
-- School (as reported): "Jardin des Capucines"
-- Original: "VÃ©ronique PÃ©nanguer"
-- Proposed: "Véronique Pénanguer"
UPDATE `schools` SET `contactname` = CONVERT(X'56C3A9726F6E697175652050C3A96E616E67756572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17514 AND CAST(`contactname` AS BINARY) = X'56C383C2A9726F6E697175652050C383C2A96E616E67756572';

-- Entry 93: school id 17514, column `headofschoolname`, deleted=yes
-- School (as reported): "Jardin des Capucines"
-- Original: "VÃ©ronique PÃ©nanguer"
-- Proposed: "Véronique Pénanguer"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'56C3A9726F6E697175652050C3A96E616E67756572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17514 AND CAST(`headofschoolname` AS BINARY) = X'56C383C2A9726F6E697175652050C383C2A96E616E67756572';

-- Entry 94: school id 17521, column `address1`, deleted=no
-- School (as reported): "Integratives Montessori Kinderhaus Lauf / Simonshofen"
-- Original: "HutstraÃŸe 2"
-- Proposed: "Hutstraße 2"
UPDATE `schools` SET `address1` = CONVERT(X'48757473747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17521 AND CAST(`address1` AS BINARY) = X'48757473747261C383C5B8652032';

-- Entry 95: school id 17540, column `address1`, deleted=no
-- School (as reported): "Private Montessori-Schule des Montessori FÃ¶rderkreises Rothenburg o.d.T.e.V. in Neusitz- Primarstufe"
-- Original: "WaldstraÃŸe 15"
-- Proposed: "Waldstraße 15"
UPDATE `schools` SET `address1` = CONVERT(X'57616C6473747261C39F65203135' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17540 AND CAST(`address1` AS BINARY) = X'57616C6473747261C383C5B865203135';

-- Entry 96: school id 17540, column `schoolname`, deleted=no
-- School (as reported): "Private Montessori-Schule des Montessori FÃ¶rderkreises Rothenburg o.d.T.e.V. in Neusitz- Primarstufe"
-- Original: "Private Montessori-Schule des Montessori FÃ¶rderkreises Rothenburg o.d.T.e.V. in Neusitz- Primarstufe"
-- Proposed: "Private Montessori-Schule des Montessori Förderkreises Rothenburg o.d.T.e.V. in Neusitz- Primarstufe"
UPDATE `schools` SET `schoolname` = CONVERT(X'50726976617465204D6F6E746573736F72692D536368756C6520646573204D6F6E746573736F72692046C3B6726465726B72656973657320526F7468656E62757267206F2E642E542E652E562E20696E204E65757369747A2D205072696D61727374756665' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17540 AND CAST(`schoolname` AS BINARY) = X'50726976617465204D6F6E746573736F72692D536368756C6520646573204D6F6E746573736F72692046C383C2B6726465726B72656973657320526F7468656E62757267206F2E642E542E652E562E20696E204E65757369747A2D205072696D61727374756665';

-- Entry 97: school id 17584, column `address1`, deleted=yes
-- School (as reported): "Centro Pre escolar Montessori"
-- Original: "Ave AndalucÃ­a 622"
-- Proposed: "Ave Andalucía 622"
UPDATE `schools` SET `address1` = CONVERT(X'41766520416E64616C7563C3AD6120363232' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17584 AND CAST(`address1` AS BINARY) = X'41766520416E64616C7563C383C2AD6120363232';

-- Entry 98: school id 17618, column `schoolname`, deleted=yes
-- School (as reported): "Ecole Montessori Sainte AgnÃ¨s"
-- Original: "Ecole Montessori Sainte AgnÃ¨s"
-- Proposed: "Ecole Montessori Sainte Agnès"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F7269205361696E74652041676EC3A873' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17618 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F7269205361696E74652041676EC383C2A873';

-- Entry 99: school id 17619, column `address1`, deleted=yes
-- School (as reported): "Jardin d'enfant Montessori"
-- Original: "87 rue de SÃ¨vres"
-- Proposed: "87 rue de Sèvres"
UPDATE `schools` SET `address1` = CONVERT(X'3837207275652064652053C3A876726573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17619 AND CAST(`address1` AS BINARY) = X'3837207275652064652053C383C2A876726573';

-- Entry 100: school id 17739, column `address1`, deleted=no
-- School (as reported): "Magdalena â€¢ von Mensch zu Mensch!"
-- Original: "MÃ¼nstererstraÃŸe 9a"
-- Proposed: "Münstererstraße 9a"
UPDATE `schools` SET `address1` = CONVERT(X'4DC3BC6E73746572657273747261C39F65203961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17739 AND CAST(`address1` AS BINARY) = X'4DC383C2BC6E73746572657273747261C383C5B865203961';

-- Entry 101: school id 17739, column `schoolname`, deleted=no
-- School (as reported): "Magdalena â€¢ von Mensch zu Mensch!"
-- Original: "Magdalena â€¢ von Mensch zu Mensch!"
-- Proposed: "Magdalena • von Mensch zu Mensch!"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D616764616C656E6120E280A220766F6E204D656E736368207A75204D656E73636821' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17739 AND CAST(`schoolname` AS BINARY) = X'4D616764616C656E6120C3A2E282ACC2A220766F6E204D656E736368207A75204D656E73636821';

-- Entry 102: school id 17803, column `schoolname`, deleted=yes
-- School (as reported): "EMP Union pour le Defense de la SantÃ© Mentale"
-- Original: "EMP Union pour le Defense de la SantÃ© Mentale"
-- Proposed: "EMP Union pour le Defense de la Santé Mentale"
UPDATE `schools` SET `schoolname` = CONVERT(X'454D5020556E696F6E20706F7572206C6520446566656E7365206465206C612053616E74C3A9204D656E74616C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17803 AND CAST(`schoolname` AS BINARY) = X'454D5020556E696F6E20706F7572206C6520446566656E7365206465206C612053616E74C383C2A9204D656E74616C65';

-- Entry 103: school id 17822, column `city`, deleted=no
-- School (as reported): "Ecole Bilingue Montessori du Val de Marne"
-- Original: "Saint Maur des FossÃ©s"
-- Proposed: "Saint Maur des Fossés"
UPDATE `schools` SET `city` = CONVERT(X'5361696E74204D6175722064657320466F7373C3A973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17822 AND CAST(`city` AS BINARY) = X'5361696E74204D6175722064657320466F7373C383C2A973';

-- Entry 104: school id 17965, column `schoolname`, deleted=yes
-- School (as reported): "ComunitÃ  Infantile Maria Montessori di Grazia Privitera"
-- Original: "ComunitÃ  Infantile Maria Montessori di Grazia Privitera"
-- Proposed: "Comunità Infantile Maria Montessori di Grazia Privitera"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6D756E6974C3A020496E66616E74696C65204D61726961204D6F6E746573736F7269206469204772617A696120507269766974657261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 17965 AND CAST(`schoolname` AS BINARY) = X'436F6D756E6974C383C2A020496E66616E74696C65204D61726961204D6F6E746573736F7269206469204772617A696120507269766974657261';

-- Entry 105: school id 18125, column `schoolname`, deleted=no
-- School (as reported): "Evanglische Montessori Kindertagesstï¿½tte Katharina-Gundrum-Haus"
-- Original: "Evanglische Montessori Kindertagesstï¿½tte Katharina-Gundrum-Haus"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Evanglische Montessori Kindertagesstätte Katharina-Gundrum-Haus"
UPDATE `schools` SET `schoolname` = CONVERT(X'4576616E676C6973636865204D6F6E746573736F7269204B696E64657274616765737374C3A4747465204B6174686172696E612D47756E6472756D2D48617573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18125 AND CAST(`schoolname` AS BINARY) = X'4576616E676C6973636865204D6F6E746573736F7269204B696E64657274616765737374C3AFC2BFC2BD747465204B6174686172696E612D47756E6472756D2D48617573';

-- Entry 106: school id 18292, column `address1`, deleted=yes
-- School (as reported): "Bishop Hamilton Montessori School"
-- Original: "2199 Regency Terrace â€¨"
-- Decoded (before cleanup): "2199 Regency Terrace  "
-- Cleanup: replaced U+2028 LINE SEPARATOR with a normal space
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "2199 Regency Terrace"
UPDATE `schools` SET `address1` = CONVERT(X'3231393920526567656E63792054657272616365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18292 AND CAST(`address1` AS BINARY) = X'3231393920526567656E6379205465727261636520C3A2E282ACC2A8';

-- Entry 107: school id 18449, column `schoolname`, deleted=yes
-- School (as reported): "Harbour View ElementaryÂ "
-- Original: "Harbour View ElementaryÂ "
-- Decoded (before cleanup): "Harbour View Elementary "
-- Cleanup: replaced U+00A0 NO-BREAK SPACE with a normal space
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Harbour View Elementary"
UPDATE `schools` SET `schoolname` = CONVERT(X'486172626F7572205669657720456C656D656E74617279' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18449 AND CAST(`schoolname` AS BINARY) = X'486172626F7572205669657720456C656D656E74617279C382C2A0';

-- Entry 108: school id 18464, column `schoolname`, deleted=yes
-- School (as reported): "Roots and WingsÂ Montessori School"
-- Original: "Roots and WingsÂ Montessori School"
-- Decoded (before cleanup): "Roots and Wings Montessori School"
-- Cleanup: replaced U+00A0 NO-BREAK SPACE with a normal space
-- Proposed: "Roots and Wings Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'526F6F747320616E642057696E6773204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18464 AND CAST(`schoolname` AS BINARY) = X'526F6F747320616E642057696E6773C382C2A04D6F6E746573736F7269205363686F6F6C';

-- Entry 109: school id 18554, column `zippostal`, deleted=no
-- School (as reported): "St. Helena Montessori School"
-- Original: "94574 â€Ž"
-- Decoded (before cleanup): "94574 ‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "94574"
UPDATE `schools` SET `zippostal` = CONVERT(X'3934353734' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18554 AND CAST(`zippostal` AS BINARY) = X'393435373420C3A2E282ACC5BD';

-- Entry 110: school id 18682, column `city`, deleted=yes
-- School (as reported): "PrÃ©maternelle Montessori de Charlesbourg"
-- Original: "QuÃ©bec"
-- Proposed: "Québec"
UPDATE `schools` SET `city` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18682 AND CAST(`city` AS BINARY) = X'5175C383C2A9626563';

-- Entry 111: school id 18682, column `schoolname`, deleted=yes
-- School (as reported): "PrÃ©maternelle Montessori de Charlesbourg"
-- Original: "PrÃ©maternelle Montessori de Charlesbourg"
-- Proposed: "Prématernelle Montessori de Charlesbourg"
UPDATE `schools` SET `schoolname` = CONVERT(X'5072C3A96D617465726E656C6C65204D6F6E746573736F726920646520436861726C6573626F757267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18682 AND CAST(`schoolname` AS BINARY) = X'5072C383C2A96D617465726E656C6C65204D6F6E746573736F726920646520436861726C6573626F757267';

-- Entry 112: school id 18684, column `schoolname`, deleted=yes
-- School (as reported): "Ecole PrÃ©maternelle Maternelle Et Primaire Montessori"
-- Original: "Ecole PrÃ©maternelle Maternelle Et Primaire Montessori"
-- Proposed: "Ecole Prématernelle Maternelle Et Primaire Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65205072C3A96D617465726E656C6C65204D617465726E656C6C65204574205072696D61697265204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18684 AND CAST(`schoolname` AS BINARY) = X'45636F6C65205072C383C2A96D617465726E656C6C65204D617465726E656C6C65204574205072696D61697265204D6F6E746573736F7269';

-- Entry 113: school id 18686, column `city`, deleted=yes
-- School (as reported): "Ecole PrÃ©maternelle Maternelle Et Primaire Montessori "
-- Original: "QuÃ©bec"
-- Proposed: "Québec"
UPDATE `schools` SET `city` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18686 AND CAST(`city` AS BINARY) = X'5175C383C2A9626563';

-- Entry 114: school id 18686, column `schoolname`, deleted=yes
-- School (as reported): "Ecole PrÃ©maternelle Maternelle Et Primaire Montessori "
-- Original: "Ecole PrÃ©maternelle Maternelle Et Primaire Montessori "
-- Decoded (before cleanup): "Ecole Prématernelle Maternelle Et Primaire Montessori "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Ecole Prématernelle Maternelle Et Primaire Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65205072C3A96D617465726E656C6C65204D617465726E656C6C65204574205072696D61697265204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18686 AND CAST(`schoolname` AS BINARY) = X'45636F6C65205072C383C2A96D617465726E656C6C65204D617465726E656C6C65204574205072696D61697265204D6F6E746573736F726920';

-- Entry 115: school id 18687, column `address1`, deleted=yes
-- School (as reported): "Centre de la Petite Enfance Montessori de QuÃ©bec "
-- Original: "107 Rue de L'AbbÃ©-Pierre"
-- Proposed: "107 Rue de L'Abbé-Pierre"
UPDATE `schools` SET `address1` = CONVERT(X'31303720527565206465204C27416262C3A92D506965727265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18687 AND CAST(`address1` AS BINARY) = X'31303720527565206465204C27416262C383C2A92D506965727265';

-- Entry 116: school id 18687, column `city`, deleted=yes
-- School (as reported): "Centre de la Petite Enfance Montessori de QuÃ©bec "
-- Original: "QuÃ©bec"
-- Proposed: "Québec"
UPDATE `schools` SET `city` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18687 AND CAST(`city` AS BINARY) = X'5175C383C2A9626563';

-- Entry 117: school id 18687, column `schoolname`, deleted=yes
-- School (as reported): "Centre de la Petite Enfance Montessori de QuÃ©bec "
-- Original: "Centre de la Petite Enfance Montessori de QuÃ©bec "
-- Decoded (before cleanup): "Centre de la Petite Enfance Montessori de Québec "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Centre de la Petite Enfance Montessori de Québec"
UPDATE `schools` SET `schoolname` = CONVERT(X'43656E747265206465206C612050657469746520456E66616E6365204D6F6E746573736F7269206465205175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18687 AND CAST(`schoolname` AS BINARY) = X'43656E747265206465206C612050657469746520456E66616E6365204D6F6E746573736F7269206465205175C383C2A962656320';

-- Entry 118: school id 18688, column `schoolname`, deleted=yes
-- School (as reported): "Ecole PrÃ©maternelle Et Maternelle Montessori De Lac Beauport "
-- Original: "Ecole PrÃ©maternelle Et Maternelle Montessori De Lac Beauport "
-- Decoded (before cleanup): "Ecole Prématernelle Et Maternelle Montessori De Lac Beauport "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Ecole Prématernelle Et Maternelle Montessori De Lac Beauport"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65205072C3A96D617465726E656C6C65204574204D617465726E656C6C65204D6F6E746573736F7269204465204C61632042656175706F7274' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18688 AND CAST(`schoolname` AS BINARY) = X'45636F6C65205072C383C2A96D617465726E656C6C65204574204D617465726E656C6C65204D6F6E746573736F7269204465204C61632042656175706F727420';

-- Entry 119: school id 18868, column `schoolname`, deleted=no
-- School (as reported): "Colegio Ãgora"
-- Original: "Colegio Ãgora"
-- Proposed: "Colegio Ágora"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F20C381676F7261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18868 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F20C383C281676F7261';

-- Entry 120: school id 18873, column `city`, deleted=yes
-- School (as reported): "ColÃ©gio Agostinho"
-- Original: "CarapicuÃ­ba"
-- Proposed: "Carapicuíba"
UPDATE `schools` SET `city` = CONVERT(X'4361726170696375C3AD6261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18873 AND CAST(`city` AS BINARY) = X'4361726170696375C383C2AD6261';

-- Entry 121: school id 18873, column `schoolname`, deleted=yes
-- School (as reported): "ColÃ©gio Agostinho"
-- Original: "ColÃ©gio Agostinho"
-- Proposed: "Colégio Agostinho"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6CC3A967696F2041676F7374696E686F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18873 AND CAST(`schoolname` AS BINARY) = X'436F6CC383C2A967696F2041676F7374696E686F';

-- Entry 122: school id 18874, column `address1`, deleted=yes
-- School (as reported): "Constructor Sui"
-- Original: "Rua MarquÃªs de SÃ£o Vicente, 455"
-- Proposed: "Rua Marquês de São Vicente, 455"
UPDATE `schools` SET `address1` = CONVERT(X'527561204D61727175C3AA732064652053C3A36F20566963656E74652C20343535' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18874 AND CAST(`address1` AS BINARY) = X'527561204D61727175C383C2AA732064652053C383C2A36F20566963656E74652C20343535';

-- Entry 123: school id 18876, column `schoolname`, deleted=no
-- School (as reported): "Escola da CrianÃ§a Ativa"
-- Original: "Escola da CrianÃ§a Ativa"
-- Proposed: "Escola da Criança Ativa"
UPDATE `schools` SET `schoolname` = CONVERT(X'4573636F6C6120646120437269616EC3A761204174697661' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18876 AND CAST(`schoolname` AS BINARY) = X'4573636F6C6120646120437269616EC383C2A761204174697661';

-- Entry 124: school id 18878, column `schoolname`, deleted=yes
-- School (as reported): "EspaÃ§o Livre"
-- Original: "EspaÃ§o Livre"
-- Proposed: "Espaço Livre"
UPDATE `schools` SET `schoolname` = CONVERT(X'45737061C3A76F204C69767265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18878 AND CAST(`schoolname` AS BINARY) = X'45737061C383C2A76F204C69767265';

-- Entry 125: school id 18879, column `city`, deleted=yes
-- School (as reported): "Estrelinha do Mar"
-- Original: "CapÃ£o da Canoa"
-- Proposed: "Capão da Canoa"
UPDATE `schools` SET `city` = CONVERT(X'436170C3A36F2064612043616E6F61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18879 AND CAST(`city` AS BINARY) = X'436170C383C2A36F2064612043616E6F61';

-- Entry 126: school id 18881, column `address1`, deleted=yes
-- School (as reported): "ColÃ©gio Maria Montessori"
-- Original: "Rua JoÃ£o Paulo I, 30"
-- Proposed: "Rua João Paulo I, 30"
UPDATE `schools` SET `address1` = CONVERT(X'527561204A6FC3A36F205061756C6F20492C203330' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18881 AND CAST(`address1` AS BINARY) = X'527561204A6FC383C2A36F205061756C6F20492C203330';

-- Entry 127: school id 18881, column `city`, deleted=yes
-- School (as reported): "ColÃ©gio Maria Montessori"
-- Original: "MaceiÃ³"
-- Proposed: "Maceió"
UPDATE `schools` SET `city` = CONVERT(X'4D61636569C3B3' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18881 AND CAST(`city` AS BINARY) = X'4D61636569C383C2B3';

-- Entry 128: school id 18881, column `schoolname`, deleted=yes
-- School (as reported): "ColÃ©gio Maria Montessori"
-- Original: "ColÃ©gio Maria Montessori"
-- Proposed: "Colégio Maria Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6CC3A967696F204D61726961204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18881 AND CAST(`schoolname` AS BINARY) = X'436F6CC383C2A967696F204D61726961204D6F6E746573736F7269';

-- Entry 129: school id 18883, column `city`, deleted=yes
-- School (as reported): "Escola Maria Montessori"
-- Original: "BrasÃ­lia"
-- Proposed: "Brasília"
UPDATE `schools` SET `city` = CONVERT(X'42726173C3AD6C6961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18883 AND CAST(`city` AS BINARY) = X'42726173C383C2AD6C6961';

-- Entry 130: school id 18888, column `address1`, deleted=yes
-- School (as reported): "Campus da EducaÃ§Ã£o Integrada Escola Mundo Infantil"
-- Original: "Rua CÃ´nego Jacinto, 10"
-- Proposed: "Rua Cônego Jacinto, 10"
UPDATE `schools` SET `address1` = CONVERT(X'5275612043C3B46E65676F204A6163696E746F2C203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18888 AND CAST(`address1` AS BINARY) = X'5275612043C383C2B46E65676F204A6163696E746F2C203130';

-- Entry 131: school id 18888, column `city`, deleted=yes
-- School (as reported): "Campus da EducaÃ§Ã£o Integrada Escola Mundo Infantil"
-- Original: "JequiÃ©"
-- Proposed: "Jequié"
UPDATE `schools` SET `city` = CONVERT(X'4A65717569C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18888 AND CAST(`city` AS BINARY) = X'4A65717569C383C2A9';

-- Entry 132: school id 18888, column `schoolname`, deleted=yes
-- School (as reported): "Campus da EducaÃ§Ã£o Integrada Escola Mundo Infantil"
-- Original: "Campus da EducaÃ§Ã£o Integrada Escola Mundo Infantil"
-- Proposed: "Campus da Educação Integrada Escola Mundo Infantil"
UPDATE `schools` SET `schoolname` = CONVERT(X'43616D707573206461204564756361C3A7C3A36F20496E74656772616461204573636F6C61204D756E646F20496E66616E74696C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18888 AND CAST(`schoolname` AS BINARY) = X'43616D707573206461204564756361C383C2A7C383C2A36F20496E74656772616461204573636F6C61204D756E646F20496E66616E74696C';

-- Entry 133: school id 18892, column `schoolname`, deleted=yes
-- School (as reported): "Escola Montessoriana ParaÃ­so da CrianÃ§a "
-- Original: "Escola Montessoriana ParaÃ­so da CrianÃ§a "
-- Decoded (before cleanup): "Escola Montessoriana Paraíso da Criança "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Escola Montessoriana Paraíso da Criança"
UPDATE `schools` SET `schoolname` = CONVERT(X'4573636F6C61204D6F6E746573736F7269616E612050617261C3AD736F20646120437269616EC3A761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18892 AND CAST(`schoolname` AS BINARY) = X'4573636F6C61204D6F6E746573736F7269616E612050617261C383C2AD736F20646120437269616EC383C2A76120';

-- Entry 134: school id 18893, column `schoolname`, deleted=yes
-- School (as reported): "Escola Recanto do Pequeno PrÃ­ncipe"
-- Original: "Escola Recanto do Pequeno PrÃ­ncipe"
-- Proposed: "Escola Recanto do Pequeno Príncipe"
UPDATE `schools` SET `schoolname` = CONVERT(X'4573636F6C6120526563616E746F20646F2050657175656E6F205072C3AD6E63697065' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18893 AND CAST(`schoolname` AS BINARY) = X'4573636F6C6120526563616E746F20646F2050657175656E6F205072C383C2AD6E63697065';

-- Entry 135: school id 18894, column `city`, deleted=yes
-- School (as reported): "Comunidade Educativa O Mundo do Peteleco"
-- Original: "BelÃ©m"
-- Proposed: "Belém"
UPDATE `schools` SET `city` = CONVERT(X'42656CC3A96D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18894 AND CAST(`city` AS BINARY) = X'42656CC383C2A96D';

-- Entry 136: school id 18895, column `address1`, deleted=yes
-- School (as reported): "Jardim de InfÃ¢ncia Pirralho"
-- Original: "Rua Fernandes LeÃ£o, 114"
-- Proposed: "Rua Fernandes Leão, 114"
UPDATE `schools` SET `address1` = CONVERT(X'527561204665726E616E646573204C65C3A36F2C20313134' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18895 AND CAST(`address1` AS BINARY) = X'527561204665726E616E646573204C65C383C2A36F2C20313134';

-- Entry 137: school id 18895, column `schoolname`, deleted=yes
-- School (as reported): "Jardim de InfÃ¢ncia Pirralho"
-- Original: "Jardim de InfÃ¢ncia Pirralho"
-- Proposed: "Jardim de Infância Pirralho"
UPDATE `schools` SET `schoolname` = CONVERT(X'4A617264696D20646520496E66C3A26E6369612050697272616C686F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18895 AND CAST(`schoolname` AS BINARY) = X'4A617264696D20646520496E66C383C2A26E6369612050697272616C686F';

-- Entry 138: school id 18896, column `city`, deleted=yes
-- School (as reported): "Prima- Escola Montessori de SÃ£o Paulo"
-- Original: "SÃ£o Paulo"
-- Proposed: "São Paulo"
UPDATE `schools` SET `city` = CONVERT(X'53C3A36F205061756C6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18896 AND CAST(`city` AS BINARY) = X'53C383C2A36F205061756C6F';

-- Entry 139: school id 18896, column `schoolname`, deleted=yes
-- School (as reported): "Prima- Escola Montessori de SÃ£o Paulo"
-- Original: "Prima- Escola Montessori de SÃ£o Paulo"
-- Proposed: "Prima- Escola Montessori de São Paulo"
UPDATE `schools` SET `schoolname` = CONVERT(X'5072696D612D204573636F6C61204D6F6E746573736F72692064652053C3A36F205061756C6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18896 AND CAST(`schoolname` AS BINARY) = X'5072696D612D204573636F6C61204D6F6E746573736F72692064652053C383C2A36F205061756C6F';

-- Entry 140: school id 18897, column `address1`, deleted=yes
-- School (as reported): "Escola PrÃ³-Saber"
-- Original: "Rua FiladÃ©lfia, 106"
-- Proposed: "Rua Filadélfia, 106"
UPDATE `schools` SET `address1` = CONVERT(X'5275612046696C6164C3A96C6669612C20313036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18897 AND CAST(`address1` AS BINARY) = X'5275612046696C6164C383C2A96C6669612C20313036';

-- Entry 141: school id 18897, column `schoolname`, deleted=yes
-- School (as reported): "Escola PrÃ³-Saber"
-- Original: "Escola PrÃ³-Saber"
-- Proposed: "Escola Pró-Saber"
UPDATE `schools` SET `schoolname` = CONVERT(X'4573636F6C61205072C3B32D5361626572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18897 AND CAST(`schoolname` AS BINARY) = X'4573636F6C61205072C383C2B32D5361626572';

-- Entry 142: school id 18898, column `city`, deleted=yes
-- School (as reported): "Centro Infantil Reino Encantado"
-- Original: "Brasiï¿½lia"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Brasília"
UPDATE `schools` SET `city` = CONVERT(X'42726173C3AD6C6961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18898 AND CAST(`city` AS BINARY) = X'4272617369C3AFC2BFC2BD6C6961';

-- Entry 143: school id 18899, column `address1`, deleted=yes
-- School (as reported): "Centro educacional Montessoriano Reino Infantil"
-- Original: "Rua do Sapoti, q. 113, 01 RenascenÃ§a II"
-- Proposed: "Rua do Sapoti, q. 113, 01 Renascença II"
UPDATE `schools` SET `address1` = CONVERT(X'52756120646F205361706F74692C20712E203131332C2030312052656E617363656EC3A761204949' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18899 AND CAST(`address1` AS BINARY) = X'52756120646F205361706F74692C20712E203131332C2030312052656E617363656EC383C2A761204949';

-- Entry 144: school id 18899, column `city`, deleted=yes
-- School (as reported): "Centro educacional Montessoriano Reino Infantil"
-- Original: "SÃ£o Luiz"
-- Proposed: "São Luiz"
UPDATE `schools` SET `city` = CONVERT(X'53C3A36F204C75697A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18899 AND CAST(`city` AS BINARY) = X'53C383C2A36F204C75697A';

-- Entry 145: school id 18900, column `city`, deleted=yes
-- School (as reported): "ColÃ©gio Santo agostinho"
-- Original: "IpiaÃº"
-- Proposed: "Ipiaú"
UPDATE `schools` SET `city` = CONVERT(X'49706961C3BA' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18900 AND CAST(`city` AS BINARY) = X'49706961C383C2BA';

-- Entry 146: school id 18900, column `schoolname`, deleted=yes
-- School (as reported): "ColÃ©gio Santo agostinho"
-- Original: "ColÃ©gio Santo agostinho"
-- Proposed: "Colégio Santo agostinho"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6CC3A967696F2053616E746F2061676F7374696E686F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18900 AND CAST(`schoolname` AS BINARY) = X'436F6CC383C2A967696F2053616E746F2061676F7374696E686F';

-- Entry 147: school id 18901, column `schoolname`, deleted=yes
-- School (as reported): "ColÃ©gio Sigma"
-- Original: "ColÃ©gio Sigma"
-- Proposed: "Colégio Sigma"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6CC3A967696F205369676D61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18901 AND CAST(`schoolname` AS BINARY) = X'436F6CC383C2A967696F205369676D61';

-- Entry 148: school id 18903, column `address1`, deleted=yes
-- School (as reported): "Centro de Ensino Upaon-AÃ§u"
-- Original: "Al. D, 5, loteamento Quitandinha, Alto Calhau   SÃ£o LuÃ­s"
-- Proposed: "Al. D, 5, loteamento Quitandinha, Alto Calhau   São Luís"
UPDATE `schools` SET `address1` = CONVERT(X'416C2E20442C20352C206C6F7465616D656E746F2051756974616E64696E68612C20416C746F2043616C68617520202053C3A36F204C75C3AD73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18903 AND CAST(`address1` AS BINARY) = X'416C2E20442C20352C206C6F7465616D656E746F2051756974616E64696E68612C20416C746F2043616C68617520202053C383C2A36F204C75C383C2AD73';

-- Entry 149: school id 18903, column `schoolname`, deleted=yes
-- School (as reported): "Centro de Ensino Upaon-AÃ§u"
-- Original: "Centro de Ensino Upaon-AÃ§u"
-- Proposed: "Centro de Ensino Upaon-Açu"
UPDATE `schools` SET `schoolname` = CONVERT(X'43656E74726F20646520456E73696E6F205570616F6E2D41C3A775' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 18903 AND CAST(`schoolname` AS BINARY) = X'43656E74726F20646520456E73696E6F205570616F6E2D41C383C2A775';

-- Entry 150: school id 19159, column `schoolname`, deleted=yes
-- School (as reported): "Sunshine Montessori School-Stratford Campusâ€Ž"
-- Original: "Sunshine Montessori School-Stratford Campusâ€Ž"
-- Decoded (before cleanup): "Sunshine Montessori School-Stratford Campus‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "Sunshine Montessori School-Stratford Campus"
UPDATE `schools` SET `schoolname` = CONVERT(X'53756E7368696E65204D6F6E746573736F7269205363686F6F6C2D5374726174666F72642043616D707573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19159 AND CAST(`schoolname` AS BINARY) = X'53756E7368696E65204D6F6E746573736F7269205363686F6F6C2D5374726174666F72642043616D707573C3A2E282ACC5BD';

-- Entry 151: school id 19258, column `address2`, deleted=no
-- School (as reported): "Kinderworld Montessori ï¿½ Puri Indah"
-- Original: "Jl. Pulau Kelor Blok A2 ï¿½ 5, Taman Permata Buana"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Jl. Pulau Kelor Blok A2 No. 5, Taman Permata Buana"
UPDATE `schools` SET `address2` = CONVERT(X'4A6C2E2050756C6175204B656C6F7220426C6F6B204132204E6F2E20352C2054616D616E205065726D617461204275616E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19258 AND CAST(`address2` AS BINARY) = X'4A6C2E2050756C6175204B656C6F7220426C6F6B20413220C3AFC2BFC2BD20352C2054616D616E205065726D617461204275616E61';

-- Entry 152: school id 19258, column `schoolname`, deleted=no
-- School (as reported): "Kinderworld Montessori ï¿½ Puri Indah"
-- Original: "Kinderworld Montessori ï¿½ Puri Indah"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Kinderworld Montessori Puri Indah"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B696E646572776F726C64204D6F6E746573736F7269205075726920496E646168' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19258 AND CAST(`schoolname` AS BINARY) = X'4B696E646572776F726C64204D6F6E746573736F726920C3AFC2BFC2BD205075726920496E646168';

-- Entry 153: school id 19272, column `headofschoolname`, deleted=no
-- School (as reported): "International Montessori Academy of Newport Beach - Preschool"
-- Original: "Inayat Unissa Inayat â€“Khan Bergum"
-- Proposed: "Inayat Unissa Inayat –Khan Bergum"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'496E6179617420556E6973736120496E6179617420E280934B68616E2042657267756D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19272 AND CAST(`headofschoolname` AS BINARY) = X'496E6179617420556E6973736120496E6179617420C3A2E282ACE2809C4B68616E2042657267756D';

-- Entry 154: school id 19279, column `web`, deleted=no
-- School (as reported): "Gibbons Park Montessori School "
-- Original: "gibbonsparkmontessori.comâ€Ž"
-- Decoded (before cleanup): "gibbonsparkmontessori.com‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "gibbonsparkmontessori.com"
UPDATE `schools` SET `web` = CONVERT(X'676962626F6E737061726B6D6F6E746573736F72692E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19279 AND CAST(`web` AS BINARY) = X'676962626F6E737061726B6D6F6E746573736F72692E636F6DC3A2E282ACC5BD';

-- Entry 155: school id 19547, column `address1`, deleted=no
-- School (as reported): "Montessori International Kindergarten and Elementary School"
-- Original: "Hlavï¿½Äova 6"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Hlaváčova 191, 614 00"
UPDATE `schools` SET `address1` = CONVERT(X'486C6176C3A1C48D6F7661203139312C20363134203030' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19547 AND CAST(`address1` AS BINARY) = X'486C6176C3AFC2BFC2BDC384C28D6F76612036';

-- Entry 156: school id 19547, column `city`, deleted=no
-- School (as reported): "Montessori International Kindergarten and Elementary School"
-- Original: "Brno - ObÅ™any"
-- Proposed: "Brno - Obřany"
UPDATE `schools` SET `city` = CONVERT(X'42726E6F202D204F62C599616E79' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19547 AND CAST(`city` AS BINARY) = X'42726E6F202D204F62C385E284A2616E79';

-- Entry 157: school id 19644, column `schoolname`, deleted=no
-- School (as reported): "L'Ã©col'o bambins"
-- Original: "L'Ã©col'o bambins"
-- Proposed: "L'écol'o bambins"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C27C3A9636F6C276F2062616D62696E73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19644 AND CAST(`schoolname` AS BINARY) = X'4C27C383C2A9636F6C276F2062616D62696E73';

-- Entry 158: school id 19647, column `address1`, deleted=no
-- School (as reported): "Comunidad Educativa Montessori - CEMAC"
-- Original: "Calle CuauhtÃ©moc 329 Santa Maria Tepepan"
-- Proposed: "Calle Cuauhtémoc 329 Santa Maria Tepepan"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520437561756874C3A96D6F63203332392053616E7461204D61726961205465706570616E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19647 AND CAST(`address1` AS BINARY) = X'43616C6C6520437561756874C383C2A96D6F63203332392053616E7461204D61726961205465706570616E';

-- Entry 159: school id 19648, column `address1`, deleted=no
-- School (as reported): "Montessori Omeyocan"
-- Original: "Calle RepÃºblica de Cuba 203 - Bellavista"
-- Proposed: "Calle República de Cuba 203 - Bellavista"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520526570C3BA626C696361206465204375626120323033202D2042656C6C617669737461' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19648 AND CAST(`address1` AS BINARY) = X'43616C6C6520526570C383C2BA626C696361206465204375626120323033202D2042656C6C617669737461';

-- Entry 160: school id 19653, column `address1`, deleted=yes
-- School (as reported): "Montessori de Guatemala"
-- Original: " 1Âª. Avenida 3-55 zona 10"
-- Decoded (before cleanup): " 1ª. Avenida 3-55 zona 10"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "1ª. Avenida 3-55 zona 10"
UPDATE `schools` SET `address1` = CONVERT(X'31C2AA2E204176656E69646120332D3535207A6F6E61203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19653 AND CAST(`address1` AS BINARY) = X'2031C382C2AA2E204176656E69646120332D3535207A6F6E61203130';

-- Entry 161: school id 19674, column `schoolname`, deleted=no
-- School (as reported): "Freedom Montessori Schoolâ€Ž"
-- Original: "Freedom Montessori Schoolâ€Ž"
-- Decoded (before cleanup): "Freedom Montessori School‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "Freedom Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'46726565646F6D204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19674 AND CAST(`schoolname` AS BINARY) = X'46726565646F6D204D6F6E746573736F7269205363686F6F6CC3A2E282ACC5BD';

-- Entry 162: school id 19704, column `phone1number`, deleted=yes
-- School (as reported): "Nature's Child Montessori School"
-- Original: "253-884-6313â€Ž"
-- Decoded (before cleanup): "253-884-6313‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "253-884-6313"
UPDATE `schools` SET `phone1number` = CONVERT(X'3235332D3838342D36333133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19704 AND CAST(`phone1number` AS BINARY) = X'3235332D3838342D36333133C3A2E282ACC5BD';

-- Entry 163: school id 19739, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus-Holzkirchen"
-- Original: "SchulstraÃŸe 4"
-- Proposed: "Schulstraße 4"
UPDATE `schools` SET `address1` = CONVERT(X'536368756C73747261C39F652034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19739 AND CAST(`address1` AS BINARY) = X'536368756C73747261C383C5B8652034';

-- Entry 164: school id 19740, column `affiliations`, deleted=no
-- School (as reported): "Montessori-Kindergarten Krailling "
-- Original: "WÃ¼rmtaler Montessori Parents Association "
-- Decoded (before cleanup): "Würmtaler Montessori Parents Association "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Würmtaler Montessori Parents Association"
UPDATE `schools` SET `affiliations` = CONVERT(X'57C3BC726D74616C6572204D6F6E746573736F726920506172656E7473204173736F63696174696F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19740 AND CAST(`affiliations` AS BINARY) = X'57C383C2BC726D74616C6572204D6F6E746573736F726920506172656E7473204173736F63696174696F6E20';

-- Entry 165: school id 19741, column `address1`, deleted=no
-- School (as reported): "Montessori Kempten"
-- Original: "ReichlinstraÃŸe 23 - 25"
-- Proposed: "Reichlinstraße 23 - 25"
UPDATE `schools` SET `address1` = CONVERT(X'52656963686C696E73747261C39F65203233202D203235' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19741 AND CAST(`address1` AS BINARY) = X'52656963686C696E73747261C383C5B865203233202D203235';

-- Entry 166: school id 19746, column `address1`, deleted=no
-- School (as reported): "montessori regensburg"
-- Original: "PrÃ¼feninger SchloÃŸstraÃŸe 73c"
-- Proposed: "Prüfeninger Schloßstraße 73c"
UPDATE `schools` SET `address1` = CONVERT(X'5072C3BC66656E696E676572205363686C6FC39F73747261C39F6520373363' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19746 AND CAST(`address1` AS BINARY) = X'5072C383C2BC66656E696E676572205363686C6FC383C5B873747261C383C5B86520373363';

-- Entry 167: school id 19747, column `city`, deleted=no
-- School (as reported): "Montessori Zentrum NÃ¼rnberg"
-- Original: "NÃ¼rnberg"
-- Proposed: "Nürnberg"
UPDATE `schools` SET `city` = CONVERT(X'4EC3BC726E62657267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19747 AND CAST(`city` AS BINARY) = X'4EC383C2BC726E62657267';

-- Entry 168: school id 19747, column `schoolname`, deleted=no
-- School (as reported): "Montessori Zentrum NÃ¼rnberg"
-- Original: "Montessori Zentrum NÃ¼rnberg"
-- Proposed: "Montessori Zentrum Nürnberg"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269205A656E7472756D204EC3BC726E62657267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19747 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269205A656E7472756D204EC383C2BC726E62657267';

-- Entry 169: school id 19761, column `city`, deleted=no
-- School (as reported): "Elterninitiative Montessori MÃ¼nchen-West e.V."
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19761 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 170: school id 19761, column `schoolname`, deleted=no
-- School (as reported): "Elterninitiative Montessori MÃ¼nchen-West e.V."
-- Original: "Elterninitiative Montessori MÃ¼nchen-West e.V."
-- Proposed: "Elterninitiative Montessori München-West e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'456C7465726E696E6974696174697665204D6F6E746573736F7269204DC3BC6E6368656E2D5765737420652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19761 AND CAST(`schoolname` AS BINARY) = X'456C7465726E696E6974696174697665204D6F6E746573736F7269204DC383C2BC6E6368656E2D5765737420652E562E';

-- Entry 171: school id 19762, column `address1`, deleted=no
-- School (as reported): "Montessori-Vereinigung NÃ¼rnberger Land e.V."
-- Original: "DaschstraÃŸe 16"
-- Proposed: "Daschstraße 16"
UPDATE `schools` SET `address1` = CONVERT(X'446173636873747261C39F65203136' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19762 AND CAST(`address1` AS BINARY) = X'446173636873747261C383C5B865203136';

-- Entry 172: school id 19762, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Vereinigung NÃ¼rnberger Land e.V."
-- Original: "Montessori-Vereinigung NÃ¼rnberger Land e.V."
-- Proposed: "Montessori-Vereinigung Nürnberger Land e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D56657265696E6967756E67204EC3BC726E626572676572204C616E6420652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19762 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D56657265696E6967756E67204EC383C2BC726E626572676572204C616E6420652E562E';

-- Entry 173: school id 19783, column `address1`, deleted=no
-- School (as reported): "Maria Montessori School- Choluteca"
-- Original: "Anillo PerifÃ©rico"
-- Proposed: "Anillo Periférico"
UPDATE `schools` SET `address1` = CONVERT(X'416E696C6C6F205065726966C3A97269636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19783 AND CAST(`address1` AS BINARY) = X'416E696C6C6F205065726966C383C2A97269636F';

-- Entry 174: school id 19935, column `headofschoolname`, deleted=no
-- School (as reported): "Petersham Montessori School"
-- Original: "â€‹Ms. Cheryl Calcari"
-- Decoded (before cleanup): "​Ms. Cheryl Calcari"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "Ms. Cheryl Calcari"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D732E2043686572796C2043616C63617269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 19935 AND CAST(`headofschoolname` AS BINARY) = X'C3A2E282ACE280B94D732E2043686572796C2043616C63617269';

-- Entry 175: school id 20075, column `web`, deleted=yes
-- School (as reported): "KnowledgeTree Montessori"
-- Original: "ktmontessori.comâ€Ž"
-- Decoded (before cleanup): "ktmontessori.com‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "ktmontessori.com"
UPDATE `schools` SET `web` = CONVERT(X'6B746D6F6E746573736F72692E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20075 AND CAST(`web` AS BINARY) = X'6B746D6F6E746573736F72692E636F6DC3A2E282ACC5BD';

-- Entry 176: school id 20339, column `stateprovince`, deleted=no
-- School (as reported): "Ecole Montessori Ville-Marie"
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20339 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 177: school id 20379, column `city`, deleted=no
-- School (as reported): "Maria Montessori Schule BrÃ¼hl"
-- Original: "BrÃ¼hl"
-- Proposed: "Brühl"
UPDATE `schools` SET `city` = CONVERT(X'4272C3BC686C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20379 AND CAST(`city` AS BINARY) = X'4272C383C2BC686C';

-- Entry 178: school id 20379, column `schoolname`, deleted=no
-- School (as reported): "Maria Montessori Schule BrÃ¼hl"
-- Original: "Maria Montessori Schule BrÃ¼hl"
-- Proposed: "Maria Montessori Schule Brühl"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D61726961204D6F6E746573736F726920536368756C65204272C3BC686C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20379 AND CAST(`schoolname` AS BINARY) = X'4D61726961204D6F6E746573736F726920536368756C65204272C383C2BC686C';

-- Entry 179: school id 20510, column `web`, deleted=yes
-- School (as reported): "Montessori House of Learning"
-- Original: "montessori-elc.com.auâ€Ž"
-- Decoded (before cleanup): "montessori-elc.com.au‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessori-elc.com.au"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F72692D656C632E636F6D2E6175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20510 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F72692D656C632E636F6D2E6175C3A2E282ACC5BD';

-- Entry 180: school id 20551, column `contactname`, deleted=no
-- School (as reported): "Maria Montessori Grundschule Hausen"
-- Original: "Dr. Angelika MÃ¼ller-Zastrau mit Ben"
-- Proposed: "Dr. Angelika Müller-Zastrau mit Ben"
UPDATE `schools` SET `contactname` = CONVERT(X'44722E20416E67656C696B61204DC3BC6C6C65722D5A617374726175206D69742042656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20551 AND CAST(`contactname` AS BINARY) = X'44722E20416E67656C696B61204DC383C2BC6C6C65722D5A617374726175206D69742042656E';

-- Entry 181: school id 20551, column `headofschoolname`, deleted=no
-- School (as reported): "Maria Montessori Grundschule Hausen"
-- Original: "Dr. Angelika MÃ¼ller-Zastrau mit Ben"
-- Proposed: "Dr. Angelika Müller-Zastrau mit Ben"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'44722E20416E67656C696B61204DC3BC6C6C65722D5A617374726175206D69742042656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20551 AND CAST(`headofschoolname` AS BINARY) = X'44722E20416E67656C696B61204DC383C2BC6C6C65722D5A617374726175206D69742042656E';

-- Entry 182: school id 20560, column `web`, deleted=no
-- School (as reported): "Montessori Gardens Children's House"
-- Original: "montessorigarden.com.auâ€Ž"
-- Decoded (before cleanup): "montessorigarden.com.au‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessorigarden.com.au"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F726967617264656E2E636F6D2E6175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20560 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F726967617264656E2E636F6D2E6175C3A2E282ACC5BD';

-- Entry 183: school id 20577, column `address1`, deleted=no
-- School (as reported): "Montessori-Schule Augsburg"
-- Original: "Untere Jakobermauer 11Â½"
-- Proposed: "Untere Jakobermauer 11½"
UPDATE `schools` SET `address1` = CONVERT(X'556E74657265204A616B6F6265726D61756572203131C2BD' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20577 AND CAST(`address1` AS BINARY) = X'556E74657265204A616B6F6265726D61756572203131C382C2BD';

-- Entry 184: school id 20582, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Herzogenaurach "
-- Original: "Lohhofer StraÃŸe 32"
-- Proposed: "Lohhofer Straße 32"
UPDATE `schools` SET `address1` = CONVERT(X'4C6F68686F6665722053747261C39F65203332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20582 AND CAST(`address1` AS BINARY) = X'4C6F68686F6665722053747261C383C5B865203332';

-- Entry 185: school id 20585, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus - Frohes Leben -  Gera"
-- Original: "NordstraÃŸe 39"
-- Proposed: "Nordstraße 39"
UPDATE `schools` SET `address1` = CONVERT(X'4E6F726473747261C39F65203339' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20585 AND CAST(`address1` AS BINARY) = X'4E6F726473747261C383C5B865203339';

-- Entry 186: school id 20585, column `contactname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus - Frohes Leben -  Gera"
-- Original: "Kerstin HÃ¤berlein"
-- Proposed: "Kerstin Häberlein"
UPDATE `schools` SET `contactname` = CONVERT(X'4B65727374696E2048C3A46265726C65696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20585 AND CAST(`contactname` AS BINARY) = X'4B65727374696E2048C383C2A46265726C65696E';

-- Entry 187: school id 20585, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus - Frohes Leben -  Gera"
-- Original: "Kerstin HÃ¤berlein"
-- Proposed: "Kerstin Häberlein"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4B65727374696E2048C3A46265726C65696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20585 AND CAST(`headofschoolname` AS BINARY) = X'4B65727374696E2048C383C2A46265726C65696E';

-- Entry 188: school id 20586, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus \"Nohraer Spatzen\" Integrative KindertagesstÃ¤tte"
-- Original: "Montessori-Kinderhaus \"Nohraer Spatzen\" Integrative KindertagesstÃ¤tte"
-- Proposed: "Montessori-Kinderhaus \"Nohraer Spatzen\" Integrative Kindertagesstätte"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D4B696E6465726861757320224E6F687261657220537061747A656E2220496E746567726174697665204B696E64657274616765737374C3A4747465' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20586 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D4B696E6465726861757320224E6F687261657220537061747A656E2220496E746567726174697665204B696E64657274616765737374C383C2A4747465';

-- Entry 189: school id 20587, column `city`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Sausewind - Brugel"
-- Original: "BÃ¼rgel"
-- Proposed: "Bürgel"
UPDATE `schools` SET `city` = CONVERT(X'42C3BC7267656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20587 AND CAST(`city` AS BINARY) = X'42C383C2BC7267656C';

-- Entry 190: school id 20607, column `address1`, deleted=no
-- School (as reported): "Warsaw Montessori Family- Warsaw Montessori School"
-- Original: "ul. SzwoleÅ¼erow 4"
-- Proposed: "ul. Szwoleżerow 4"
UPDATE `schools` SET `address1` = CONVERT(X'756C2E20537A776F6C65C5BC65726F772034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20607 AND CAST(`address1` AS BINARY) = X'756C2E20537A776F6C65C385C2BC65726F772034';

-- Entry 191: school id 20629, column `web`, deleted=no
-- School (as reported): "Helensville Montessori Pre-School"
-- Original: "helensvillemontessori.co.nzâ€Ž"
-- Decoded (before cleanup): "helensvillemontessori.co.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "helensvillemontessori.co.nz"
UPDATE `schools` SET `web` = CONVERT(X'68656C656E7376696C6C656D6F6E746573736F72692E636F2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20629 AND CAST(`web` AS BINARY) = X'68656C656E7376696C6C656D6F6E746573736F72692E636F2E6E7AC3A2E282ACC5BD';

-- Entry 192: school id 20630, column `schoolname`, deleted=no
-- School (as reported): "Titoki Montessori Preschool Incâ€Ž "
-- Original: "Titoki Montessori Preschool Incâ€Ž "
-- Decoded (before cleanup): "Titoki Montessori Preschool Inc‎ "
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Titoki Montessori Preschool Inc"
UPDATE `schools` SET `schoolname` = CONVERT(X'5469746F6B69204D6F6E746573736F7269205072657363686F6F6C20496E63' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20630 AND CAST(`schoolname` AS BINARY) = X'5469746F6B69204D6F6E746573736F7269205072657363686F6F6C20496E63C3A2E282ACC5BD20';

-- Entry 193: school id 20633, column `schoolname`, deleted=no
-- School (as reported): "Kumeu Montessori Pre-Schoolâ€Ž "
-- Original: "Kumeu Montessori Pre-Schoolâ€Ž "
-- Decoded (before cleanup): "Kumeu Montessori Pre-School‎ "
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Kumeu Montessori Pre-School"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B756D6575204D6F6E746573736F7269205072652D5363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20633 AND CAST(`schoolname` AS BINARY) = X'4B756D6575204D6F6E746573736F7269205072652D5363686F6F6CC3A2E282ACC5BD20';

-- Entry 194: school id 20645, column `web`, deleted=no
-- School (as reported): "Montessori Smart Start Pre-Schools - Grange Road"
-- Original: "smartstart.school.nzâ€Ž"
-- Decoded (before cleanup): "smartstart.school.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "smartstart.school.nz"
UPDATE `schools` SET `web` = CONVERT(X'736D61727473746172742E7363686F6F6C2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20645 AND CAST(`web` AS BINARY) = X'736D61727473746172742E7363686F6F6C2E6E7AC3A2E282ACC5BD';

-- Entry 195: school id 20649, column `web`, deleted=no
-- School (as reported): "Eastern Suburbs Montessori Primary School"
-- Original: "montessoriprimary.school.nzâ€Ž"
-- Decoded (before cleanup): "montessoriprimary.school.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessoriprimary.school.nz"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F72697072696D6172792E7363686F6F6C2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20649 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F72697072696D6172792E7363686F6F6C2E6E7AC3A2E282ACC5BD';

-- Entry 196: school id 20667, column `web`, deleted=no
-- School (as reported): "Otari Montessori School"
-- Original: "otari.school.nzâ€Ž"
-- Decoded (before cleanup): "otari.school.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "otari.school.nz"
UPDATE `schools` SET `web` = CONVERT(X'6F746172692E7363686F6F6C2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20667 AND CAST(`web` AS BINARY) = X'6F746172692E7363686F6F6C2E6E7AC3A2E282ACC5BD';

-- Entry 197: school id 20669, column `web`, deleted=no
-- School (as reported): "Capital Montessori School"
-- Original: "montessori.school.nzâ€Ž"
-- Decoded (before cleanup): "montessori.school.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessori.school.nz"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F72692E7363686F6F6C2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20669 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F72692E7363686F6F6C2E6E7AC3A2E282ACC5BD';

-- Entry 198: school id 20674, column `infoemail`, deleted=no
-- School (as reported): "Nova Montessori School"
-- Original: "admin@novamontessori.school.nzâ€Ž"
-- Decoded (before cleanup): "admin@novamontessori.school.nz‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "admin@novamontessori.school.nz"
UPDATE `schools` SET `infoemail` = CONVERT(X'61646D696E406E6F76616D6F6E746573736F72692E7363686F6F6C2E6E7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20674 AND CAST(`infoemail` AS BINARY) = X'61646D696E406E6F76616D6F6E746573736F72692E7363686F6F6C2E6E7AC3A2E282ACC5BD';

-- Entry 199: school id 20691, column `web`, deleted=no
-- School (as reported): " Leeson Park Creche & Montessori"
-- Original: "leesonpark.ieâ€Ž"
-- Decoded (before cleanup): "leesonpark.ie‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "leesonpark.ie"
UPDATE `schools` SET `web` = CONVERT(X'6C6565736F6E7061726B2E6965' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20691 AND CAST(`web` AS BINARY) = X'6C6565736F6E7061726B2E6965C3A2E282ACC5BD';

-- Entry 200: school id 20713, column `address1`, deleted=no
-- School (as reported): "Mikkelin Montessori Pï¿½ivï¿½koti"
-- Original: " JÃ¤Ã¤kÃ¤rinkatu 8"
-- Decoded (before cleanup): " Jääkärinkatu 8"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Jääkärinkatu 8"
UPDATE `schools` SET `address1` = CONVERT(X'4AC3A4C3A46BC3A472696E6B6174752038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20713 AND CAST(`address1` AS BINARY) = X'204AC383C2A4C383C2A46BC383C2A472696E6B6174752038';

-- Entry 201: school id 20713, column `schoolname`, deleted=no
-- School (as reported): "Mikkelin Montessori Pï¿½ivï¿½koti"
-- Original: "Mikkelin Montessori Pï¿½ivï¿½koti"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Mikkelin Montessori-leikkikoulun kannatusyhdistys ry"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D696B6B656C696E204D6F6E746573736F72692D6C65696B6B696B6F756C756E206B616E6E617475737968646973747973207279' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20713 AND CAST(`schoolname` AS BINARY) = X'4D696B6B656C696E204D6F6E746573736F72692050C3AFC2BFC2BD6976C3AFC2BFC2BD6B6F7469';

-- Entry 202: school id 20718, column `contactname`, deleted=no
-- School (as reported): "Espoon Montessori-leikkikoulu"
-- Original: "Sari-Hanna Jï¿½ppinen"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Sari-Hanna Jäppinen"
UPDATE `schools` SET `contactname` = CONVERT(X'536172692D48616E6E61204AC3A47070696E656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20718 AND CAST(`contactname` AS BINARY) = X'536172692D48616E6E61204AC3AFC2BFC2BD7070696E656E';

-- Entry 203: school id 20718, column `headofschoolname`, deleted=no
-- School (as reported): "Espoon Montessori-leikkikoulu"
-- Original: "Sari-Hanna Jï¿½ppinen"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Sari-Hanna Jäppinen"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'536172692D48616E6E61204AC3A47070696E656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20718 AND CAST(`headofschoolname` AS BINARY) = X'536172692D48616E6E61204AC3AFC2BFC2BD7070696E656E';

-- Entry 204: school id 20721, column `address1`, deleted=no
-- School (as reported): "Montessori Lastentalo Ry"
-- Original: "LeppÃ¤vaarankatu 24 "
-- Decoded (before cleanup): "Leppävaarankatu 24 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Leppävaarankatu 24"
UPDATE `schools` SET `address1` = CONVERT(X'4C657070C3A476616172616E6B617475203234' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20721 AND CAST(`address1` AS BINARY) = X'4C657070C383C2A476616172616E6B61747520323420';

-- Entry 205: school id 20721, column `web`, deleted=no
-- School (as reported): "Montessori Lastentalo Ry"
-- Original: "montessori-lastentalo.netâ€Ž"
-- Decoded (before cleanup): "montessori-lastentalo.net‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessori-lastentalo.net"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F72692D6C617374656E74616C6F2E6E6574' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20721 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F72692D6C617374656E74616C6F2E6E6574C3A2E282ACC5BD';

-- Entry 206: school id 20725, column `address1`, deleted=no
-- School (as reported): "RiihimÃ¤en Montessori-pÃ¤ivÃ¤koti"
-- Original: "ErkylÃ¤ntie 7"
-- Proposed: "Erkyläntie 7"
UPDATE `schools` SET `address1` = CONVERT(X'45726B796CC3A46E7469652037' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20725 AND CAST(`address1` AS BINARY) = X'45726B796CC383C2A46E7469652037';

-- Entry 207: school id 20725, column `city`, deleted=no
-- School (as reported): "RiihimÃ¤en Montessori-pÃ¤ivÃ¤koti"
-- Original: "RiihimÃ¤ki"
-- Proposed: "Riihimäki"
UPDATE `schools` SET `city` = CONVERT(X'52696968696DC3A46B69' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20725 AND CAST(`city` AS BINARY) = X'52696968696DC383C2A46B69';

-- Entry 208: school id 20725, column `schoolname`, deleted=no
-- School (as reported): "RiihimÃ¤en Montessori-pÃ¤ivÃ¤koti"
-- Original: "RiihimÃ¤en Montessori-pÃ¤ivÃ¤koti"
-- Proposed: "Riihimäen Montessori-päiväkoti"
UPDATE `schools` SET `schoolname` = CONVERT(X'52696968696DC3A4656E204D6F6E746573736F72692D70C3A46976C3A46B6F7469' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20725 AND CAST(`schoolname` AS BINARY) = X'52696968696DC383C2A4656E204D6F6E746573736F72692D70C383C2A46976C383C2A46B6F7469';

-- Entry 209: school id 20792, column `web`, deleted=no
-- School (as reported): "Holly Grange Montessori Nursery and Preschool- Lymm Nursery"
-- Original: "hollygrangemontessori.co.ukâ€Ž"
-- Decoded (before cleanup): "hollygrangemontessori.co.uk‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "hollygrangemontessori.co.uk"
UPDATE `schools` SET `web` = CONVERT(X'686F6C6C796772616E67656D6F6E746573736F72692E636F2E756B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20792 AND CAST(`web` AS BINARY) = X'686F6C6C796772616E67656D6F6E746573736F72692E636F2E756BC3A2E282ACC5BD';

-- Entry 210: school id 20813, column `address1`, deleted=no
-- School (as reported): "Eton Kids--Beijing-Overseas Chinese Town Campus"
-- Original: "Jinchan Huanleyuan 1ï¿½ jia 2"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Jinchan Huanleyuan 1-A2"
UPDATE `schools` SET `address1` = CONVERT(X'4A696E6368616E204875616E6C657975616E20312D4132' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20813 AND CAST(`address1` AS BINARY) = X'4A696E6368616E204875616E6C657975616E2031C3AFC2BFC2BD206A69612032';

-- Entry 211: school id 20873, column `schoolname`, deleted=no
-- School (as reported): "Kinderworld Montessori ï¿½ BSD City, Serpong, Tangerang Selatan"
-- Original: "Kinderworld Montessori ï¿½ BSD City, Serpong, Tangerang Selatan"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Kinderworld Montessori, BSD City, Serpong, Tangerang Selatan"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B696E646572776F726C64204D6F6E746573736F72692C2042534420436974792C20536572706F6E672C2054616E676572616E672053656C6174616E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20873 AND CAST(`schoolname` AS BINARY) = X'4B696E646572776F726C64204D6F6E746573736F726920C3AFC2BFC2BD2042534420436974792C20536572706F6E672C2054616E676572616E672053656C6174616E';

-- Entry 212: school id 20898, column `address1`, deleted=yes
-- School (as reported): "Montessori School"
-- Original: "Plaza. 19 de Abril M 17 S 1 San Josï¿½ de Carrasco"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Plaza. 19 de Abril M 17 S 1 San Jose de Carrasco"
UPDATE `schools` SET `address1` = CONVERT(X'506C617A612E20313920646520416272696C204D203137205320312053616E204A6F736520646520436172726173636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20898 AND CAST(`address1` AS BINARY) = X'506C617A612E20313920646520416272696C204D203137205320312053616E204A6F73C3AFC2BFC2BD20646520436172726173636F';

-- Entry 213: school id 20973, column `schoolname`, deleted=no
-- School (as reported): "Bournemouth Montessori Centreâ€Ž"
-- Original: "Bournemouth Montessori Centreâ€Ž"
-- Decoded (before cleanup): "Bournemouth Montessori Centre‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "Bournemouth Montessori Centre"
UPDATE `schools` SET `schoolname` = CONVERT(X'426F75726E656D6F757468204D6F6E746573736F72692043656E747265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 20973 AND CAST(`schoolname` AS BINARY) = X'426F75726E656D6F757468204D6F6E746573736F72692043656E747265C3A2E282ACC5BD';

-- Entry 214: school id 21056, column `address1`, deleted=no
-- School (as reported): "Lunds Montessorigrundskola"
-- Original: "Sankt Lars vÃ¤g Byggnad 4"
-- Proposed: "Sankt Lars väg Byggnad 4"
UPDATE `schools` SET `address1` = CONVERT(X'53616E6B74204C6172732076C3A46720427967676E61642034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21056 AND CAST(`address1` AS BINARY) = X'53616E6B74204C6172732076C383C2A46720427967676E61642034';

-- Entry 215: school id 21098, column `contactname`, deleted=no
-- School (as reported): "Montessori-Volksschule Heilgereuthe, Dornbirn"
-- Original: "Friederike MÃ¶rschel"
-- Proposed: "Friederike Mörschel"
UPDATE `schools` SET `contactname` = CONVERT(X'46726965646572696B65204DC3B672736368656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21098 AND CAST(`contactname` AS BINARY) = X'46726965646572696B65204DC383C2B672736368656C';

-- Entry 216: school id 21098, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori-Volksschule Heilgereuthe, Dornbirn"
-- Original: "Friederike MÃ¶rschel"
-- Proposed: "Friederike Mörschel"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'46726965646572696B65204DC3B672736368656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21098 AND CAST(`headofschoolname` AS BINARY) = X'46726965646572696B65204DC383C2B672736368656C';

-- Entry 217: school id 21117, column `contactname`, deleted=no
-- School (as reported): "MS a ZS Montessori Kladno"
-- Original: "Jana SmolkovÃ¡"
-- Proposed: "Jana Smolková"
UPDATE `schools` SET `contactname` = CONVERT(X'4A616E6120536D6F6C6B6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21117 AND CAST(`contactname` AS BINARY) = X'4A616E6120536D6F6C6B6F76C383C2A1';

-- Entry 218: school id 21117, column `headofschoolname`, deleted=no
-- School (as reported): "MS a ZS Montessori Kladno"
-- Original: "Jana SmolkovÃ¡"
-- Proposed: "Jana Smolková"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4A616E6120536D6F6C6B6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21117 AND CAST(`headofschoolname` AS BINARY) = X'4A616E6120536D6F6C6B6F76C383C2A1';

-- Entry 219: school id 21133, column `headofschoolname`, deleted=no
-- School (as reported): "Colegio Kinder Play"
-- Original: "Aura DubÃ³n de MendizÃ¡bal (Chiqui)"
-- Proposed: "Aura Dubón de Mendizábal (Chiqui)"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4175726120447562C3B36E206465204D656E64697AC3A162616C202843686971756929' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21133 AND CAST(`headofschoolname` AS BINARY) = X'4175726120447562C383C2B36E206465204D656E64697AC383C2A162616C202843686971756929';

-- Entry 220: school id 21271, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori de Panama"
-- Original: "San Francisco, El Golf E Iinicio de Ave.Sta. Elena. PANAMÃ"
-- Proposed: "San Francisco, El Golf E Iinicio de Ave.Sta. Elena. PANAMÁ"
UPDATE `schools` SET `address1` = CONVERT(X'53616E204672616E636973636F2C20456C20476F6C6620452049696E6963696F206465204176652E5374612E20456C656E612E2050414E414DC381' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21271 AND CAST(`address1` AS BINARY) = X'53616E204672616E636973636F2C20456C20476F6C6620452049696E6963696F206465204176652E5374612E20456C656E612E2050414E414DC383C281';

-- Entry 221: school id 21271, column `headofschoolname`, deleted=no
-- School (as reported): "Escuela Montessori de Panama"
-- Original: "Lidia BÃ©rtoli de Palau"
-- Proposed: "Lidia Bértoli de Palau"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4C696469612042C3A972746F6C692064652050616C6175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21271 AND CAST(`headofschoolname` AS BINARY) = X'4C696469612042C383C2A972746F6C692064652050616C6175';

-- Entry 222: school id 21318, column `web`, deleted=no
-- School (as reported): "Kent and Sussex Montessori Centre"
-- Original: "montessoricentre.comâ€Ž"
-- Decoded (before cleanup): "montessoricentre.com‎"
-- Cleanup: removed invisible U+200E LEFT-TO-RIGHT MARK
-- Proposed: "montessoricentre.com"
UPDATE `schools` SET `web` = CONVERT(X'6D6F6E746573736F726963656E7472652E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21318 AND CAST(`web` AS BINARY) = X'6D6F6E746573736F726963656E7472652E636F6DC3A2E282ACC5BD';

-- Entry 223: school id 21536, column `address2`, deleted=no
-- School (as reported): "Petnieku Darbnica"
-- Original: "priekÅ¡pilsÄ“ta"
-- Proposed: "priekšpilsēta"
UPDATE `schools` SET `address2` = CONVERT(X'707269656BC5A170696C73C4937461' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21536 AND CAST(`address2` AS BINARY) = X'707269656BC385C2A170696C73C384E2809C7461';

-- Entry 224: school id 21551, column `schoolname`, deleted=yes
-- School (as reported): "Harmony Montessori ChildrenÂ’s House - Caboolture"
-- Original: "Harmony Montessori ChildrenÂ’s House - Caboolture"
-- Decoded (before cleanup): "Harmony Montessori Childrens House - Caboolture"
-- Cleanup: replaced U+0092 CONTROL CHARACTER with '’' (Windows-1252)
-- Proposed: "Harmony Montessori Children’s House - Caboolture"
UPDATE `schools` SET `schoolname` = CONVERT(X'4861726D6F6E79204D6F6E746573736F7269204368696C6472656EE280997320486F757365202D204361626F6F6C74757265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21551 AND CAST(`schoolname` AS BINARY) = X'4861726D6F6E79204D6F6E746573736F7269204368696C6472656EC382E280997320486F757365202D204361626F6F6C74757265';

-- Entry 225: school id 21883, column `address1`, deleted=no
-- School (as reported): "Community Montessori School of Bisbee"
-- Original: "â€‹1900 S.Naco Highway"
-- Decoded (before cleanup): "​1900 S.Naco Highway"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "1900 S.Naco Highway"
UPDATE `schools` SET `address1` = CONVERT(X'3139303020532E4E61636F2048696768776179' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 21883 AND CAST(`address1` AS BINARY) = X'C3A2E282ACE280B93139303020532E4E61636F2048696768776179';

-- Entry 226: school id 22217, column `schoolname`, deleted=no
-- School (as reported): "â€‹Montessori School of Silicon Valley - Main Street Montessori"
-- Original: "â€‹Montessori School of Silicon Valley - Main Street Montessori"
-- Decoded (before cleanup): "​Montessori School of Silicon Valley - Main Street Montessori"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "Montessori School of Silicon Valley - Main Street Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269205363686F6F6C206F662053696C69636F6E2056616C6C6579202D204D61696E20537472656574204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 22217 AND CAST(`schoolname` AS BINARY) = X'C3A2E282ACE280B94D6F6E746573736F7269205363686F6F6C206F662053696C69636F6E2056616C6C6579202D204D61696E20537472656574204D6F6E746573736F7269';

-- Entry 227: school id 22761, column `address1`, deleted=no
-- School (as reported): "Michigan Montessori Children's Academy"
-- Original: "â€‹13341 22 Mile Road"
-- Decoded (before cleanup): "​13341 22 Mile Road"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "13341 22 Mile Road"
UPDATE `schools` SET `address1` = CONVERT(X'3133333431203232204D696C6520526F6164' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 22761 AND CAST(`address1` AS BINARY) = X'C3A2E282ACE280B93133333431203232204D696C6520526F6164';

-- Entry 228: school id 22902, column `address2`, deleted=no
-- School (as reported): "The Family School"
-- Original: "Dag HammarskjÃ¶ld Plaza"
-- Proposed: "Dag Hammarskjöld Plaza"
UPDATE `schools` SET `address2` = CONVERT(X'4461672048616D6D6172736B6AC3B66C6420506C617A61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 22902 AND CAST(`address2` AS BINARY) = X'4461672048616D6D6172736B6AC383C2B66C6420506C617A61';

-- Entry 229: school id 22960, column `infoemail`, deleted=no
-- School (as reported): "Polaris Montessori Elementary School"
-- Original: "â€‹ttisdale@sd57.bc.ca"
-- Decoded (before cleanup): "​ttisdale@sd57.bc.ca"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "ttisdale@sd57.bc.ca"
UPDATE `schools` SET `infoemail` = CONVERT(X'7474697364616C6540736435372E62632E6361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 22960 AND CAST(`infoemail` AS BINARY) = X'C3A2E282ACE280B97474697364616C6540736435372E62632E6361';

-- Entry 230: school id 23024, column `infoemail`, deleted=yes
-- School (as reported): "La Maison Montessori House - Aurora Campus"
-- Original: "â€‹aurora@lmmh.ca"
-- Decoded (before cleanup): "​aurora@lmmh.ca"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "aurora@lmmh.ca"
UPDATE `schools` SET `infoemail` = CONVERT(X'6175726F7261406C6D6D682E6361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23024 AND CAST(`infoemail` AS BINARY) = X'C3A2E282ACE280B96175726F7261406C6D6D682E6361';

-- Entry 231: school id 23179, column `city`, deleted=no
-- School (as reported): "Ecole Montessoride La Colline- Bellevue"
-- Original: "QuÃ©bec"
-- Proposed: "Québec"
UPDATE `schools` SET `city` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23179 AND CAST(`city` AS BINARY) = X'5175C383C2A9626563';

-- Entry 232: school id 23180, column `stateprovince`, deleted=no
-- School (as reported): "Les Ecoles Montessori Schools - Outremont Location"
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23180 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 233: school id 23181, column `stateprovince`, deleted=no
-- School (as reported): "Les Ecoles Montessori Schools - Town of Mount Royal"
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23181 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 234: school id 23182, column `stateprovince`, deleted=no
-- School (as reported): "Les Ecoles Montessori Schools - Greenfield Park "
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23182 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 235: school id 23183, column `stateprovince`, deleted=no
-- School (as reported): "Les Ecoles Montessori Schools - Beaconsfield Location"
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23183 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 236: school id 23184, column `stateprovince`, deleted=no
-- School (as reported): "Les Ecoles Montessori Schools - Nun's Island Location"
-- Original: "Quï¿½bec"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Québec"
UPDATE `schools` SET `stateprovince` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23184 AND CAST(`stateprovince` AS BINARY) = X'5175C3AFC2BFC2BD626563';

-- Entry 237: school id 23341, column `headofschoolname`, deleted=no
-- School (as reported): "Bilingual Montessori School- White Rock"
-- Original: "SeÃ±ora Dora Gonzalez"
-- Proposed: "Señora Dora Gonzalez"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'5365C3B16F726120446F726120476F6E7A616C657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23341 AND CAST(`headofschoolname` AS BINARY) = X'5365C383C2B16F726120446F726120476F6E7A616C657A';

-- Entry 238: school id 23485, column `address1`, deleted=yes
-- School (as reported): "Step By Step Children's House "
-- Original: "122 W Pennsylvania Avenue Downingtown, PA Â 19335"
-- Decoded (before cleanup): "122 W Pennsylvania Avenue Downingtown, PA  19335"
-- Cleanup: replaced U+00A0 NO-BREAK SPACE with a normal space
-- Proposed: "122 W Pennsylvania Avenue Downingtown, PA 19335"
UPDATE `schools` SET `address1` = CONVERT(X'31323220572050656E6E73796C76616E6961204176656E756520446F776E696E67746F776E2C205041203139333335' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23485 AND CAST(`address1` AS BINARY) = X'31323220572050656E6E73796C76616E6961204176656E756520446F776E696E67746F776E2C20504120C382C2A03139333335';

-- Entry 239: school id 23491, column `headofschoolname`, deleted=no
-- School (as reported): "Keystone Montessori School"
-- Original: "Linda FrankeÂ  "
-- Decoded (before cleanup): "Linda Franke  "
-- Cleanup: replaced U+00A0 NO-BREAK SPACE with a normal space
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Linda Franke"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4C696E6461204672616E6B65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23491 AND CAST(`headofschoolname` AS BINARY) = X'4C696E6461204672616E6B65C382C2A020';

-- Entry 240: school id 23533, column `infoemail`, deleted=yes
-- School (as reported): "Londonderry Christian Montessori School"
-- Original: "â€‹londonderryoffice@gmail.com"
-- Decoded (before cleanup): "​londonderryoffice@gmail.com"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "londonderryoffice@gmail.com"
UPDATE `schools` SET `infoemail` = CONVERT(X'6C6F6E646F6E64657272796F666669636540676D61696C2E636F6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23533 AND CAST(`infoemail` AS BINARY) = X'C3A2E282ACE280B96C6F6E646F6E64657272796F666669636540676D61696C2E636F6D';

-- Entry 241: school id 23571, column `city`, deleted=yes
-- School (as reported): "Academie Maria-Montessori de Montreal "
-- Original: "MontrÃ©al (QC)"
-- Proposed: "Montréal (QC)"
UPDATE `schools` SET `city` = CONVERT(X'4D6F6E7472C3A9616C2028514329' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23571 AND CAST(`city` AS BINARY) = X'4D6F6E7472C383C2A9616C2028514329';

-- Entry 242: school id 23795, column `schoolname`, deleted=no
-- School (as reported): "Escuela Montessori Juan Ponce de LeÃ³n"
-- Original: "Escuela Montessori Juan Ponce de LeÃ³n"
-- Proposed: "Escuela Montessori Juan Ponce de León"
UPDATE `schools` SET `schoolname` = CONVERT(X'45736375656C61204D6F6E746573736F7269204A75616E20506F6E6365206465204C65C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23795 AND CAST(`schoolname` AS BINARY) = X'45736375656C61204D6F6E746573736F7269204A75616E20506F6E6365206465204C65C383C2B36E';

-- Entry 243: school id 23821, column `address1`, deleted=no
-- School (as reported): "Olivos Montessori School"
-- Original: "Salta 2821 (y calle R. Saenz Peï¿½a)"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Salta 2821 (y calle R. Saenz Peña)"
UPDATE `schools` SET `address1` = CONVERT(X'53616C746120323832312028792063616C6C6520522E205361656E7A205065C3B16129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23821 AND CAST(`address1` AS BINARY) = X'53616C746120323832312028792063616C6C6520522E205361656E7A205065C3AFC2BFC2BD6129';

-- Entry 244: school id 23902, column `address1`, deleted=no
-- School (as reported): "Montessorihause ReisnerstraÃŸe"
-- Original: "ReisnerstraÃŸe 12"
-- Proposed: "Reisnerstraße 12"
UPDATE `schools` SET `address1` = CONVERT(X'526569736E657273747261C39F65203132' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23902 AND CAST(`address1` AS BINARY) = X'526569736E657273747261C383C5B865203132';

-- Entry 245: school id 23902, column `schoolname`, deleted=no
-- School (as reported): "Montessorihause ReisnerstraÃŸe"
-- Original: "Montessorihause ReisnerstraÃŸe"
-- Proposed: "Montessorihause Reisnerstraße"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269686175736520526569736E657273747261C39F65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23902 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269686175736520526569736E657273747261C383C5B865';

-- Entry 246: school id 23903, column `address1`, deleted=yes
-- School (as reported): "Frei Raum Montessori"
-- Original: "Schlï¿½sselgasse 3/2 "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Schlüsselgasse 3/2"
UPDATE `schools` SET `address1` = CONVERT(X'5363686CC3BC7373656C676173736520332F32' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23903 AND CAST(`address1` AS BINARY) = X'5363686CC3AFC2BFC2BD7373656C676173736520332F3220';

-- Entry 247: school id 23904, column `address1`, deleted=no
-- School (as reported): "Montessori-Campus Wein HÃ¼tteldorf"
-- Original: " HÃ¼ttelbergstraÃŸe 5"
-- Decoded (before cleanup): " Hüttelbergstraße 5"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Hüttelbergstraße 5"
UPDATE `schools` SET `address1` = CONVERT(X'48C3BC7474656C6265726773747261C39F652035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23904 AND CAST(`address1` AS BINARY) = X'2048C383C2BC7474656C6265726773747261C383C5B8652035';

-- Entry 248: school id 23904, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Campus Wein HÃ¼tteldorf"
-- Original: "Montessori-Campus Wein HÃ¼tteldorf"
-- Proposed: "Montessori-Campus Wein Hütteldorf"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D43616D707573205765696E2048C3BC7474656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23904 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D43616D707573205765696E2048C383C2BC7474656C646F7266';

-- Entry 249: school id 23906, column `address1`, deleted=yes
-- School (as reported): "Wiener Montessori- Schulen"
-- Original: "Heiligenstï¿½dterstraï¿½e 54 "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Heiligenstädter Straße 54"
UPDATE `schools` SET `address1` = CONVERT(X'4865696C6967656E7374C3A4647465722053747261C39F65203534' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23906 AND CAST(`address1` AS BINARY) = X'4865696C6967656E7374C3AFC2BFC2BD6474657273747261C3AFC2BFC2BD6520353420';

-- Entry 250: school id 23911, column `schoolname`, deleted=no
-- School (as reported): "The Childrenï¿½s House school"
-- Original: "The Childrenï¿½s House school"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "The Children's House school"
UPDATE `schools` SET `schoolname` = CONVERT(X'546865204368696C6472656E277320486F757365207363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23911 AND CAST(`schoolname` AS BINARY) = X'546865204368696C6472656EC3AFC2BFC2BD7320486F757365207363686F6F6C';

-- Entry 251: school id 23912, column `schoolname`, deleted=no
-- School (as reported): "Madeleineï¿½s Pre School"
-- Original: "Madeleineï¿½s Pre School"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Madeleine's Preschool"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6164656C65696E652773205072657363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23912 AND CAST(`schoolname` AS BINARY) = X'4D6164656C65696E65C3AFC2BFC2BD7320507265205363686F6F6C';

-- Entry 252: school id 23921, column `schoolname`, deleted=no
-- School (as reported): "La Maison des Enfants Montessori Childrenï¿½s House"
-- Original: "La Maison des Enfants Montessori Childrenï¿½s House"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "La Maison des Enfants Montessori Children's House"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C61204D6169736F6E2064657320456E66616E7473204D6F6E746573736F7269204368696C6472656E277320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23921 AND CAST(`schoolname` AS BINARY) = X'4C61204D6169736F6E2064657320456E66616E7473204D6F6E746573736F7269204368696C6472656EC3AFC2BFC2BD7320486F757365';

-- Entry 253: school id 23923, column `address1`, deleted=no
-- School (as reported): "Trinity Montessori School - St. Michael's Branch "
-- Original: "1er carrefour ï¿½ gauche aprï¿½s marchï¿½ st Michel en venant de tokpa; immeuble face cdpa"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "1er carrefour à gauche après le marché St Michel en venant de Tokpa ; immeuble face CDPA"
UPDATE `schools` SET `address1` = CONVERT(X'316572206361727265666F757220C3A02067617563686520617072C3A873206C65206D61726368C3A9205374204D696368656C20656E2076656E616E7420646520546F6B7061203B20696D6D6575626C6520666163652043445041' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23923 AND CAST(`address1` AS BINARY) = X'316572206361727265666F757220C3AFC2BFC2BD2067617563686520617072C3AFC2BFC2BD73206D61726368C3AFC2BFC2BD207374204D696368656C20656E2076656E616E7420646520746F6B70613B20696D6D6575626C6520666163652063647061';

-- Entry 254: school id 23933, column `schoolname`, deleted=no
-- School (as reported): "International Montessori House - Mejtaï¿½"
-- Original: "International Montessori House - Mejtaï¿½"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "International Montessori House"
UPDATE `schools` SET `schoolname` = CONVERT(X'496E7465726E6174696F6E616C204D6F6E746573736F726920486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23933 AND CAST(`schoolname` AS BINARY) = X'496E7465726E6174696F6E616C204D6F6E746573736F726920486F757365202D204D656A7461C3AFC2BFC2BD';

-- Entry 255: school id 23938, column `schoolname`, deleted=no
-- School (as reported): "Montessori Childrenï¿½s House"
-- Original: "Montessori Childrenï¿½s House"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Montessori Children's House"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204368696C6472656E277320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23938 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204368696C6472656EC3AFC2BFC2BD7320486F757365';

-- Entry 256: school id 23947, column `affiliations`, deleted=no
-- School (as reported): "Ecole Francaise de Battambang"
-- Original: "Institut Francais du Cambodge ï¿½ Battambang"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Institut Francais du Cambodge Battambang"
UPDATE `schools` SET `affiliations` = CONVERT(X'496E737469747574204672616E636169732064752043616D626F6467652042617474616D62616E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23947 AND CAST(`affiliations` AS BINARY) = X'496E737469747574204672616E636169732064752043616D626F64676520C3AFC2BFC2BD2042617474616D62616E67';

-- Entry 257: school id 23949, column `address1`, deleted=yes
-- School (as reported): "Escuela Montessori de Valparaiso"
-- Original: "Av. Hospital Guillermo Mï¿½nnich 733"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Av. Hospital Guillermo Munnich 733"
UPDATE `schools` SET `address1` = CONVERT(X'41762E20486F73706974616C204775696C6C65726D6F204D756E6E69636820373333' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23949 AND CAST(`address1` AS BINARY) = X'41762E20486F73706974616C204775696C6C65726D6F204DC3AFC2BFC2BD6E6E69636820373333';

-- Entry 258: school id 23949, column `city`, deleted=yes
-- School (as reported): "Escuela Montessori de Valparaiso"
-- Original: "Valparaï¿½so"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Valparaiso"
UPDATE `schools` SET `city` = CONVERT(X'56616C7061726169736F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23949 AND CAST(`city` AS BINARY) = X'56616C70617261C3AFC2BFC2BD736F';

-- Entry 259: school id 23951, column `address2`, deleted=yes
-- School (as reported): "Highlands Montessori School"
-- Original: " Las Pircas, Peï¿½alolï¿½n"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Las Pircas, Peñalolén"
UPDATE `schools` SET `address2` = CONVERT(X'4C6173205069726361732C205065C3B1616C6F6CC3A96E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23951 AND CAST(`address2` AS BINARY) = X'204C6173205069726361732C205065C3AFC2BFC2BD616C6F6CC3AFC2BFC2BD6E';

-- Entry 260: school id 23953, column `address1`, deleted=yes
-- School (as reported): "Colegio Barrie Montessori"
-- Original: "ï¿½lvaro Casanova 701"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Álvaro Casanova 701"
UPDATE `schools` SET `address1` = CONVERT(X'C3816C7661726F20436173616E6F766120373031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23953 AND CAST(`address1` AS BINARY) = X'C3AFC2BFC2BD6C7661726F20436173616E6F766120373031';

-- Entry 261: school id 23953, column `address2`, deleted=yes
-- School (as reported): "Colegio Barrie Montessori"
-- Original: "Peï¿½alolï¿½n "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Peñalolén"
UPDATE `schools` SET `address2` = CONVERT(X'5065C3B1616C6F6CC3A96E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23953 AND CAST(`address2` AS BINARY) = X'5065C3AFC2BFC2BD616C6F6CC3AFC2BFC2BD6E20';

-- Entry 262: school id 23999, column `schoolname`, deleted=no
-- School (as reported): "MonÃº Montessori Nursery"
-- Original: "MonÃº Montessori Nursery"
-- Proposed: "Monú Montessori Nursery"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6EC3BA204D6F6E746573736F7269204E757273657279' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 23999 AND CAST(`schoolname` AS BINARY) = X'4D6F6EC383C2BA204D6F6E746573736F7269204E757273657279';

-- Entry 263: school id 24000, column `address2`, deleted=no
-- School (as reported): "Blue Valley School"
-- Original: "Multiplaza, 1.2 Km. northwest, right hand side of the road, GuachipelÃ­n, EscazÃº"
-- Proposed: "Multiplaza, 1.2 Km. northwest, right hand side of the road, Guachipelín, Escazú"
UPDATE `schools` SET `address2` = CONVERT(X'4D756C7469706C617A612C20312E32204B6D2E206E6F727468776573742C2072696768742068616E642073696465206F662074686520726F61642C2047756163686970656CC3AD6E2C20457363617AC3BA' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24000 AND CAST(`address2` AS BINARY) = X'4D756C7469706C617A612C20312E32204B6D2E206E6F727468776573742C2072696768742068616E642073696465206F662074686520726F61642C2047756163686970656CC383C2AD6E2C20457363617AC383C2BA';

-- Entry 264: school id 24001, column `address1`, deleted=no
-- School (as reported): "Kinder TÃ­o Conejo- Saint Michael School Preschool"
-- Original: "Desamparados, San JosÃ©, CR 200 Sur y 200 "
-- Decoded (before cleanup): "Desamparados, San José, CR 200 Sur y 200 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Desamparados, San José, CR 200 Sur y 200"
UPDATE `schools` SET `address1` = CONVERT(X'446573616D70617261646F732C2053616E204A6F73C3A92C2043522032303020537572207920323030' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24001 AND CAST(`address1` AS BINARY) = X'446573616D70617261646F732C2053616E204A6F73C383C2A92C204352203230302053757220792032303020';

-- Entry 265: school id 24001, column `contactname`, deleted=no
-- School (as reported): "Kinder TÃ­o Conejo- Saint Michael School Preschool"
-- Original: "MarÃ­a de los Ãngeles FernÃ¡ndez Kooper"
-- Proposed: "María de los Ángeles Fernández Kooper"
UPDATE `schools` SET `contactname` = CONVERT(X'4D6172C3AD61206465206C6F7320C3816E67656C6573204665726EC3A16E64657A204B6F6F706572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24001 AND CAST(`contactname` AS BINARY) = X'4D6172C383C2AD61206465206C6F7320C383C2816E67656C6573204665726EC383C2A16E64657A204B6F6F706572';

-- Entry 266: school id 24001, column `headofschoolname`, deleted=no
-- School (as reported): "Kinder TÃ­o Conejo- Saint Michael School Preschool"
-- Original: "MarÃ­a de los Ãngeles FernÃ¡ndez Kooper"
-- Proposed: "María de los Ángeles Fernández Kooper"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D6172C3AD61206465206C6F7320C3816E67656C6573204665726EC3A16E64657A204B6F6F706572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24001 AND CAST(`headofschoolname` AS BINARY) = X'4D6172C383C2AD61206465206C6F7320C383C2816E67656C6573204665726EC383C2A16E64657A204B6F6F706572';

-- Entry 267: school id 24001, column `schoolname`, deleted=no
-- School (as reported): "Kinder TÃ­o Conejo- Saint Michael School Preschool"
-- Original: "Kinder TÃ­o Conejo- Saint Michael School Preschool"
-- Proposed: "Kinder Tío Conejo- Saint Michael School Preschool"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B696E6465722054C3AD6F20436F6E656A6F2D205361696E74204D69636861656C205363686F6F6C205072657363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24001 AND CAST(`schoolname` AS BINARY) = X'4B696E6465722054C383C2AD6F20436F6E656A6F2D205361696E74204D69636861656C205363686F6F6C205072657363686F6F6C';

-- Entry 268: school id 24015, column `address1`, deleted=no
-- School (as reported): "Duhovka Preschool - Prague 6 - Hanspaulka"
-- Original: "Kozlovskï¿½ 9"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Kozlovská 9"
UPDATE `schools` SET `address1` = CONVERT(X'4B6F7A6C6F76736BC3A12039' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24015 AND CAST(`address1` AS BINARY) = X'4B6F7A6C6F76736BC3AFC2BFC2BD2039';

-- Entry 269: school id 24016, column `address1`, deleted=no
-- School (as reported): "Duhovka Preschool - Prague 1 - Malï¿½ strana"
-- Original: "Cihelnï¿½ 2"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Cihelná 2"
UPDATE `schools` SET `address1` = CONVERT(X'436968656C6EC3A12032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24016 AND CAST(`address1` AS BINARY) = X'436968656C6EC3AFC2BFC2BD2032';

-- Entry 270: school id 24016, column `schoolname`, deleted=no
-- School (as reported): "Duhovka Preschool - Prague 1 - Malï¿½ strana"
-- Original: "Duhovka Preschool - Prague 1 - Malï¿½ strana"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Duhovka Preschool - Prague 1 - Malá Strana"
UPDATE `schools` SET `schoolname` = CONVERT(X'4475686F766B61205072657363686F6F6C202D205072616775652031202D204D616CC3A120537472616E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24016 AND CAST(`schoolname` AS BINARY) = X'4475686F766B61205072657363686F6F6C202D205072616775652031202D204D616CC3AFC2BFC2BD20737472616E61';

-- Entry 271: school id 24018, column `address1`, deleted=no
-- School (as reported): "MateÅ™skï¿½ Montessori ï¿½kolka ZvoneÄek "
-- Original: "K TÅ™esÅˆovce 64"
-- Proposed: "K Třesňovce 64"
UPDATE `schools` SET `address1` = CONVERT(X'4B2054C5996573C5886F766365203634' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24018 AND CAST(`address1` AS BINARY) = X'4B2054C385E284A26573C385CB866F766365203634';

-- Entry 272: school id 24018, column `city`, deleted=no
-- School (as reported): "MateÅ™skï¿½ Montessori ï¿½kolka ZvoneÄek "
-- Original: "Karlï¿½k"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Karlík"
UPDATE `schools` SET `city` = CONVERT(X'4B61726CC3AD6B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24018 AND CAST(`city` AS BINARY) = X'4B61726CC3AFC2BFC2BD6B';

-- Entry 273: school id 24018, column `schoolname`, deleted=no
-- School (as reported): "MateÅ™skï¿½ Montessori ï¿½kolka ZvoneÄek "
-- Original: "MateÅ™skï¿½ Montessori ï¿½kolka ZvoneÄek "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Mateřská Montessori školka Zvoneček"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D617465C599736BC3A1204D6F6E746573736F726920C5A16B6F6C6B61205A766F6E65C48D656B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24018 AND CAST(`schoolname` AS BINARY) = X'4D617465C385E284A2736BC3AFC2BFC2BD204D6F6E746573736F726920C3AFC2BFC2BD6B6F6C6B61205A766F6E65C384C28D656B20';

-- Entry 274: school id 24019, column `address1`, deleted=no
-- School (as reported): "Montessori Children's House"
-- Original: "Nad ÃšdolÃ­m 338/62"
-- Proposed: "Nad Údolím 338/62"
UPDATE `schools` SET `address1` = CONVERT(X'4E616420C39A646F6CC3AD6D203333382F3632' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24019 AND CAST(`address1` AS BINARY) = X'4E616420C383C5A1646F6CC383C2AD6D203333382F3632';

-- Entry 275: school id 24019, column `city`, deleted=no
-- School (as reported): "Montessori Children's House"
-- Original: "Praha 4 ï¿½ HodkoviÄky"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Praha 4 – Hodkovičky"
UPDATE `schools` SET `city` = CONVERT(X'5072616861203420E2809320486F646B6F7669C48D6B79' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24019 AND CAST(`city` AS BINARY) = X'5072616861203420C3AFC2BFC2BD20486F646B6F7669C384C28D6B79';

-- Entry 276: school id 24021, column `address1`, deleted=no
-- School (as reported): "Botika Montessori dum"
-- Original: "KoÅ¡ickÃ¡ 15 "
-- Decoded (before cleanup): "Košická 15 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Košická 15"
UPDATE `schools` SET `address1` = CONVERT(X'4B6FC5A169636BC3A1203135' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24021 AND CAST(`address1` AS BINARY) = X'4B6FC385C2A169636BC383C2A120313520';

-- Entry 277: school id 24024, column `address1`, deleted=no
-- School (as reported): "Montessori RC Vyï¿½ehrï¿½dek"
-- Original: "Community Center JasoÅˆ"
-- Proposed: "Community Center Jasoň"
UPDATE `schools` SET `address1` = CONVERT(X'436F6D6D756E6974792043656E746572204A61736FC588' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24024 AND CAST(`address1` AS BINARY) = X'436F6D6D756E6974792043656E746572204A61736FC385CB86';

-- Entry 278: school id 24024, column `address2`, deleted=no
-- School (as reported): "Montessori RC Vyï¿½ehrï¿½dek"
-- Original: "ZÃ¡toÅˆskÃ¡ 1/15"
-- Proposed: "Zátoňská 1/15"
UPDATE `schools` SET `address2` = CONVERT(X'5AC3A1746FC588736BC3A120312F3135' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24024 AND CAST(`address2` AS BINARY) = X'5AC383C2A1746FC385CB86736BC383C2A120312F3135';

-- Entry 279: school id 24024, column `schoolname`, deleted=no
-- School (as reported): "Montessori RC Vyï¿½ehrï¿½dek"
-- Original: "Montessori RC Vyï¿½ehrï¿½dek"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Montessori RC Vyšehrádek"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269205243205679C5A1656872C3A164656B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24024 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269205243205679C3AFC2BFC2BD656872C3AFC2BFC2BD64656B';

-- Entry 280: school id 24025, column `address1`, deleted=no
-- School (as reported): "Spiralka Montessori Skolka a jesle "
-- Original: "Nad Hï¿½jem 3"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Nad Hájem 3"
UPDATE `schools` SET `address1` = CONVERT(X'4E61642048C3A16A656D2033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24025 AND CAST(`address1` AS BINARY) = X'4E61642048C3AFC2BFC2BD6A656D2033';

-- Entry 281: school id 24028, column `address1`, deleted=no
-- School (as reported): "MateÅ™skï¿½ ï¿½kola Vokovickï¿½"
-- Original: "VokovickÃ¡ 28 / 12a"
-- Proposed: "Vokovická 28 / 12a"
UPDATE `schools` SET `address1` = CONVERT(X'566F6B6F7669636BC3A1203238202F20313261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24028 AND CAST(`address1` AS BINARY) = X'566F6B6F7669636BC383C2A1203238202F20313261';

-- Entry 282: school id 24028, column `contactname`, deleted=no
-- School (as reported): "MateÅ™skï¿½ ï¿½kola Vokovickï¿½"
-- Original: "Lenka SmejkalovÃ¡"
-- Proposed: "Lenka Smejkalová"
UPDATE `schools` SET `contactname` = CONVERT(X'4C656E6B6120536D656A6B616C6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24028 AND CAST(`contactname` AS BINARY) = X'4C656E6B6120536D656A6B616C6F76C383C2A1';

-- Entry 283: school id 24028, column `headofschoolname`, deleted=no
-- School (as reported): "MateÅ™skï¿½ ï¿½kola Vokovickï¿½"
-- Original: "Lenka SmejkalovÃ¡"
-- Proposed: "Lenka Smejkalová"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4C656E6B6120536D656A6B616C6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24028 AND CAST(`headofschoolname` AS BINARY) = X'4C656E6B6120536D656A6B616C6F76C383C2A1';

-- Entry 284: school id 24028, column `schoolname`, deleted=no
-- School (as reported): "MateÅ™skï¿½ ï¿½kola Vokovickï¿½"
-- Original: "MateÅ™skï¿½ ï¿½kola Vokovickï¿½"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Mateřská škola Vokovická"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D617465C599736BC3A120C5A16B6F6C6120566F6B6F7669636BC3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24028 AND CAST(`schoolname` AS BINARY) = X'4D617465C385E284A2736BC3AFC2BFC2BD20C3AFC2BFC2BD6B6F6C6120566F6B6F7669636BC3AFC2BFC2BD';

-- Entry 285: school id 24029, column `address1`, deleted=no
-- School (as reported): "Klub Montessori"
-- Original: "TvrdÃ©ho 47"
-- Proposed: "Tvrdého 47"
UPDATE `schools` SET `address1` = CONVERT(X'54767264C3A9686F203437' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24029 AND CAST(`address1` AS BINARY) = X'54767264C383C2A9686F203437';

-- Entry 286: school id 24029, column `city`, deleted=no
-- School (as reported): "Klub Montessori"
-- Original: "Prague 9 - LetÅˆany"
-- Proposed: "Prague 9 - Letňany"
UPDATE `schools` SET `city` = CONVERT(X'5072616775652039202D204C6574C588616E79' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24029 AND CAST(`city` AS BINARY) = X'5072616775652039202D204C6574C385CB86616E79';

-- Entry 287: school id 24031, column `address1`, deleted=no
-- School (as reported): "Sofie Materska A Zakladni Skola Ricany"
-- Original: "Å½iÅ¾kova 286/12"
-- Proposed: "Žižkova 286/12"
UPDATE `schools` SET `address1` = CONVERT(X'C5BD69C5BE6B6F7661203238362F3132' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24031 AND CAST(`address1` AS BINARY) = X'C385C2BD69C385C2BE6B6F7661203238362F3132';

-- Entry 288: school id 24031, column `city`, deleted=no
-- School (as reported): "Sofie Materska A Zakladni Skola Ricany"
-- Original: "Å˜iÄany"
-- Proposed: "Řičany"
UPDATE `schools` SET `city` = CONVERT(X'C59869C48D616E79' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24031 AND CAST(`city` AS BINARY) = X'C385CB9C69C384C28D616E79';

-- Entry 289: school id 24036, column `address1`, deleted=no
-- School (as reported): "Montessori International Preschool Valby"
-- Original: "SÃ¸ndermarksvej 13"
-- Proposed: "Søndermarksvej 13"
UPDATE `schools` SET `address1` = CONVERT(X'53C3B86E6465726D61726B7376656A203133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24036 AND CAST(`address1` AS BINARY) = X'53C383C2B86E6465726D61726B7376656A203133';

-- Entry 290: school id 24057, column `address1`, deleted=no
-- School (as reported): "International Montessori School"
-- Original: "YismÃ¤e 24"
-- Proposed: "Yismäe 24"
UPDATE `schools` SET `address1` = CONVERT(X'5969736DC3A465203234' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24057 AND CAST(`address1` AS BINARY) = X'5969736DC383C2A465203234';

-- Entry 291: school id 24061, column `contactname`, deleted=no
-- School (as reported): "Lasten Montessorikoulu"
-- Original: "Ulla Heikkilï¿½"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Ulla Heikkilä"
UPDATE `schools` SET `contactname` = CONVERT(X'556C6C61204865696B6B696CC3A4' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24061 AND CAST(`contactname` AS BINARY) = X'556C6C61204865696B6B696CC3AFC2BFC2BD';

-- Entry 292: school id 24061, column `headofschoolname`, deleted=no
-- School (as reported): "Lasten Montessorikoulu"
-- Original: "Ulla Heikkilï¿½"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Ulla Heikkilä"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'556C6C61204865696B6B696CC3A4' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24061 AND CAST(`headofschoolname` AS BINARY) = X'556C6C61204865696B6B696CC3AFC2BFC2BD';

-- Entry 293: school id 24067, column `address1`, deleted=no
-- School (as reported): "Herttoniemen Montessori-leikkikoulu"
-- Original: "MÃ¤yrÃ¤tie 2"
-- Proposed: "Mäyrätie 2"
UPDATE `schools` SET `address1` = CONVERT(X'4DC3A47972C3A47469652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24067 AND CAST(`address1` AS BINARY) = X'4DC383C2A47972C383C2A47469652032';

-- Entry 294: school id 24071, column `schoolname`, deleted=no
-- School (as reported): "TÃ¶Ã¶lÃ¶n Montessori-leikkikoulu"
-- Original: "TÃ¶Ã¶lÃ¶n Montessori-leikkikoulu"
-- Proposed: "Töölön Montessori-leikkikoulu"
UPDATE `schools` SET `schoolname` = CONVERT(X'54C3B6C3B66CC3B66E204D6F6E746573736F72692D6C65696B6B696B6F756C75' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24071 AND CAST(`schoolname` AS BINARY) = X'54C383C2B6C383C2B66CC383C2B66E204D6F6E746573736F72692D6C65696B6B696B6F756C75';

-- Entry 295: school id 24073, column `schoolname`, deleted=no
-- School (as reported): "Montessoripï¿½ivï¿½koti Mammolina"
-- Original: "Montessoripï¿½ivï¿½koti Mammolina"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Montessoripäiväkoti Mammolina"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726970C3A46976C3A46B6F7469204D616D6D6F6C696E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24073 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726970C3AFC2BFC2BD6976C3AFC2BFC2BD6B6F7469204D616D6D6F6C696E61';

-- Entry 296: school id 24075, column `schoolname`, deleted=no
-- School (as reported): "Kirkkopuiston Montessori-pï¿½ivï¿½koti"
-- Original: "Kirkkopuiston Montessori-pï¿½ivï¿½koti"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Kirkkopuiston Montessori-päiväkoti"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B69726B6B6F70756973746F6E204D6F6E746573736F72692D70C3A46976C3A46B6F7469' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24075 AND CAST(`schoolname` AS BINARY) = X'4B69726B6B6F70756973746F6E204D6F6E746573736F72692D70C3AFC2BFC2BD6976C3AFC2BFC2BD6B6F7469';

-- Entry 297: school id 24077, column `contactname`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Kiva Paikka"
-- Original: "Teresa Tuikka and Sari RÃ¤ty "
-- Decoded (before cleanup): "Teresa Tuikka and Sari Räty "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Teresa Tuikka and Sari Räty"
UPDATE `schools` SET `contactname` = CONVERT(X'546572657361205475696B6B6120616E6420536172692052C3A47479' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24077 AND CAST(`contactname` AS BINARY) = X'546572657361205475696B6B6120616E6420536172692052C383C2A4747920';

-- Entry 298: school id 24077, column `headofschoolname`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Kiva Paikka"
-- Original: "Teresa Tuikka and Sari RÃ¤ty "
-- Decoded (before cleanup): "Teresa Tuikka and Sari Räty "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Teresa Tuikka and Sari Räty"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'546572657361205475696B6B6120616E6420536172692052C3A47479' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24077 AND CAST(`headofschoolname` AS BINARY) = X'546572657361205475696B6B6120616E6420536172692052C383C2A4747920';

-- Entry 299: school id 24077, column `schoolname`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Kiva Paikka"
-- Original: "MontessoripÃ¤ivÃ¤koti Kiva Paikka"
-- Proposed: "Montessoripäiväkoti Kiva Paikka"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726970C3A46976C3A46B6F7469204B697661205061696B6B61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24077 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726970C383C2A46976C383C2A46B6F7469204B697661205061696B6B61';

-- Entry 300: school id 24078, column `address1`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Mio"
-- Original: "KÃ¤Ã¤pÃ¤katu 5"
-- Proposed: "Kääpäkatu 5"
UPDATE `schools` SET `address1` = CONVERT(X'4BC3A4C3A470C3A46B6174752035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24078 AND CAST(`address1` AS BINARY) = X'4BC383C2A4C383C2A470C383C2A46B6174752035';

-- Entry 301: school id 24078, column `schoolname`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Mio"
-- Original: "MontessoripÃ¤ivÃ¤koti Mio"
-- Proposed: "Montessoripäiväkoti Mio"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726970C3A46976C3A46B6F7469204D696F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24078 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726970C383C2A46976C383C2A46B6F7469204D696F';

-- Entry 302: school id 24079, column `address1`, deleted=no
-- School (as reported): "Lahden Montessori-leikkikoulu"
-- Original: "MÃ¤ntyrinteenkatu 3 "
-- Decoded (before cleanup): "Mäntyrinteenkatu 3 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Mäntyrinteenkatu 3"
UPDATE `schools` SET `address1` = CONVERT(X'4DC3A46E747972696E7465656E6B6174752033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24079 AND CAST(`address1` AS BINARY) = X'4DC383C2A46E747972696E7465656E6B617475203320';

-- Entry 303: school id 24081, column `city`, deleted=no
-- School (as reported): "MÃ¤ntsÃ¤lÃ¤n englanninkielinen Montessori-leikkikoulu"
-- Original: " MÃ¤ntsÃ¤lÃ¤"
-- Decoded (before cleanup): " Mäntsälä"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Mäntsälä"
UPDATE `schools` SET `city` = CONVERT(X'4DC3A46E7473C3A46CC3A4' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24081 AND CAST(`city` AS BINARY) = X'204DC383C2A46E7473C383C2A46CC383C2A4';

-- Entry 304: school id 24081, column `schoolname`, deleted=no
-- School (as reported): "MÃ¤ntsÃ¤lÃ¤n englanninkielinen Montessori-leikkikoulu"
-- Original: "MÃ¤ntsÃ¤lÃ¤n englanninkielinen Montessori-leikkikoulu"
-- Proposed: "Mäntsälän englanninkielinen Montessori-leikkikoulu"
UPDATE `schools` SET `schoolname` = CONVERT(X'4DC3A46E7473C3A46CC3A46E20656E676C616E6E696E6B69656C696E656E204D6F6E746573736F72692D6C65696B6B696B6F756C75' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24081 AND CAST(`schoolname` AS BINARY) = X'4DC383C2A46E7473C383C2A46CC383C2A46E20656E676C616E6E696E6B69656C696E656E204D6F6E746573736F72692D6C65696B6B696B6F756C75';

-- Entry 305: school id 24082, column `schoolname`, deleted=no
-- School (as reported): "Oulun Montessori-pÃ¤ivÃ¤koti "
-- Original: "Oulun Montessori-pÃ¤ivÃ¤koti "
-- Decoded (before cleanup): "Oulun Montessori-päiväkoti "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Oulun Montessori-päiväkoti"
UPDATE `schools` SET `schoolname` = CONVERT(X'4F756C756E204D6F6E746573736F72692D70C3A46976C3A46B6F7469' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24082 AND CAST(`schoolname` AS BINARY) = X'4F756C756E204D6F6E746573736F72692D70C383C2A46976C383C2A46B6F746920';

-- Entry 306: school id 24083, column `contactname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Salo"
-- Original: "PÃ¤ivi Isopuro"
-- Proposed: "Päivi Isopuro"
UPDATE `schools` SET `contactname` = CONVERT(X'50C3A46976692049736F7075726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24083 AND CAST(`contactname` AS BINARY) = X'50C383C2A46976692049736F7075726F';

-- Entry 307: school id 24083, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Salo"
-- Original: "PÃ¤ivi Isopuro"
-- Proposed: "Päivi Isopuro"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'50C3A46976692049736F7075726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24083 AND CAST(`headofschoolname` AS BINARY) = X'50C383C2A46976692049736F7075726F';

-- Entry 308: school id 24083, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Salo"
-- Original: "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Salo"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Montessori-Päiväkoti Aurinkoleijona - Salo"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D50C3A46976C3A46B6F746920417572696E6B6F6C65696A6F6E61202D2053616C6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24083 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D50C3AFC2BFC2BD6976C3AFC2BFC2BD6B6F746920417572696E6B6F6C65696A6F6E61202D2053616C6F';

-- Entry 309: school id 24084, column `contactname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Halikko"
-- Original: "PÃ¤ivi Isopuro"
-- Proposed: "Päivi Isopuro"
UPDATE `schools` SET `contactname` = CONVERT(X'50C3A46976692049736F7075726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24084 AND CAST(`contactname` AS BINARY) = X'50C383C2A46976692049736F7075726F';

-- Entry 310: school id 24084, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Halikko"
-- Original: "PÃ¤ivi Isopuro"
-- Proposed: "Päivi Isopuro"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'50C3A46976692049736F7075726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24084 AND CAST(`headofschoolname` AS BINARY) = X'50C383C2A46976692049736F7075726F';

-- Entry 311: school id 24084, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Halikko"
-- Original: "Montessori-Pï¿½ivï¿½koti Aurinkoleijona - Halikko"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Montessori-Päiväkoti Aurinkoleijona - Halikko"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D50C3A46976C3A46B6F746920417572696E6B6F6C65696A6F6E61202D2048616C696B6B6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24084 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D50C3AFC2BFC2BD6976C3AFC2BFC2BD6B6F746920417572696E6B6F6C65696A6F6E61202D2048616C696B6B6F';

-- Entry 312: school id 24087, column `address1`, deleted=no
-- School (as reported): "Rantakaislan MontessoripÃ¤ivÃ¤koti"
-- Original: "KylÃ¤kaivontie 6"
-- Proposed: "Kyläkaivontie 6"
UPDATE `schools` SET `address1` = CONVERT(X'4B796CC3A46B6169766F6E7469652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24087 AND CAST(`address1` AS BINARY) = X'4B796CC383C2A46B6169766F6E7469652036';

-- Entry 313: school id 24087, column `schoolname`, deleted=no
-- School (as reported): "Rantakaislan MontessoripÃ¤ivÃ¤koti"
-- Original: "Rantakaislan MontessoripÃ¤ivÃ¤koti"
-- Proposed: "Rantakaislan Montessoripäiväkoti"
UPDATE `schools` SET `schoolname` = CONVERT(X'52616E74616B6169736C616E204D6F6E746573736F726970C3A46976C3A46B6F7469' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24087 AND CAST(`schoolname` AS BINARY) = X'52616E74616B6169736C616E204D6F6E746573736F726970C383C2A46976C383C2A46B6F7469';

-- Entry 314: school id 24089, column `schoolname`, deleted=no
-- School (as reported): "MontessoripÃ¤ivÃ¤koti Montsa"
-- Original: "MontessoripÃ¤ivÃ¤koti Montsa"
-- Proposed: "Montessoripäiväkoti Montsa"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726970C3A46976C3A46B6F7469204D6F6E747361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24089 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726970C383C2A46976C383C2A46B6F7469204D6F6E747361';

-- Entry 315: school id 24091, column `city`, deleted=yes
-- School (as reported): "Ecole Montessori de Besanï¿½on"
-- Original: "Besanï¿½on"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Besançon"
UPDATE `schools` SET `city` = CONVERT(X'426573616EC3A76F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24091 AND CAST(`city` AS BINARY) = X'426573616EC3AFC2BFC2BD6F6E';

-- Entry 316: school id 24091, column `schoolname`, deleted=yes
-- School (as reported): "Ecole Montessori de Besanï¿½on"
-- Original: "Ecole Montessori de Besanï¿½on"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Ecole Montessori de Besançon"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920646520426573616EC3A76F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24091 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920646520426573616EC3AFC2BFC2BD6F6E';

-- Entry 317: school id 24092, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori Les Infatigables Explorateurs Clermont-Ferrand"
-- Original: "8 rue AmÃ©lie Murat"
-- Proposed: "8 rue Amélie Murat"
UPDATE `schools` SET `address1` = CONVERT(X'382072756520416DC3A96C6965204D75726174' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24092 AND CAST(`address1` AS BINARY) = X'382072756520416DC383C2A96C6965204D75726174';

-- Entry 318: school id 24094, column `address1`, deleted=no
-- School (as reported): "Ecole Lestonnac- Maternelle et Primaire"
-- Original: "2 boulevard des TchÃ©coslovaques"
-- Proposed: "2 boulevard des Tchécoslovaques"
UPDATE `schools` SET `address1` = CONVERT(X'3220626F756C65766172642064657320546368C3A9636F736C6F766171756573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24094 AND CAST(`address1` AS BINARY) = X'3220626F756C65766172642064657320546368C383C2A9636F736C6F766171756573';

-- Entry 319: school id 24095, column `address1`, deleted=no
-- School (as reported): "Secrets d'Enfance Bilingual Montessori School"
-- Original: "28, boulevard de lâ€™Europe"
-- Proposed: "28, boulevard de l’Europe"
UPDATE `schools` SET `address1` = CONVERT(X'32382C20626F756C6576617264206465206CE280994575726F7065' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24095 AND CAST(`address1` AS BINARY) = X'32382C20626F756C6576617264206465206CC3A2E282ACE284A24575726F7065';

-- Entry 320: school id 24100, column `address1`, deleted=no
-- School (as reported): "Wi School Courbevoie Centre"
-- Original: "104, Avenue de la RÃ©publique"
-- Proposed: "104, Avenue de la République"
UPDATE `schools` SET `address1` = CONVERT(X'3130342C204176656E7565206465206C612052C3A97075626C69717565' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24100 AND CAST(`address1` AS BINARY) = X'3130342C204176656E7565206465206C612052C383C2A97075626C69717565';

-- Entry 321: school id 24101, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori dâ€™Avignon"
-- Original: "Ã‰cole Montessori dâ€™Avignon"
-- Proposed: "École Montessori d’Avignon"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F72692064E28099417669676E6F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24101 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F72692064C3A2E282ACE284A2417669676E6F6E';

-- Entry 322: school id 24103, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori Internationale Le KalÃ©idoscope"
-- Original: "Ã‰cole Montessori Internationale Le KalÃ©idoscope"
-- Proposed: "École Montessori Internationale Le Kaléidoscope"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65204C65204B616CC3A969646F73636F7065' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24103 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65204C65204B616CC383C2A969646F73636F7065';

-- Entry 323: school id 24104, column `city`, deleted=no
-- School (as reported): "Ecole Montessori au Mont d'Or"
-- Original: "Neuville-sur-SaÃ´ne"
-- Proposed: "Neuville-sur-Saône"
UPDATE `schools` SET `city` = CONVERT(X'4E657576696C6C652D7375722D5361C3B46E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24104 AND CAST(`city` AS BINARY) = X'4E657576696C6C652D7375722D5361C383C2B46E65';

-- Entry 324: school id 24104, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessori au Mont d'Or"
-- Original: "CÃ©cile Canot-Peyrache"
-- Proposed: "Cécile Canot-Peyrache"
UPDATE `schools` SET `contactname` = CONVERT(X'43C3A963696C652043616E6F742D5065797261636865' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24104 AND CAST(`contactname` AS BINARY) = X'43C383C2A963696C652043616E6F742D5065797261636865';

-- Entry 325: school id 24104, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori au Mont d'Or"
-- Original: "CÃ©cile Canot-Peyrache"
-- Proposed: "Cécile Canot-Peyrache"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'43C3A963696C652043616E6F742D5065797261636865' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24104 AND CAST(`headofschoolname` AS BINARY) = X'43C383C2A963696C652043616E6F742D5065797261636865';

-- Entry 326: school id 24105, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori- Aide-moi Ã  penser par moi-mÃªme"
-- Original: "Ecole Montessori- Aide-moi Ã  penser par moi-mÃªme"
-- Proposed: "Ecole Montessori- Aide-moi à penser par moi-même"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F72692D20416964652D6D6F6920C3A02070656E73657220706172206D6F692D6DC3AA6D65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24105 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F72692D20416964652D6D6F6920C383C2A02070656E73657220706172206D6F692D6DC383C2AA6D65';

-- Entry 327: school id 24108, column `schoolname`, deleted=no
-- School (as reported): "La Maison des Enfants Ecole Montessori trilingue  franÃ§ais-anglais-espagnol"
-- Original: "La Maison des Enfants Ecole Montessori trilingue  franÃ§ais-anglais-espagnol"
-- Proposed: "La Maison des Enfants Ecole Montessori trilingue  français-anglais-espagnol"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C61204D6169736F6E2064657320456E66616E74732045636F6C65204D6F6E746573736F7269207472696C696E67756520206672616EC3A76169732D616E676C6169732D65737061676E6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24108 AND CAST(`schoolname` AS BINARY) = X'4C61204D6169736F6E2064657320456E66616E74732045636F6C65204D6F6E746573736F7269207472696C696E67756520206672616EC383C2A76169732D616E676C6169732D65737061676E6F6C';

-- Entry 328: school id 24110, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori Croque la Vie"
-- Original: "35, Chemin de la CharriÃ¨re"
-- Proposed: "35, Chemin de la Charrière"
UPDATE `schools` SET `address1` = CONVERT(X'33352C204368656D696E206465206C6120436861727269C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24110 AND CAST(`address1` AS BINARY) = X'33352C204368656D696E206465206C6120436861727269C383C2A87265';

-- Entry 329: school id 24112, column `schoolname`, deleted=no
-- School (as reported): "Ecoles Montessori de BeausÃ©jour & St-Denis"
-- Original: "Ecoles Montessori de BeausÃ©jour & St-Denis"
-- Proposed: "Ecoles Montessori de Beauséjour & St-Denis"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C6573204D6F6E746573736F7269206465204265617573C3A96A6F757220262053742D44656E6973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24112 AND CAST(`schoolname` AS BINARY) = X'45636F6C6573204D6F6E746573736F7269206465204265617573C383C2A96A6F757220262053742D44656E6973';

-- Entry 330: school id 24116, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori Bilingue de Rueil-Malmaison"
-- Original: "4b/6 avenue de lâ€™ImpÃ©ratrice JosÃ©phine"
-- Proposed: "4b/6 avenue de l’Impératrice Joséphine"
UPDATE `schools` SET `address1` = CONVERT(X'34622F36206176656E7565206465206CE28099496D70C3A972617472696365204A6F73C3A97068696E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24116 AND CAST(`address1` AS BINARY) = X'34622F36206176656E7565206465206CC3A2E282ACE284A2496D70C383C2A972617472696365204A6F73C383C2A97068696E65';

-- Entry 331: school id 24120, column `address1`, deleted=no
-- School (as reported): "Ã‰cole Montessori de Paris"
-- Original: "13 rue de la Grange BateliÃ¨re"
-- Proposed: "13 rue de la Grange Batelière"
UPDATE `schools` SET `address1` = CONVERT(X'313320727565206465206C61204772616E676520426174656C69C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24120 AND CAST(`address1` AS BINARY) = X'313320727565206465206C61204772616E676520426174656C69C383C2A87265';

-- Entry 332: school id 24120, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori de Paris"
-- Original: "Ã‰cole Montessori de Paris"
-- Proposed: "École Montessori de Paris"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F7269206465205061726973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24120 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F7269206465205061726973';

-- Entry 333: school id 24129, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori de Rouen"
-- Original: "Cours St. Joseph Notre Dame 4 Rue Verdiï¿½re"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Cours St. Joseph Notre Dame 4 Rue Verdière"
UPDATE `schools` SET `address1` = CONVERT(X'436F7572732053742E204A6F73657068204E6F7472652044616D65203420527565205665726469C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24129 AND CAST(`address1` AS BINARY) = X'436F7572732053742E204A6F73657068204E6F7472652044616D65203420527565205665726469C3AFC2BFC2BD7265';

-- Entry 334: school id 24134, column `headofschoolname`, deleted=no
-- School (as reported): "Rainbow School Paris"
-- Original: "BÃ©nÃ©dicte"
-- Proposed: "Bénédicte"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'42C3A96EC3A96469637465' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24134 AND CAST(`headofschoolname` AS BINARY) = X'42C383C2A96EC383C2A96469637465';

-- Entry 335: school id 24135, column `city`, deleted=no
-- School (as reported): "Malherbe International School "
-- Original: "Le VÃ©sinet"
-- Proposed: "Le Vésinet"
UPDATE `schools` SET `city` = CONVERT(X'4C652056C3A973696E6574' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24135 AND CAST(`city` AS BINARY) = X'4C652056C383C2A973696E6574';

-- Entry 336: school id 24137, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori Bilingue du Valromey"
-- Original: "Ã‰cole Montessori Bilingue du Valromey"
-- Proposed: "École Montessori Bilingue du Valromey"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F72692042696C696E6775652064752056616C726F6D6579' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24137 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F72692042696C696E6775652064752056616C726F6D6579';

-- Entry 337: school id 24138, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori dâ€™Antibes"
-- Original: "Ã‰cole Montessori dâ€™Antibes"
-- Proposed: "École Montessori d’Antibes"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F72692064E28099416E7469626573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24138 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F72692064C3A2E282ACE284A2416E7469626573';

-- Entry 338: school id 24139, column `contactname`, deleted=no
-- School (as reported): " Ecole Amadeus"
-- Original: "Sandrine Corradi AllÃ©gatiÃ¨re"
-- Proposed: "Sandrine Corradi Allégatière"
UPDATE `schools` SET `contactname` = CONVERT(X'53616E6472696E6520436F727261646920416C6CC3A967617469C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24139 AND CAST(`contactname` AS BINARY) = X'53616E6472696E6520436F727261646920416C6CC383C2A967617469C383C2A87265';

-- Entry 339: school id 24139, column `headofschoolname`, deleted=no
-- School (as reported): " Ecole Amadeus"
-- Original: "Sandrine Corradi AllÃ©gatiÃ¨re"
-- Proposed: "Sandrine Corradi Allégatière"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'53616E6472696E6520436F727261646920416C6CC3A967617469C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24139 AND CAST(`headofschoolname` AS BINARY) = X'53616E6472696E6520436F727261646920416C6CC383C2A967617469C383C2A87265';

-- Entry 340: school id 24141, column `address1`, deleted=no
-- School (as reported): "Ecole de la Vie"
-- Original: "4 allÃ©e AndrÃ© le NÃ´tre"
-- Proposed: "4 allée André le Nôtre"
UPDATE `schools` SET `address1` = CONVERT(X'3420616C6CC3A96520416E6472C3A9206C65204EC3B4747265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24141 AND CAST(`address1` AS BINARY) = X'3420616C6CC383C2A96520416E6472C383C2A9206C65204EC383C2B4747265';

-- Entry 341: school id 24142, column `schoolname`, deleted=no
-- School (as reported): "Ecole GalilÃ©e"
-- Original: "Ecole GalilÃ©e"
-- Proposed: "Ecole Galilée"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C652047616C696CC3A965' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24142 AND CAST(`schoolname` AS BINARY) = X'45636F6C652047616C696CC383C2A965';

-- Entry 342: school id 24143, column `city`, deleted=no
-- School (as reported): "Positive School Ecole Internationale Montessori"
-- Original: "GiÃ¨res"
-- Proposed: "Gières"
UPDATE `schools` SET `city` = CONVERT(X'4769C3A8726573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24143 AND CAST(`city` AS BINARY) = X'4769C383C2A8726573';

-- Entry 343: school id 24146, column `address1`, deleted=no
-- School (as reported): "Cours Jean-Paul II"
-- Original: " La JorsonniÃ¨re"
-- Decoded (before cleanup): " La Jorsonnière"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "La Jorsonnière"
UPDATE `schools` SET `address1` = CONVERT(X'4C61204A6F72736F6E6E69C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24146 AND CAST(`address1` AS BINARY) = X'204C61204A6F72736F6E6E69C383C2A87265';

-- Entry 344: school id 24147, column `schoolname`, deleted=no
-- School (as reported): "L'Ã‰cole de l'Arbre EnchantÃ©"
-- Original: "L'Ã‰cole de l'Arbre EnchantÃ©"
-- Proposed: "L'École de l'Arbre Enchanté"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C27C389636F6C65206465206C27417262726520456E6368616E74C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24147 AND CAST(`schoolname` AS BINARY) = X'4C27C383E280B0636F6C65206465206C27417262726520456E6368616E74C383C2A9';

-- Entry 345: school id 24148, column `contactname`, deleted=no
-- School (as reported): "Montetibou"
-- Original: "AgnÃ¨s Marchand"
-- Proposed: "Agnès Marchand"
UPDATE `schools` SET `contactname` = CONVERT(X'41676EC3A873204D61726368616E64' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24148 AND CAST(`contactname` AS BINARY) = X'41676EC383C2A873204D61726368616E64';

-- Entry 346: school id 24148, column `headofschoolname`, deleted=no
-- School (as reported): "Montetibou"
-- Original: "AgnÃ¨s Marchand"
-- Proposed: "Agnès Marchand"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'41676EC3A873204D61726368616E64' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24148 AND CAST(`headofschoolname` AS BINARY) = X'41676EC383C2A873204D61726368616E64';

-- Entry 347: school id 24150, column `schoolname`, deleted=no
-- School (as reported): "Lâ€™Ã©cole des Roseaux"
-- Original: "Lâ€™Ã©cole des Roseaux"
-- Proposed: "L’école des Roseaux"
UPDATE `schools` SET `schoolname` = CONVERT(X'4CE28099C3A9636F6C652064657320526F7365617578' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24150 AND CAST(`schoolname` AS BINARY) = X'4CC3A2E282ACE284A2C383C2A9636F6C652064657320526F7365617578';

-- Entry 348: school id 24155, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole at Montessori- Babylone"
-- Original: "Ã‰cole at Montessori- Babylone"
-- Proposed: "École at Montessori- Babylone"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65206174204D6F6E746573736F72692D20426162796C6F6E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24155 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65206174204D6F6E746573736F72692D20426162796C6F6E65';

-- Entry 349: school id 24156, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori Internationale Â« Grandir en confiance Â»"
-- Original: "Ecole Montessori Internationale Â« Grandir en confiance Â»"
-- Proposed: "Ecole Montessori Internationale « Grandir en confiance »"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C6520C2AB204772616E64697220656E20636F6E6669616E636520C2BB' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24156 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C6520C382C2AB204772616E64697220656E20636F6E6669616E636520C382C2BB';

-- Entry 350: school id 24157, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori du Mont-Blanc"
-- Original: "351 Chemin de la RosiÃ¨re"
-- Proposed: "351 Chemin de la Rosière"
UPDATE `schools` SET `address1` = CONVERT(X'333531204368656D696E206465206C6120526F7369C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24157 AND CAST(`address1` AS BINARY) = X'333531204368656D696E206465206C6120526F7369C383C2A87265';

-- Entry 351: school id 24160, column `contactname`, deleted=no
-- School (as reported): "Petite Ecole trilingue Montessori"
-- Original: "CÃ©line Cherel"
-- Proposed: "Céline Cherel"
UPDATE `schools` SET `contactname` = CONVERT(X'43C3A96C696E652043686572656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24160 AND CAST(`contactname` AS BINARY) = X'43C383C2A96C696E652043686572656C';

-- Entry 352: school id 24160, column `headofschoolname`, deleted=no
-- School (as reported): "Petite Ecole trilingue Montessori"
-- Original: "CÃ©line Cherel"
-- Proposed: "Céline Cherel"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'43C3A96C696E652043686572656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24160 AND CAST(`headofschoolname` AS BINARY) = X'43C383C2A96C696E652043686572656C';

-- Entry 353: school id 24161, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori Les Abeilles"
-- Original: "12, rue de l'Ã‰cole"
-- Proposed: "12, rue de l'École"
UPDATE `schools` SET `address1` = CONVERT(X'31322C20727565206465206C27C389636F6C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24161 AND CAST(`address1` AS BINARY) = X'31322C20727565206465206C27C383E280B0636F6C65';

-- Entry 354: school id 24164, column `address1`, deleted=no
-- School (as reported): "Montessori Here & Now"
-- Original: "1 route de FÃ©rolles"
-- Proposed: "1 route de Férolles"
UPDATE `schools` SET `address1` = CONVERT(X'3120726F7574652064652046C3A9726F6C6C6573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24164 AND CAST(`address1` AS BINARY) = X'3120726F7574652064652046C383C2A9726F6C6C6573';

-- Entry 355: school id 24165, column `contactname`, deleted=no
-- School (as reported): "NLC ~78 International School"
-- Original: "Bernadette Mesurï¿½ "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Bernadette Mesuré"
UPDATE `schools` SET `contactname` = CONVERT(X'4265726E616465747465204D65737572C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24165 AND CAST(`contactname` AS BINARY) = X'4265726E616465747465204D65737572C3AFC2BFC2BD20';

-- Entry 356: school id 24165, column `headofschoolname`, deleted=no
-- School (as reported): "NLC ~78 International School"
-- Original: "Bernadette Mesurï¿½ "
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Bernadette Mesuré"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4265726E616465747465204D65737572C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24165 AND CAST(`headofschoolname` AS BINARY) = X'4265726E616465747465204D65737572C3AFC2BFC2BD20';

-- Entry 357: school id 24166, column `city`, deleted=no
-- School (as reported): "Ecole Le Geste Montessori CompiÃ¨gne"
-- Original: "Margny-lÃ¨s-CompiÃ¨gne"
-- Proposed: "Margny-lès-Compiègne"
UPDATE `schools` SET `city` = CONVERT(X'4D6172676E792D6CC3A8732D436F6D7069C3A8676E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24166 AND CAST(`city` AS BINARY) = X'4D6172676E792D6CC383C2A8732D436F6D7069C383C2A8676E65';

-- Entry 358: school id 24166, column `schoolname`, deleted=no
-- School (as reported): "Ecole Le Geste Montessori CompiÃ¨gne"
-- Original: "Ecole Le Geste Montessori CompiÃ¨gne"
-- Proposed: "Ecole Le Geste Montessori Compiègne"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204C65204765737465204D6F6E746573736F726920436F6D7069C3A8676E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24166 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204C65204765737465204D6F6E746573736F726920436F6D7069C383C2A8676E65';

-- Entry 359: school id 24168, column `address1`, deleted=no
-- School (as reported): "Maison des Enfants de Marne la Vallee"
-- Original: "â€‹16, sente des carriÃ¨res"
-- Decoded (before cleanup): "​16, sente des carrières"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "16, sente des carrières"
UPDATE `schools` SET `address1` = CONVERT(X'31362C2073656E746520646573206361727269C3A8726573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24168 AND CAST(`address1` AS BINARY) = X'C3A2E282ACE280B931362C2073656E746520646573206361727269C383C2A8726573';

-- Entry 360: school id 24169, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori du Pays d'Apt"
-- Original: "Jardins dâ€™ELIOS"
-- Proposed: "Jardins d’ELIOS"
UPDATE `schools` SET `address1` = CONVERT(X'4A617264696E732064E28099454C494F53' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24169 AND CAST(`address1` AS BINARY) = X'4A617264696E732064C3A2E282ACE284A2454C494F53';

-- Entry 361: school id 24196, column `schoolname`, deleted=no
-- School (as reported): "Tulane Montessori Children's Houseâ€‹â€‹"
-- Original: "Tulane Montessori Children's Houseâ€‹â€‹"
-- Decoded (before cleanup): "Tulane Montessori Children's House​​"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "Tulane Montessori Children's House"
UPDATE `schools` SET `schoolname` = CONVERT(X'54756C616E65204D6F6E746573736F7269204368696C6472656E277320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24196 AND CAST(`schoolname` AS BINARY) = X'54756C616E65204D6F6E746573736F7269204368696C6472656E277320486F757365C3A2E282ACE280B9C3A2E282ACE280B9';

-- Entry 362: school id 24219, column `address1`, deleted=no
-- School (as reported): "Bilingue Montessori du PrÃ©-St-Gervais"
-- Original: "8, place SÃ©verine"
-- Proposed: "8, place Séverine"
UPDATE `schools` SET `address1` = CONVERT(X'382C20706C6163652053C3A9766572696E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24219 AND CAST(`address1` AS BINARY) = X'382C20706C6163652053C383C2A9766572696E65';

-- Entry 363: school id 24219, column `schoolname`, deleted=no
-- School (as reported): "Bilingue Montessori du PrÃ©-St-Gervais"
-- Original: "Bilingue Montessori du PrÃ©-St-Gervais"
-- Proposed: "Bilingue Montessori du Pré-St-Gervais"
UPDATE `schools` SET `schoolname` = CONVERT(X'42696C696E677565204D6F6E746573736F7269206475205072C3A92D53742D47657276616973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24219 AND CAST(`schoolname` AS BINARY) = X'42696C696E677565204D6F6E746573736F7269206475205072C383C2A92D53742D47657276616973';

-- Entry 364: school id 24221, column `contactname`, deleted=no
-- School (as reported): "Fantine Ecole Montessori"
-- Original: "SÃ©verine Paris"
-- Proposed: "Séverine Paris"
UPDATE `schools` SET `contactname` = CONVERT(X'53C3A9766572696E65205061726973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24221 AND CAST(`contactname` AS BINARY) = X'53C383C2A9766572696E65205061726973';

-- Entry 365: school id 24221, column `headofschoolname`, deleted=no
-- School (as reported): "Fantine Ecole Montessori"
-- Original: "SÃ©verine Paris"
-- Proposed: "Séverine Paris"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'53C3A9766572696E65205061726973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24221 AND CAST(`headofschoolname` AS BINARY) = X'53C383C2A9766572696E65205061726973';

-- Entry 366: school id 24222, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessori Internationale - Les rayons de soleil"
-- Original: "AurÃ©lie Boutboul"
-- Proposed: "Aurélie Boutboul"
UPDATE `schools` SET `contactname` = CONVERT(X'417572C3A96C696520426F7574626F756C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24222 AND CAST(`contactname` AS BINARY) = X'417572C383C2A96C696520426F7574626F756C';

-- Entry 367: school id 24222, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori Internationale - Les rayons de soleil"
-- Original: "AurÃ©lie Boutboul"
-- Proposed: "Aurélie Boutboul"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'417572C3A96C696520426F7574626F756C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24222 AND CAST(`headofschoolname` AS BINARY) = X'417572C383C2A96C696520426F7574626F756C';

-- Entry 368: school id 24227, column `address1`, deleted=no
-- School (as reported): "Montessori-Gesamtschule"
-- Original: "RÃ¶wekamp 14"
-- Proposed: "Röwekamp 14"
UPDATE `schools` SET `address1` = CONVERT(X'52C3B677656B616D70203134' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24227 AND CAST(`address1` AS BINARY) = X'52C383C2B677656B616D70203134';

-- Entry 369: school id 24231, column `schoolname`, deleted=no
-- School (as reported): "BischÃ¶flichen Maria-Montessori-Gesamtschule in Krefeld"
-- Original: "BischÃ¶flichen Maria-Montessori-Gesamtschule in Krefeld"
-- Proposed: "Bischöflichen Maria-Montessori-Gesamtschule in Krefeld"
UPDATE `schools` SET `schoolname` = CONVERT(X'4269736368C3B6666C696368656E204D617269612D4D6F6E746573736F72692D476573616D74736368756C6520696E204B726566656C64' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24231 AND CAST(`schoolname` AS BINARY) = X'4269736368C383C2B6666C696368656E204D617269612D4D6F6E746573736F72692D476573616D74736368756C6520696E204B726566656C64';

-- Entry 370: school id 24233, column `address1`, deleted=yes
-- School (as reported): "Aktion Sonnenschein Montessori-Schule"
-- Original: "HeiglhofstraÃŸe 63"
-- Proposed: "Heiglhofstraße 63"
UPDATE `schools` SET `address1` = CONVERT(X'486569676C686F6673747261C39F65203633' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24233 AND CAST(`address1` AS BINARY) = X'486569676C686F6673747261C383C5B865203633';

-- Entry 371: school id 24233, column `city`, deleted=yes
-- School (as reported): "Aktion Sonnenschein Montessori-Schule"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24233 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 372: school id 24241, column `address1`, deleted=no
-- School (as reported): "Montessori Fachoberschule"
-- Original: "BeethovenstraÃŸe 1"
-- Proposed: "Beethovenstraße 1"
UPDATE `schools` SET `address1` = CONVERT(X'42656574686F76656E73747261C39F652031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24241 AND CAST(`address1` AS BINARY) = X'42656574686F76656E73747261C383C5B8652031';

-- Entry 373: school id 24242, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus- \"Haus fÃ¼r Kinder\""
-- Original: "OhmstraÃŸe 3"
-- Proposed: "Ohmstraße 3"
UPDATE `schools` SET `address1` = CONVERT(X'4F686D73747261C39F652033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24242 AND CAST(`address1` AS BINARY) = X'4F686D73747261C383C5B8652033';

-- Entry 374: school id 24242, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus- \"Haus fÃ¼r Kinder\""
-- Original: "Montessori Kinderhaus- \"Haus fÃ¼r Kinder\""
-- Proposed: "Montessori Kinderhaus- \"Haus für Kinder\""
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E646572686175732D2022486175732066C3BC72204B696E64657222' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24242 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E646572686175732D2022486175732066C383C2BC72204B696E64657222';

-- Entry 375: school id 24243, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule GÃ¼nzlhofen und GeschÃ¤ftsstelle der Montessori-Gemeinschaft FÃ¼rstenfeldbruck e.V."
-- Original: "Montessori-Schule GÃ¼nzlhofen und GeschÃ¤ftsstelle der Montessori-Gemeinschaft FÃ¼rstenfeldbruck e.V."
-- Proposed: "Montessori-Schule Günzlhofen und Geschäftsstelle der Montessori-Gemeinschaft Fürstenfeldbruck e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C652047C3BC6E7A6C686F66656E20756E64204765736368C3A46674737374656C6C6520646572204D6F6E746573736F72692D47656D65696E7363686166742046C3BC727374656E66656C64627275636B20652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24243 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C652047C383C2BC6E7A6C686F66656E20756E64204765736368C383C2A46674737374656C6C6520646572204D6F6E746573736F72692D47656D65696E7363686166742046C383C2BC727374656E66656C64627275636B20652E562E';

-- Entry 376: school id 24244, column `address1`, deleted=no
-- School (as reported): "Montessori Fachoberschule MÃ¼nchen"
-- Original: "LangfeldstraÃŸe 6"
-- Proposed: "Langfeldstraße 6"
UPDATE `schools` SET `address1` = CONVERT(X'4C616E6766656C6473747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24244 AND CAST(`address1` AS BINARY) = X'4C616E6766656C6473747261C383C5B8652036';

-- Entry 377: school id 24244, column `city`, deleted=no
-- School (as reported): "Montessori Fachoberschule MÃ¼nchen"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24244 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 378: school id 24244, column `schoolname`, deleted=no
-- School (as reported): "Montessori Fachoberschule MÃ¼nchen"
-- Original: "Montessori Fachoberschule MÃ¼nchen"
-- Proposed: "Montessori Fachoberschule München"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920466163686F626572736368756C65204DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24244 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920466163686F626572736368756C65204DC383C2BC6E6368656E';

-- Entry 379: school id 24248, column `city`, deleted=no
-- School (as reported): "Maria-Montessori-Grundschule SaarbrÃ¼cken-RuÃŸhÃ¼tte"
-- Original: "SaarbrÃ¼cken"
-- Proposed: "Saarbrücken"
UPDATE `schools` SET `city` = CONVERT(X'536161726272C3BC636B656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24248 AND CAST(`city` AS BINARY) = X'536161726272C383C2BC636B656E';

-- Entry 380: school id 24248, column `schoolname`, deleted=no
-- School (as reported): "Maria-Montessori-Grundschule SaarbrÃ¼cken-RuÃŸhÃ¼tte"
-- Original: "Maria-Montessori-Grundschule SaarbrÃ¼cken-RuÃŸhÃ¼tte"
-- Proposed: "Maria-Montessori-Grundschule Saarbrücken-Rußhütte"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D617269612D4D6F6E746573736F72692D4772756E64736368756C6520536161726272C3BC636B656E2D5275C39F68C3BC747465' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24248 AND CAST(`schoolname` AS BINARY) = X'4D617269612D4D6F6E746573736F72692D4772756E64736368756C6520536161726272C383C2BC636B656E2D5275C383C5B868C383C2BC747465';

-- Entry 381: school id 24249, column `address1`, deleted=no
-- School (as reported): "Montessori Gemeinschaftsschule Saar"
-- Original: "Im GrÃ¼hlingswald 19"
-- Proposed: "Im Grühlingswald 19"
UPDATE `schools` SET `address1` = CONVERT(X'496D204772C3BC686C696E677377616C64203139' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24249 AND CAST(`address1` AS BINARY) = X'496D204772C383C2BC686C696E677377616C64203139';

-- Entry 382: school id 24261, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus ZÃ¤hringen e.V."
-- Original: "Montessori Kinderhaus ZÃ¤hringen e.V."
-- Proposed: "Montessori Kinderhaus Zähringen e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E64657268617573205AC3A46872696E67656E20652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24261 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E64657268617573205AC383C2A46872696E67656E20652E562E';

-- Entry 383: school id 24263, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Weilimdorf"
-- Original: "GiebelstraÃŸe 6"
-- Proposed: "Giebelstraße 6"
UPDATE `schools` SET `address1` = CONVERT(X'47696562656C73747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24263 AND CAST(`address1` AS BINARY) = X'47696562656C73747261C383C5B8652036';

-- Entry 384: school id 24265, column `contactname`, deleted=no
-- School (as reported): "Sinnesreich Montessori Kinderhaus"
-- Original: "Sabine GrundmÃ¼ller"
-- Proposed: "Sabine Grundmüller"
UPDATE `schools` SET `contactname` = CONVERT(X'536162696E65204772756E646DC3BC6C6C6572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24265 AND CAST(`contactname` AS BINARY) = X'536162696E65204772756E646DC383C2BC6C6C6572';

-- Entry 385: school id 24265, column `headofschoolname`, deleted=no
-- School (as reported): "Sinnesreich Montessori Kinderhaus"
-- Original: "Sabine GrundmÃ¼ller"
-- Proposed: "Sabine Grundmüller"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'536162696E65204772756E646DC3BC6C6C6572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24265 AND CAST(`headofschoolname` AS BINARY) = X'536162696E65204772756E646DC383C2BC6C6C6572';

-- Entry 386: school id 24272, column `schoolname`, deleted=no
-- School (as reported): "Kinderhaus und KinderhÃ¤uschen Die Sterngucker"
-- Original: "Kinderhaus und KinderhÃ¤uschen Die Sterngucker"
-- Proposed: "Kinderhaus und Kinderhäuschen Die Sterngucker"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B696E6465726861757320756E64204B696E64657268C3A475736368656E2044696520537465726E6775636B6572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24272 AND CAST(`schoolname` AS BINARY) = X'4B696E6465726861757320756E64204B696E64657268C383C2A475736368656E2044696520537465726E6775636B6572';

-- Entry 387: school id 24276, column `address1`, deleted=no
-- School (as reported): "Internationales Montessori Zentrum MÃ¼nchen e.V."
-- Original: "OberfÃ¶hringer StraÃŸe 156"
-- Proposed: "Oberföhringer Straße 156"
UPDATE `schools` SET `address1` = CONVERT(X'4F62657266C3B66872696E6765722053747261C39F6520313536' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24276 AND CAST(`address1` AS BINARY) = X'4F62657266C383C2B66872696E6765722053747261C383C5B86520313536';

-- Entry 388: school id 24276, column `city`, deleted=no
-- School (as reported): "Internationales Montessori Zentrum MÃ¼nchen e.V."
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24276 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 389: school id 24276, column `schoolname`, deleted=no
-- School (as reported): "Internationales Montessori Zentrum MÃ¼nchen e.V."
-- Original: "Internationales Montessori Zentrum MÃ¼nchen e.V."
-- Proposed: "Internationales Montessori Zentrum München e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'496E7465726E6174696F6E616C6573204D6F6E746573736F7269205A656E7472756D204DC3BC6E6368656E20652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24276 AND CAST(`schoolname` AS BINARY) = X'496E7465726E6174696F6E616C6573204D6F6E746573736F7269205A656E7472756D204DC383C2BC6E6368656E20652E562E';

-- Entry 390: school id 24280, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule Landau an der Isar- Haus fÃ¼r KinderIsar- "
-- Original: "Montessori-Schule Landau an der Isar- Haus fÃ¼r KinderIsar- "
-- Decoded (before cleanup): "Montessori-Schule Landau an der Isar- Haus für KinderIsar- "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Montessori-Schule Landau an der Isar- Haus für KinderIsar-"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C65204C616E64617520616E2064657220497361722D20486175732066C3BC72204B696E646572497361722D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24280 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C65204C616E64617520616E2064657220497361722D20486175732066C383C2BC72204B696E646572497361722D20';

-- Entry 391: school id 24283, column `schoolname`, deleted=no
-- School (as reported): "Private Montessori-Weltkinderschule Gï¿½nzburg"
-- Original: "Private Montessori-Weltkinderschule Gï¿½nzburg"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Private Montessori-Weltkinderschule Günzburg"
UPDATE `schools` SET `schoolname` = CONVERT(X'50726976617465204D6F6E746573736F72692D57656C746B696E646572736368756C652047C3BC6E7A62757267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24283 AND CAST(`schoolname` AS BINARY) = X'50726976617465204D6F6E746573736F72692D57656C746B696E646572736368756C652047C3AFC2BFC2BD6E7A62757267';

-- Entry 392: school id 24295, column `city`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Wasserzell"
-- Original: "EichstÃ¤tt"
-- Proposed: "Eichstätt"
UPDATE `schools` SET `city` = CONVERT(X'456963687374C3A47474' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24295 AND CAST(`city` AS BINARY) = X'456963687374C383C2A47474';

-- Entry 393: school id 24296, column `address1`, deleted=no
-- School (as reported): "Montessori School Peissenberg"
-- Original: "WÃ¶rther-Kirch-StraÃŸe 10"
-- Proposed: "Wörther-Kirch-Straße 10"
UPDATE `schools` SET `address1` = CONVERT(X'57C3B672746865722D4B697263682D53747261C39F65203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24296 AND CAST(`address1` AS BINARY) = X'57C383C2B672746865722D4B697263682D53747261C383C5B865203130';

-- Entry 394: school id 24296, column `city`, deleted=no
-- School (as reported): "Montessori School Peissenberg"
-- Original: "PeiÃŸenberg"
-- Proposed: "Peißenberg"
UPDATE `schools` SET `city` = CONVERT(X'506569C39F656E62657267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24296 AND CAST(`city` AS BINARY) = X'506569C383C5B8656E62657267';

-- Entry 395: school id 24298, column `schoolname`, deleted=no
-- School (as reported): "Musisch-aktive Montessori-Schule (Klassen 1-10) Bad TÃ¶lz"
-- Original: "Musisch-aktive Montessori-Schule (Klassen 1-10) Bad TÃ¶lz"
-- Proposed: "Musisch-aktive Montessori-Schule (Klassen 1-10) Bad Tölz"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D7573697363682D616B74697665204D6F6E746573736F72692D536368756C6520284B6C617373656E20312D313029204261642054C3B66C7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24298 AND CAST(`schoolname` AS BINARY) = X'4D7573697363682D616B74697665204D6F6E746573736F72692D536368756C6520284B6C617373656E20312D313029204261642054C383C2B66C7A';

-- Entry 396: school id 24300, column `address1`, deleted=no
-- School (as reported): "Aktive Montessori-Schule Bayerwald "
-- Original: "MÃ¼hlstraÃŸe 14"
-- Proposed: "Mühlstraße 14"
UPDATE `schools` SET `address1` = CONVERT(X'4DC3BC686C73747261C39F65203134' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24300 AND CAST(`address1` AS BINARY) = X'4DC383C2BC686C73747261C383C5B865203134';

-- Entry 397: school id 24302, column `schoolname`, deleted=no
-- School (as reported): "Montessori FÃ¶rdergemeinschaft Fichtelgebirge e.V."
-- Original: "Montessori FÃ¶rdergemeinschaft Fichtelgebirge e.V."
-- Proposed: "Montessori Fördergemeinschaft Fichtelgebirge e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692046C3B67264657267656D65696E736368616674204669636874656C6765626972676520652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24302 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692046C383C2B67264657267656D65696E736368616674204669636874656C6765626972676520652E562E';

-- Entry 398: school id 24303, column `address1`, deleted=no
-- School (as reported): "Inklusive Montessori Schule an der BalanstraÃŸe"
-- Original: "BalanstraÃŸe 73"
-- Proposed: "Balanstraße 73"
UPDATE `schools` SET `address1` = CONVERT(X'42616C616E73747261C39F65203733' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24303 AND CAST(`address1` AS BINARY) = X'42616C616E73747261C383C5B865203733';

-- Entry 399: school id 24303, column `city`, deleted=no
-- School (as reported): "Inklusive Montessori Schule an der BalanstraÃŸe"
-- Original: "MÃ¼nchen"
-- Proposed: "München"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E6368656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24303 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E6368656E';

-- Entry 400: school id 24303, column `schoolname`, deleted=no
-- School (as reported): "Inklusive Montessori Schule an der BalanstraÃŸe"
-- Original: "Inklusive Montessori Schule an der BalanstraÃŸe"
-- Proposed: "Inklusive Montessori Schule an der Balanstraße"
UPDATE `schools` SET `schoolname` = CONVERT(X'496E6B6C7573697665204D6F6E746573736F726920536368756C6520616E206465722042616C616E73747261C39F65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24303 AND CAST(`schoolname` AS BINARY) = X'496E6B6C7573697665204D6F6E746573736F726920536368756C6520616E206465722042616C616E73747261C383C5B865';

-- Entry 401: school id 24307, column `address1`, deleted=no
-- School (as reported): "Montessori-Grundschule Gilching"
-- Original: "FrÃ¼hlingstraÃŸe 16a"
-- Proposed: "Frühlingstraße 16a"
UPDATE `schools` SET `address1` = CONVERT(X'4672C3BC686C696E6773747261C39F6520313661' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24307 AND CAST(`address1` AS BINARY) = X'4672C383C2BC686C696E6773747261C383C5B86520313661';

-- Entry 402: school id 24309, column `schoolname`, deleted=no
-- School (as reported): "Montessori Schule AllgÃ¤u"
-- Original: "Montessori Schule AllgÃ¤u"
-- Proposed: "Montessori Schule Allgäu"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920536368756C6520416C6C67C3A475' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24309 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920536368756C6520416C6C67C383C2A475';

-- Entry 403: school id 24310, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule fÃ¼r ganzheitliches Lernen"
-- Original: "Montessori-Schule fÃ¼r ganzheitliches Lernen"
-- Proposed: "Montessori-Schule für ganzheitliches Lernen"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C652066C3BC722067616E7A686569746C6963686573204C65726E656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24310 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C652066C383C2BC722067616E7A686569746C6963686573204C65726E656E';

-- Entry 404: school id 24313, column `address1`, deleted=no
-- School (as reported): "Montessori-Schule Inning am Ammersee"
-- Original: "Landsberger StraÃŸe 2"
-- Proposed: "Landsberger Straße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4C616E64736265726765722053747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24313 AND CAST(`address1` AS BINARY) = X'4C616E64736265726765722053747261C383C5B8652032';

-- Entry 405: school id 24315, column `city`, deleted=no
-- School (as reported): "Montessori Verein KÃ¶sching e.V."
-- Original: "KÃ¶sching "
-- Decoded (before cleanup): "Kösching "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Kösching"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B6736368696E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24315 AND CAST(`city` AS BINARY) = X'4BC383C2B6736368696E6720';

-- Entry 406: school id 24315, column `schoolname`, deleted=no
-- School (as reported): "Montessori Verein KÃ¶sching e.V."
-- Original: "Montessori Verein KÃ¶sching e.V."
-- Proposed: "Montessori Verein Kösching e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692056657265696E204BC3B6736368696E6720652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24315 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692056657265696E204BC383C2B6736368696E6720652E562E';

-- Entry 407: school id 24330, column `city`, deleted=no
-- School (as reported): "Freie Montessori Schule Main-Kinzig-Kreis"
-- Original: "Linsengericht-AltenhaÃŸlau"
-- Proposed: "Linsengericht-Altenhaßlau"
UPDATE `schools` SET `city` = CONVERT(X'4C696E73656E676572696368742D416C74656E6861C39F6C6175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24330 AND CAST(`city` AS BINARY) = X'4C696E73656E676572696368742D416C74656E6861C383C5B86C6175';

-- Entry 408: school id 24335, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderzentrum e.V."
-- Original: "Schweizer StraÃŸe 25 im Hinterhaus "
-- Decoded (before cleanup): "Schweizer Straße 25 im Hinterhaus "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Schweizer Straße 25 im Hinterhaus"
UPDATE `schools` SET `address1` = CONVERT(X'5363687765697A65722053747261C39F6520323520696D2048696E74657268617573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24335 AND CAST(`address1` AS BINARY) = X'5363687765697A65722053747261C383C5B86520323520696D2048696E7465726861757320';

-- Entry 409: school id 24345, column `contactname`, deleted=no
-- School (as reported): "Freie Montessori-Schule Darmstadt"
-- Original: "Gaby BÃ¶hm"
-- Proposed: "Gaby Böhm"
UPDATE `schools` SET `contactname` = CONVERT(X'476162792042C3B6686D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24345 AND CAST(`contactname` AS BINARY) = X'476162792042C383C2B6686D';

-- Entry 410: school id 24348, column `address1`, deleted=no
-- School (as reported): "IBMS International Bilingual Montessori School"
-- Original: "Senckenberganlage 20 â€“ 22"
-- Proposed: "Senckenberganlage 20 – 22"
UPDATE `schools` SET `address1` = CONVERT(X'53656E636B656E62657267616E6C61676520323020E28093203232' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24348 AND CAST(`address1` AS BINARY) = X'53656E636B656E62657267616E6C61676520323020C3A2E282ACE2809C203232';

-- Entry 411: school id 24351, column `address1`, deleted=no
-- School (as reported): "Montessori Schule MÃ¼hlheim"
-- Original: "Carl-Zeiss-StraÃŸe 4"
-- Proposed: "Carl-Zeiss-Straße 4"
UPDATE `schools` SET `address1` = CONVERT(X'4361726C2D5A656973732D53747261C39F652034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24351 AND CAST(`address1` AS BINARY) = X'4361726C2D5A656973732D53747261C383C5B8652034';

-- Entry 412: school id 24351, column `city`, deleted=no
-- School (as reported): "Montessori Schule MÃ¼hlheim"
-- Original: "MÃ¼hlheim am Main"
-- Proposed: "Mühlheim am Main"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC686C6865696D20616D204D61696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24351 AND CAST(`city` AS BINARY) = X'4DC383C2BC686C6865696D20616D204D61696E';

-- Entry 413: school id 24351, column `schoolname`, deleted=no
-- School (as reported): "Montessori Schule MÃ¼hlheim"
-- Original: "Montessori Schule MÃ¼hlheim"
-- Proposed: "Montessori Schule Mühlheim"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920536368756C65204DC3BC686C6865696D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24351 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920536368756C65204DC383C2BC686C6865696D';

-- Entry 414: school id 24355, column `city`, deleted=no
-- School (as reported): "Montessori-Kinderhaus MÃ¶lln"
-- Original: "MÃ¶lln"
-- Proposed: "Mölln"
UPDATE `schools` SET `city` = CONVERT(X'4DC3B66C6C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24355 AND CAST(`city` AS BINARY) = X'4DC383C2B66C6C6E';

-- Entry 415: school id 24355, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus MÃ¶lln"
-- Original: "Montessori-Kinderhaus MÃ¶lln"
-- Proposed: "Montessori-Kinderhaus Mölln"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D4B696E64657268617573204DC3B66C6C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24355 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D4B696E64657268617573204DC383C2B66C6C6E';

-- Entry 416: school id 24356, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Ratzeburg"
-- Original: "RÃ¶persberg 2"
-- Proposed: "Röpersberg 2"
UPDATE `schools` SET `address1` = CONVERT(X'52C3B670657273626572672032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24356 AND CAST(`address1` AS BINARY) = X'52C383C2B670657273626572672032';

-- Entry 417: school id 24357, column `address1`, deleted=no
-- School (as reported): "Montessori-Inselhaus Ratzeburg"
-- Original: "SchulstraÃŸe 25"
-- Proposed: "Schulstraße 25"
UPDATE `schools` SET `address1` = CONVERT(X'536368756C73747261C39F65203235' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24357 AND CAST(`address1` AS BINARY) = X'536368756C73747261C383C5B865203235';

-- Entry 418: school id 24371, column `address1`, deleted=no
-- School (as reported): "Bilinguale Montessori Schule"
-- Original: "CarolinenstraÃŸe 2"
-- Proposed: "Carolinenstraße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4361726F6C696E656E73747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24371 AND CAST(`address1` AS BINARY) = X'4361726F6C696E656E73747261C383C5B8652032';

-- Entry 419: school id 24372, column `address1`, deleted=no
-- School (as reported): "Freie Montessori Schule Westerwald"
-- Original: "Theo-Neeb- StraÃŸe 5"
-- Proposed: "Theo-Neeb- Straße 5"
UPDATE `schools` SET `address1` = CONVERT(X'5468656F2D4E6565622D2053747261C39F652035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24372 AND CAST(`address1` AS BINARY) = X'5468656F2D4E6565622D2053747261C383C5B8652035';

-- Entry 420: school id 24384, column `phone1number`, deleted=no
-- School (as reported): "Integratives Montessori Kinderhaus Reichswalde e. V."
-- Original: "+49-0â€¯28â€¯21-4â€¯8837"
-- Decoded (before cleanup): "+49-0 28 21-4 8837"
-- Cleanup: replaced U+202F NARROW NO-BREAK SPACE with a normal space
-- Proposed: "+49-0 28 21-4 8837"
UPDATE `schools` SET `phone1number` = CONVERT(X'2B34392D302032382032312D342038383337' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24384 AND CAST(`phone1number` AS BINARY) = X'2B34392D30C3A2E282ACC2AF3238C3A2E282ACC2AF32312D34C3A2E282ACC2AF38383337';

-- Entry 421: school id 24387, column `schoolname`, deleted=yes
-- School (as reported): "Montessori â€“ Arbeitskreis e.V."
-- Original: "Montessori â€“ Arbeitskreis e.V."
-- Proposed: "Montessori – Arbeitskreis e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920E2809320417262656974736B7265697320652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24387 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920C3A2E282ACE2809C20417262656974736B7265697320652E562E';

-- Entry 422: school id 24389, column `address1`, deleted=no
-- School (as reported): "Evangelisches Montessori-Kinderhaus Wahlscheid"
-- Original: "DiemstraÃŸe 10"
-- Proposed: "Diemstraße 10"
UPDATE `schools` SET `address1` = CONVERT(X'4469656D73747261C39F65203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24389 AND CAST(`address1` AS BINARY) = X'4469656D73747261C383C5B865203130';

-- Entry 423: school id 24390, column `address1`, deleted=no
-- School (as reported): "Evangelisches Montessori-Kinderhaus Arche Noah Donrath"
-- Original: "In der HÃ¼hene 28"
-- Proposed: "In der Hühene 28"
UPDATE `schools` SET `address1` = CONVERT(X'496E206465722048C3BC68656E65203238' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24390 AND CAST(`address1` AS BINARY) = X'496E206465722048C383C2BC68656E65203238';

-- Entry 424: school id 24396, column `city`, deleted=no
-- School (as reported): "StÃ¤dtische Montessori-Grundschule"
-- Original: "MÃ¶nchengladbach"
-- Proposed: "Mönchengladbach"
UPDATE `schools` SET `city` = CONVERT(X'4DC3B66E6368656E676C616462616368' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24396 AND CAST(`city` AS BINARY) = X'4DC383C2B66E6368656E676C616462616368';

-- Entry 425: school id 24396, column `schoolname`, deleted=no
-- School (as reported): "StÃ¤dtische Montessori-Grundschule"
-- Original: "StÃ¤dtische Montessori-Grundschule"
-- Proposed: "Städtische Montessori-Grundschule"
UPDATE `schools` SET `schoolname` = CONVERT(X'5374C3A464746973636865204D6F6E746573736F72692D4772756E64736368756C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24396 AND CAST(`schoolname` AS BINARY) = X'5374C383C2A464746973636865204D6F6E746573736F72692D4772756E64736368756C65';

-- Entry 426: school id 24400, column `city`, deleted=no
-- School (as reported): "Albert Schweitzer School MÃ¼nster"
-- Original: "MÃ¼nster"
-- Proposed: "Münster"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E73746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24400 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E73746572';

-- Entry 427: school id 24400, column `schoolname`, deleted=no
-- School (as reported): "Albert Schweitzer School MÃ¼nster"
-- Original: "Albert Schweitzer School MÃ¼nster"
-- Proposed: "Albert Schweitzer School Münster"
UPDATE `schools` SET `schoolname` = CONVERT(X'416C6265727420536368776569747A6572205363686F6F6C204DC3BC6E73746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24400 AND CAST(`schoolname` AS BINARY) = X'416C6265727420536368776569747A6572205363686F6F6C204DC383C2BC6E73746572';

-- Entry 428: school id 24401, column `city`, deleted=no
-- School (as reported): "Montessori-Schule MÃ¼nster e.V."
-- Original: "MÃ¼nster  "
-- Decoded (before cleanup): "Münster  "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Münster"
UPDATE `schools` SET `city` = CONVERT(X'4DC3BC6E73746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24401 AND CAST(`city` AS BINARY) = X'4DC383C2BC6E737465722020';

-- Entry 429: school id 24401, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule MÃ¼nster e.V."
-- Original: "Montessori-Schule MÃ¼nster e.V."
-- Proposed: "Montessori-Schule Münster e.V."
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C65204DC3BC6E7374657220652E562E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24401 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C65204DC383C2BC6E7374657220652E562E';

-- Entry 430: school id 24432, column `address1`, deleted=no
-- School (as reported): "Mi Casita Montessori "
-- Original: "CallejÃ³n JosÃ© Jorge Ucles 8-51 Zona 1"
-- Proposed: "Callejón José Jorge Ucles 8-51 Zona 1"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C656AC3B36E204A6F73C3A9204A6F7267652055636C657320382D3531205A6F6E612031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24432 AND CAST(`address1` AS BINARY) = X'43616C6C656AC383C2B36E204A6F73C383C2A9204A6F7267652055636C657320382D3531205A6F6E612031';

-- Entry 431: school id 24433, column `contactname`, deleted=no
-- School (as reported): "Casa Opalo/ Opal House Montessori"
-- Original: "Jackeline Arely Salazar PÃ©rez"
-- Proposed: "Jackeline Arely Salazar Pérez"
UPDATE `schools` SET `contactname` = CONVERT(X'4A61636B656C696E65204172656C792053616C617A61722050C3A972657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24433 AND CAST(`contactname` AS BINARY) = X'4A61636B656C696E65204172656C792053616C617A61722050C383C2A972657A';

-- Entry 432: school id 24433, column `headofschoolname`, deleted=no
-- School (as reported): "Casa Opalo/ Opal House Montessori"
-- Original: "Jackeline Arely Salazar PÃ©rez"
-- Proposed: "Jackeline Arely Salazar Pérez"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4A61636B656C696E65204172656C792053616C617A61722050C3A972657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24433 AND CAST(`headofschoolname` AS BINARY) = X'4A61636B656C696E65204172656C792053616C617A61722050C383C2A972657A';

-- Entry 433: school id 24444, column `address2`, deleted=no
-- School (as reported): "Montessori Learning Center"
-- Original: "CabaÃ±as frende a Maderas Oseguera"
-- Proposed: "Cabañas frende a Maderas Oseguera"
UPDATE `schools` SET `address2` = CONVERT(X'43616261C3B16173206672656E64652061204D616465726173204F73656775657261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24444 AND CAST(`address2` AS BINARY) = X'43616261C383C2B16173206672656E64652061204D616465726173204F73656775657261';

-- Entry 434: school id 24669, column `address1`, deleted=no
-- School (as reported): "Vilnius Montessori pre-School casa dei bambini"
-- Original: "NaujakuriÅ³ g. 29 (Antakalnis)"
-- Proposed: "Naujakurių g. 29 (Antakalnis)"
UPDATE `schools` SET `address1` = CONVERT(X'4E61756A616B757269C5B320672E2032392028416E74616B616C6E697329' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24669 AND CAST(`address1` AS BINARY) = X'4E61756A616B757269C385C2B320672E2032392028416E74616B616C6E697329';

-- Entry 435: school id 24715, column `city`, deleted=yes
-- School (as reported): "Colegio Chiaravalle Montessori"
-- Original: "Coyoacï¿½n"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Coyoacán"
UPDATE `schools` SET `city` = CONVERT(X'436F796F6163C3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24715 AND CAST(`city` AS BINARY) = X'436F796F6163C3AFC2BFC2BD6E';

-- Entry 436: school id 24887, column `address1`, deleted=no
-- School (as reported): "Montessori Children's Home"
-- Original: "AsunciÃ³n"
-- Proposed: "Asunción"
UPDATE `schools` SET `address1` = CONVERT(X'4173756E6369C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24887 AND CAST(`address1` AS BINARY) = X'4173756E6369C383C2B36E';

-- Entry 437: school id 24887, column `city`, deleted=no
-- School (as reported): "Montessori Children's Home"
-- Original: "AsunciÃ³n"
-- Proposed: "Asunción"
UPDATE `schools` SET `city` = CONVERT(X'4173756E6369C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24887 AND CAST(`city` AS BINARY) = X'4173756E6369C383C2B36E';

-- Entry 438: school id 24919, column `address1`, deleted=no
-- School (as reported): "Wieliczka Montessori School"
-- Original: "ul. DaniÅ‚owicza 2"
-- Proposed: "ul. Daniłowicza 2"
UPDATE `schools` SET `address1` = CONVERT(X'756C2E2044616E69C5826F7769637A612032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24919 AND CAST(`address1` AS BINARY) = X'756C2E2044616E69C385E2809A6F7769637A612032';

-- Entry 439: school id 24923, column `infoemail`, deleted=no
-- School (as reported): "Al Nebras International Preschool - Montessori Way Education"
-- Original: "info@MontessoriWay.qa  â€‹"
-- Decoded (before cleanup): "info@MontessoriWay.qa  ​"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Cleanup: removed spaces (not allowed in URLs/email addresses)
-- Proposed: "info@MontessoriWay.qa"
UPDATE `schools` SET `infoemail` = CONVERT(X'696E666F404D6F6E746573736F72695761792E7161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24923 AND CAST(`infoemail` AS BINARY) = X'696E666F404D6F6E746573736F72695761792E71612020C3A2E282ACE280B9';

-- Entry 440: school id 24936, column `schoolname`, deleted=no
-- School (as reported): "Toad Hill Childrenâ€™s House"
-- Original: "Toad Hill Childrenâ€™s House"
-- Proposed: "Toad Hill Children’s House"
UPDATE `schools` SET `schoolname` = CONVERT(X'546F61642048696C6C204368696C6472656EE280997320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 24936 AND CAST(`schoolname` AS BINARY) = X'546F61642048696C6C204368696C6472656EC3A2E282ACE284A27320486F757365';

-- Entry 441: school id 25045, column `address1`, deleted=no
-- School (as reported): "Brommakrokodilen"
-- Original: "GrÃ¶nviksvÃ¤gen 107"
-- Proposed: "Grönviksvägen 107"
UPDATE `schools` SET `address1` = CONVERT(X'4772C3B66E76696B7376C3A467656E20313037' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25045 AND CAST(`address1` AS BINARY) = X'4772C383C2B66E76696B7376C383C2A467656E20313037';

-- Entry 442: school id 25045, column `phone1number`, deleted=no
-- School (as reported): "Brommakrokodilen"
-- Original: "073â€“145 10 40"
-- Proposed: "073–145 10 40"
UPDATE `schools` SET `phone1number` = CONVERT(X'303733E28093313435203130203430' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25045 AND CAST(`phone1number` AS BINARY) = X'303733C3A2E282ACE2809C313435203130203430';

-- Entry 443: school id 25082, column `address1`, deleted=no
-- School (as reported): "House of Montessori Kids"
-- Original: "Zï¿½richstrasse 73A"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "Zürichstrasse 73A"
UPDATE `schools` SET `address1` = CONVERT(X'5AC3BC726963687374726173736520373341' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25082 AND CAST(`address1` AS BINARY) = X'5AC3AFC2BFC2BD726963687374726173736520373341';

-- Entry 444: school id 25181, column `schoolname`, deleted=no
-- School (as reported): "KITA Kï¿½ferberg AG - Ganztagesschule & Kindertagesstï¿½tte nach Maria Montessori"
-- Original: "KITA Kï¿½ferberg AG - Ganztagesschule & Kindertagesstï¿½tte nach Maria Montessori"
-- Character was lost in the original data; value below was corrected manually.
-- Proposed (manual): "KITA Käferberg AG - Ganztagesschule & Kindertagesstätte nach Maria Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B495441204BC3A466657262657267204147202D2047616E7A7461676573736368756C652026204B696E64657274616765737374C3A4747465206E616368204D61726961204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25181 AND CAST(`schoolname` AS BINARY) = X'4B495441204BC3AFC2BFC2BD66657262657267204147202D2047616E7A7461676573736368756C652026204B696E64657274616765737374C3AFC2BFC2BD747465206E616368204D61726961204D6F6E746573736F7269';

-- Entry 445: school id 25188, column `address1`, deleted=yes
-- School (as reported): "Valencia Montessori School"
-- Original: "Av. PÃ­o Baroja 3 "
-- Decoded (before cleanup): "Av. Pío Baroja 3 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Av. Pío Baroja 3"
UPDATE `schools` SET `address1` = CONVERT(X'41762E2050C3AD6F204261726F6A612033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25188 AND CAST(`address1` AS BINARY) = X'41762E2050C383C2AD6F204261726F6A61203320';

-- Entry 446: school id 25188, column `headofschoolname`, deleted=yes
-- School (as reported): "Valencia Montessori School"
-- Original: "Sonia MocholÃ­ Romero"
-- Proposed: "Sonia Mocholí Romero"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'536F6E6961204D6F63686F6CC3AD20526F6D65726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25188 AND CAST(`headofschoolname` AS BINARY) = X'536F6E6961204D6F63686F6CC383C2AD20526F6D65726F';

-- Entry 447: school id 25522, column `city`, deleted=no
-- School (as reported): "Sonnet Montessori & Child Care - Lakeville "
-- Original: "â€‹Lakeville"
-- Decoded (before cleanup): "​Lakeville"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "Lakeville"
UPDATE `schools` SET `city` = CONVERT(X'4C616B6576696C6C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25522 AND CAST(`city` AS BINARY) = X'C3A2E282ACE280B94C616B6576696C6C65';

-- Entry 448: school id 25637, column `schoolname`, deleted=no
-- School (as reported): "PachÃ© Montessori School"
-- Original: "PachÃ© Montessori School"
-- Proposed: "Paché Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'50616368C3A9204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25637 AND CAST(`schoolname` AS BINARY) = X'50616368C383C2A9204D6F6E746573736F7269205363686F6F6C';

-- Entry 449: school id 25794, column `headofschoolname`, deleted=no
-- School (as reported): "The Children's House"
-- Original: "Mr. Todd Los BaÃ±os"
-- Proposed: "Mr. Todd Los Baños"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D722E20546F6464204C6F73204261C3B16F73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25794 AND CAST(`headofschoolname` AS BINARY) = X'4D722E20546F6464204C6F73204261C383C2B16F73';

-- Entry 450: school id 25870, column `phone1number`, deleted=no
-- School (as reported): "NewGate School - Upper School"
-- Original: "â€­(941) 222-0763â€¬"
-- Decoded (before cleanup): "‭(941) 222-0763‬"
-- Cleanup: removed invisible U+202D LEFT-TO-RIGHT OVERRIDE
-- Cleanup: removed invisible U+202C POP DIRECTIONAL FORMATTING
-- Proposed: "(941) 222-0763"
UPDATE `schools` SET `phone1number` = CONVERT(X'2839343129203232322D30373633' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 25870 AND CAST(`phone1number` AS BINARY) = X'C3A2E282ACC2AD2839343129203232322D30373633C3A2E282ACC2AC';

-- Entry 451: school id 26307, column `address1`, deleted=no
-- School (as reported): "Montessori International School"
-- Original: "SonnbergstraÃŸe 36-38"
-- Proposed: "Sonnbergstraße 36-38"
UPDATE `schools` SET `address1` = CONVERT(X'536F6E6E6265726773747261C39F652033362D3338' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26307 AND CAST(`address1` AS BINARY) = X'536F6E6E6265726773747261C383C5B8652033362D3338';

-- Entry 452: school id 26328, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Erlebnisschule MÃ¶dling"
-- Original: "Montessori-Erlebnisschule MÃ¶dling"
-- Proposed: "Montessori-Erlebnisschule Mödling"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D45726C65626E6973736368756C65204DC3B6646C696E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26328 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D45726C65626E6973736368756C65204DC383C2B6646C696E67';

-- Entry 453: school id 26333, column `address1`, deleted=no
-- School (as reported): "Dorfschue MuWi"
-- Original: "LandstraÃŸe 8"
-- Proposed: "Landstraße 8"
UPDATE `schools` SET `address1` = CONVERT(X'4C616E6473747261C39F652038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26333 AND CAST(`address1` AS BINARY) = X'4C616E6473747261C383C5B8652038';

-- Entry 454: school id 26337, column `address1`, deleted=no
-- School (as reported): "Minikinderhaus"
-- Original: "GroÃŸe Pfarrgasse 16-20/II"
-- Proposed: "Große Pfarrgasse 16-20/II"
UPDATE `schools` SET `address1` = CONVERT(X'47726FC39F6520506661727267617373652031362D32302F4949' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26337 AND CAST(`address1` AS BINARY) = X'47726FC383C5B86520506661727267617373652031362D32302F4949';

-- Entry 455: school id 26338, column `address2`, deleted=no
-- School (as reported): "Zwerge Montessori Kindergruppe"
-- Original: "Stiege 4, TÃ¼r 36"
-- Proposed: "Stiege 4, Tür 36"
UPDATE `schools` SET `address2` = CONVERT(X'53746965676520342C2054C3BC72203336' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26338 AND CAST(`address2` AS BINARY) = X'53746965676520342C2054C383C2BC72203336';

-- Entry 456: school id 26340, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus-Sezutu"
-- Original: "SchÃ¶nburgstraÃŸe 27/2/17"
-- Proposed: "Schönburgstraße 27/2/17"
UPDATE `schools` SET `address1` = CONVERT(X'536368C3B66E6275726773747261C39F652032372F322F3137' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26340 AND CAST(`address1` AS BINARY) = X'536368C383C2B66E6275726773747261C383C5B8652032372F322F3137';

-- Entry 457: school id 26348, column `address1`, deleted=no
-- School (as reported): "Montessorischule Wolkersdorf"
-- Original: "BrÃ¼nnerstraÃŸe 1"
-- Proposed: "Brünnerstraße 1"
UPDATE `schools` SET `address1` = CONVERT(X'4272C3BC6E6E657273747261C39F652031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26348 AND CAST(`address1` AS BINARY) = X'4272C383C2BC6E6E657273747261C383C5B8652031';

-- Entry 458: school id 26349, column `address1`, deleted=no
-- School (as reported): "Sonnenrain-Grundschule"
-- Original: "SchlesierstraÃŸe 31"
-- Proposed: "Schlesierstraße 31"
UPDATE `schools` SET `address1` = CONVERT(X'5363686C657369657273747261C39F65203331' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26349 AND CAST(`address1` AS BINARY) = X'5363686C657369657273747261C383C5B865203331';

-- Entry 459: school id 26350, column `address1`, deleted=no
-- School (as reported): "Montessori International School"
-- Original: "SonnbergstraÃŸe 36-38"
-- Proposed: "Sonnbergstraße 36-38"
UPDATE `schools` SET `address1` = CONVERT(X'536F6E6E6265726773747261C39F652033362D3338' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26350 AND CAST(`address1` AS BINARY) = X'536F6E6E6265726773747261C383C5B8652033362D3338';

-- Entry 460: school id 26354, column `address1`, deleted=no
-- School (as reported): "Casa Dei Bambini Montessori-Purkerdorf"
-- Original: "BahnhofstraÃŸe 26"
-- Proposed: "Bahnhofstraße 26"
UPDATE `schools` SET `address1` = CONVERT(X'4261686E686F6673747261C39F65203236' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26354 AND CAST(`address1` AS BINARY) = X'4261686E686F6673747261C383C5B865203236';

-- Entry 461: school id 26354, column `headofschoolname`, deleted=no
-- School (as reported): "Casa Dei Bambini Montessori-Purkerdorf"
-- Original: "Nadja FriedschrÃ¶der"
-- Proposed: "Nadja Friedschröder"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4E61646A6120467269656473636872C3B6646572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26354 AND CAST(`headofschoolname` AS BINARY) = X'4E61646A6120467269656473636872C383C2B6646572';

-- Entry 462: school id 26356, column `address1`, deleted=no
-- School (as reported): "Montessori  Verein Hainfeld"
-- Original: "RamsauerstraÃŸe 13"
-- Proposed: "Ramsauerstraße 13"
UPDATE `schools` SET `address1` = CONVERT(X'52616D736175657273747261C39F65203133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26356 AND CAST(`address1` AS BINARY) = X'52616D736175657273747261C383C5B865203133';

-- Entry 463: school id 26359, column `schoolname`, deleted=no
-- School (as reported): "Kleine LÃ¶wen von Aspern"
-- Original: "Kleine LÃ¶wen von Aspern"
-- Proposed: "Kleine Löwen von Aspern"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B6C65696E65204CC3B677656E20766F6E2041737065726E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26359 AND CAST(`schoolname` AS BINARY) = X'4B6C65696E65204CC383C2B677656E20766F6E2041737065726E';

-- Entry 464: school id 26360, column `address1`, deleted=no
-- School (as reported): "Volksschule Maxglan 2"
-- Original: "MichaelbeuernstraÃŸe 8"
-- Proposed: "Michaelbeuernstraße 8"
UPDATE `schools` SET `address1` = CONVERT(X'4D69636861656C62657565726E73747261C39F652038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26360 AND CAST(`address1` AS BINARY) = X'4D69636861656C62657565726E73747261C383C5B8652038';

-- Entry 465: school id 26361, column `address1`, deleted=no
-- School (as reported): "VS Liefering 2 Montessori Volksschule"
-- Original: "LaufenstraÃŸe 50"
-- Proposed: "Laufenstraße 50"
UPDATE `schools` SET `address1` = CONVERT(X'4C617566656E73747261C39F65203530' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26361 AND CAST(`address1` AS BINARY) = X'4C617566656E73747261C383C5B865203530';

-- Entry 466: school id 26362, column `address1`, deleted=no
-- School (as reported): "Mittelschule Liefering"
-- Original: "LaufenstraÃŸe 50A"
-- Proposed: "Laufenstraße 50A"
UPDATE `schools` SET `address1` = CONVERT(X'4C617566656E73747261C39F6520353041' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26362 AND CAST(`address1` AS BINARY) = X'4C617566656E73747261C383C5B86520353041';

-- Entry 467: school id 26363, column `address1`, deleted=no
-- School (as reported): "Willkommen im Zwergerlgarten"
-- Original: "GaisbergstraÃŸe 37A"
-- Proposed: "Gaisbergstraße 37A"
UPDATE `schools` SET `address1` = CONVERT(X'476169736265726773747261C39F6520333741' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26363 AND CAST(`address1` AS BINARY) = X'476169736265726773747261C383C5B86520333741';

-- Entry 468: school id 26364, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (Josef-August-Lux-StraÃŸe)"
-- Original: "Josef-August-Lux-StraÃŸe 2"
-- Proposed: "Josef-August-Lux-Straße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4A6F7365662D4175677573742D4C75782D53747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26364 AND CAST(`address1` AS BINARY) = X'4A6F7365662D4175677573742D4C75782D53747261C383C5B8652032';

-- Entry 469: school id 26364, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (Josef-August-Lux-StraÃŸe)"
-- Original: "Montessori Kinderhaus Aigen (Josef-August-Lux-StraÃŸe)"
-- Proposed: "Montessori Kinderhaus Aigen (Josef-August-Lux-Straße)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E6465726861757320416967656E20284A6F7365662D4175677573742D4C75782D53747261C39F6529' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26364 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E6465726861757320416967656E20284A6F7365662D4175677573742D4C75782D53747261C383C5B86529';

-- Entry 470: school id 26381, column `address1`, deleted=no
-- School (as reported): "VS 8 Villach St. Andra"
-- Original: "OssiacherstraÃŸe 67"
-- Proposed: "Ossiacherstraße 67"
UPDATE `schools` SET `address1` = CONVERT(X'4F737369616368657273747261C39F65203637' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26381 AND CAST(`address1` AS BINARY) = X'4F737369616368657273747261C383C5B865203637';

-- Entry 471: school id 26389, column `schoolname`, deleted=no
-- School (as reported): "Mim Montessori Initiative MÃ¤ander"
-- Original: "Mim Montessori Initiative MÃ¤ander"
-- Proposed: "Mim Montessori Initiative Mäander"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D696D204D6F6E746573736F726920496E6974696174697665204DC3A4616E646572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26389 AND CAST(`schoolname` AS BINARY) = X'4D696D204D6F6E746573736F726920496E6974696174697665204DC383C2A4616E646572';

-- Entry 472: school id 26395, column `address1`, deleted=no
-- School (as reported): "SIMBA - multikulturelle Kinderbetreuungseinrichtung"
-- Original: "Donaufelder StraÃŸe 101/1"
-- Proposed: "Donaufelder Straße 101/1"
UPDATE `schools` SET `address1` = CONVERT(X'446F6E617566656C6465722053747261C39F65203130312F31' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26395 AND CAST(`address1` AS BINARY) = X'446F6E617566656C6465722053747261C383C5B865203130312F31';

-- Entry 473: school id 26396, column `schoolname`, deleted=no
-- School (as reported): "Verein Kindergruppen Mickey Mouse und Kinderland- BÃ¼ro"
-- Original: "Verein Kindergruppen Mickey Mouse und Kinderland- BÃ¼ro"
-- Proposed: "Verein Kindergruppen Mickey Mouse und Kinderland- Büro"
UPDATE `schools` SET `schoolname` = CONVERT(X'56657265696E204B696E6465726772757070656E204D69636B6579204D6F75736520756E64204B696E6465726C616E642D2042C3BC726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26396 AND CAST(`schoolname` AS BINARY) = X'56657265696E204B696E6465726772757070656E204D69636B6579204D6F75736520756E64204B696E6465726C616E642D2042C383C2BC726F';

-- Entry 474: school id 26403, column `address1`, deleted=no
-- School (as reported): "Montessori-Tulln \"Neue Welt\""
-- Original: "WilhelmstraÃŸe 23"
-- Proposed: "Wilhelmstraße 23"
UPDATE `schools` SET `address1` = CONVERT(X'57696C68656C6D73747261C39F65203233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26403 AND CAST(`address1` AS BINARY) = X'57696C68656C6D73747261C383C5B865203233';

-- Entry 475: school id 26404, column `address1`, deleted=no
-- School (as reported): "LernArt Freie Schule Oberndorf"
-- Original: "BahnhofstraÃŸe 26a"
-- Proposed: "Bahnhofstraße 26a"
UPDATE `schools` SET `address1` = CONVERT(X'4261686E686F6673747261C39F6520323661' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26404 AND CAST(`address1` AS BINARY) = X'4261686E686F6673747261C383C5B86520323661';

-- Entry 476: school id 26408, column `address1`, deleted=no
-- School (as reported): "CreaVita Montessori Privatschule-Kinderhaus"
-- Original: "HalleggerstraÃŸe 152a"
-- Proposed: "Halleggerstraße 152a"
UPDATE `schools` SET `address1` = CONVERT(X'48616C6C656767657273747261C39F652031353261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26408 AND CAST(`address1` AS BINARY) = X'48616C6C656767657273747261C383C5B8652031353261';

-- Entry 477: school id 26409, column `schoolname`, deleted=no
-- School (as reported): "Montessori KitzbÃ¼hel"
-- Original: "Montessori KitzbÃ¼hel"
-- Proposed: "Montessori Kitzbühel"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B69747A62C3BC68656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26409 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B69747A62C383C2BC68656C';

-- Entry 478: school id 26410, column `address1`, deleted=no
-- School (as reported): "Ã–sterreichische Montessori-Akademie"
-- Original: "HÃ¼ttelbergstraÃŸe 5"
-- Proposed: "Hüttelbergstraße 5"
UPDATE `schools` SET `address1` = CONVERT(X'48C3BC7474656C6265726773747261C39F652035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26410 AND CAST(`address1` AS BINARY) = X'48C383C2BC7474656C6265726773747261C383C5B8652035';

-- Entry 479: school id 26410, column `schoolname`, deleted=no
-- School (as reported): "Ã–sterreichische Montessori-Akademie"
-- Original: "Ã–sterreichische Montessori-Akademie"
-- Proposed: "Österreichische Montessori-Akademie"
UPDATE `schools` SET `schoolname` = CONVERT(X'C3967374657272656963686973636865204D6F6E746573736F72692D416B6164656D6965' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26410 AND CAST(`schoolname` AS BINARY) = X'C383E280937374657272656963686973636865204D6F6E746573736F72692D416B6164656D6965';

-- Entry 480: school id 26412, column `address1`, deleted=no
-- School (as reported): "Privatschule KreaMont"
-- Original: "Greifensteiner StraÃŸe 31"
-- Proposed: "Greifensteiner Straße 31"
UPDATE `schools` SET `address1` = CONVERT(X'4772656966656E737465696E65722053747261C39F65203331' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26412 AND CAST(`address1` AS BINARY) = X'4772656966656E737465696E65722053747261C383C5B865203331';

-- Entry 481: school id 26412, column `city`, deleted=no
-- School (as reported): "Privatschule KreaMont"
-- Original: "St. AndrÃ¤-WÃ¶rdernâ€¨"
-- Decoded (before cleanup): "St. Andrä-Wördern "
-- Cleanup: replaced U+2028 LINE SEPARATOR with a normal space
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "St. Andrä-Wördern"
UPDATE `schools` SET `city` = CONVERT(X'53742E20416E6472C3A42D57C3B6726465726E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26412 AND CAST(`city` AS BINARY) = X'53742E20416E6472C383C2A42D57C383C2B6726465726EC3A2E282ACC2A8';

-- Entry 482: school id 26413, column `city`, deleted=no
-- School (as reported): "Montessori Schule Ennstal"
-- Original: "Stainach-PÃ¼rgg"
-- Proposed: "Stainach-Pürgg"
UPDATE `schools` SET `city` = CONVERT(X'537461696E6163682D50C3BC726767' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26413 AND CAST(`city` AS BINARY) = X'537461696E6163682D50C383C2BC726767';

-- Entry 483: school id 26414, column `address1`, deleted=no
-- School (as reported): "Montessori-Kindi"
-- Original: "Dr.-Waibel-StraÃŸe 9"
-- Proposed: "Dr.-Waibel-Straße 9"
UPDATE `schools` SET `address1` = CONVERT(X'44722E2D57616962656C2D53747261C39F652039' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26414 AND CAST(`address1` AS BINARY) = X'44722E2D57616962656C2D53747261C383C5B8652039';

-- Entry 484: school id 26420, column `city`, deleted=no
-- School (as reported): "Das Montessori Haus WÃ¶rgl"
-- Original: "WÃ¶rgl"
-- Proposed: "Wörgl"
UPDATE `schools` SET `city` = CONVERT(X'57C3B672676C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26420 AND CAST(`city` AS BINARY) = X'57C383C2B672676C';

-- Entry 485: school id 26420, column `schoolname`, deleted=no
-- School (as reported): "Das Montessori Haus WÃ¶rgl"
-- Original: "Das Montessori Haus WÃ¶rgl"
-- Proposed: "Das Montessori Haus Wörgl"
UPDATE `schools` SET `schoolname` = CONVERT(X'446173204D6F6E746573736F726920486175732057C3B672676C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26420 AND CAST(`schoolname` AS BINARY) = X'446173204D6F6E746573736F726920486175732057C383C2B672676C';

-- Entry 486: school id 26422, column `address1`, deleted=no
-- School (as reported): "Nidolino"
-- Original: "KaufmannstraÃŸe 58"
-- Proposed: "Kaufmannstraße 58"
UPDATE `schools` SET `address1` = CONVERT(X'4B6175666D616E6E73747261C39F65203538' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26422 AND CAST(`address1` AS BINARY) = X'4B6175666D616E6E73747261C383C5B865203538';

-- Entry 487: school id 26424, column `address1`, deleted=no
-- School (as reported): "Kosmo Montessori-Schule"
-- Original: "Oberbucher StraÃŸe 13/3"
-- Proposed: "Oberbucher Straße 13/3"
UPDATE `schools` SET `address1` = CONVERT(X'4F6265726275636865722053747261C39F652031332F33' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26424 AND CAST(`address1` AS BINARY) = X'4F6265726275636865722053747261C383C5B8652031332F33';

-- Entry 488: school id 26447, column `address1`, deleted=no
-- School (as reported): "Montessori KInderhaus Wien"
-- Original: "NuÃŸdorfer StraÃŸe 6"
-- Proposed: "Nußdorfer Straße 6"
UPDATE `schools` SET `address1` = CONVERT(X'4E75C39F646F726665722053747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26447 AND CAST(`address1` AS BINARY) = X'4E75C383C5B8646F726665722053747261C383C5B8652036';

-- Entry 489: school id 26460, column `schoolname`, deleted=no
-- School (as reported): "Kindergarten Nestchen am KÃ¼niglberg"
-- Original: "Kindergarten Nestchen am KÃ¼niglberg"
-- Proposed: "Kindergarten Nestchen am Küniglberg"
UPDATE `schools` SET `schoolname` = CONVERT(X'4B696E64657267617274656E204E6573746368656E20616D204BC3BC6E69676C62657267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26460 AND CAST(`schoolname` AS BINARY) = X'4B696E64657267617274656E204E6573746368656E20616D204BC383C2BC6E69676C62657267';

-- Entry 490: school id 26501, column `address1`, deleted=no
-- School (as reported): "Montessori Kindergarten of Zug"
-- Original: "ObermÃ¼hle 8"
-- Proposed: "Obermühle 8"
UPDATE `schools` SET `address1` = CONVERT(X'4F6265726DC3BC686C652038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26501 AND CAST(`address1` AS BINARY) = X'4F6265726DC383C2BC686C652038';

-- Entry 491: school id 26502, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Kreuzlingen"
-- Original: "HolzÃ¤ckerlistrasse 12"
-- Proposed: "Holzäckerlistrasse 12"
UPDATE `schools` SET `address1` = CONVERT(X'486F6C7AC3A4636B65726C6973747261737365203132' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26502 AND CAST(`address1` AS BINARY) = X'486F6C7AC383C2A4636B65726C6973747261737365203132';

-- Entry 492: school id 26549, column `address1`, deleted=no
-- School (as reported): "Analy Montessori"
-- Original: "PoblaciÃ³n Iansa NÂ° 1"
-- Proposed: "Población Iansa N° 1"
UPDATE `schools` SET `address1` = CONVERT(X'506F626C616369C3B36E2049616E7361204EC2B02031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26549 AND CAST(`address1` AS BINARY) = X'506F626C616369C383C2B36E2049616E7361204EC382C2B02031';

-- Entry 493: school id 26737, column `contactname`, deleted=no
-- School (as reported): "MS a ZS Montessori Kladno"
-- Original: "Daniela VlÄkovÃ¡   "
-- Decoded (before cleanup): "Daniela Vlčková   "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Daniela Vlčková"
UPDATE `schools` SET `contactname` = CONVERT(X'44616E69656C6120566CC48D6B6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26737 AND CAST(`contactname` AS BINARY) = X'44616E69656C6120566CC384C28D6B6F76C383C2A1202020';

-- Entry 494: school id 26737, column `headofschoolname`, deleted=no
-- School (as reported): "MS a ZS Montessori Kladno"
-- Original: "Daniela VlÄkovÃ¡   "
-- Decoded (before cleanup): "Daniela Vlčková   "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Daniela Vlčková"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'44616E69656C6120566CC48D6B6F76C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26737 AND CAST(`headofschoolname` AS BINARY) = X'44616E69656C6120566CC384C28D6B6F76C383C2A1202020';

-- Entry 495: school id 26742, column `address1`, deleted=no
-- School (as reported): "Global Preschool- Primary Diplomatic Quarter"
-- Original: "STÅ˜EÅ OVICKÃ 431/24"
-- Proposed: "STŘEŠOVICKÁ 431/24"
UPDATE `schools` SET `address1` = CONVERT(X'5354C59845C5A04F5649434BC381203433312F3234' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26742 AND CAST(`address1` AS BINARY) = X'5354C385CB9C45C385C2A04F5649434BC383C281203433312F3234';

-- Entry 496: school id 26743, column `address1`, deleted=no
-- School (as reported): "Global Preschool- Early Learners Program"
-- Original: "HOROMÄšÅ˜ICKÃ 2322/13"
-- Proposed: "HOROMĚŘICKÁ 2322/13"
UPDATE `schools` SET `address1` = CONVERT(X'484F524F4DC49AC59849434BC38120323332322F3133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26743 AND CAST(`address1` AS BINARY) = X'484F524F4DC384C5A1C385CB9C49434BC383C28120323332322F3133';

-- Entry 497: school id 26755, column `address1`, deleted=no
-- School (as reported): "Nikola Tesla Montessori O.S."
-- Original: "NjegoÅ¡eva 45a"
-- Proposed: "Njegoševa 45a"
UPDATE `schools` SET `address1` = CONVERT(X'4E6A65676FC5A165766120343561' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26755 AND CAST(`address1` AS BINARY) = X'4E6A65676FC385C2A165766120343561';

-- Entry 498: school id 26768, column `address1`, deleted=no
-- School (as reported): "Petit Baby Montessori School"
-- Original: "Åžehit Ä°brahim Hasan Caddesi No: 62 KÃ¼Ã§Ã¼k Sanayi BÃ¶lgesi"
-- Proposed: "Şehit İbrahim Hasan Caddesi No: 62 Küçük Sanayi Bölgesi"
UPDATE `schools` SET `address1` = CONVERT(X'C59E6568697420C4B062726168696D20486173616E2043616464657369204E6F3A203632204BC3BCC3A7C3BC6B2053616E6179692042C3B66C67657369' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26768 AND CAST(`address1` AS BINARY) = X'C385C5BE6568697420C384C2B062726168696D20486173616E2043616464657369204E6F3A203632204BC383C2BCC383C2A7C383C2BC6B2053616E6179692042C383C2B66C67657369';

-- Entry 499: school id 26771, column `address1`, deleted=no
-- School (as reported): "Villa Montessori School"
-- Original: "Boulevard TurÃ­stico del Este, Km 8"
-- Proposed: "Boulevard Turístico del Este, Km 8"
UPDATE `schools` SET `address1` = CONVERT(X'426F756C657661726420547572C3AD737469636F2064656C20457374652C204B6D2038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26771 AND CAST(`address1` AS BINARY) = X'426F756C657661726420547572C383C2AD737469636F2064656C20457374652C204B6D2038';

-- Entry 500: school id 26773, column `address1`, deleted=no
-- School (as reported): "Primaria Montessori de Santo Domingo"
-- Original: "Calle Dra. MarÃ­a Montessori #3 esq. Teodoro Chasseriau"
-- Proposed: "Calle Dra. María Montessori #3 esq. Teodoro Chasseriau"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204472612E204D6172C3AD61204D6F6E746573736F7269202333206573712E2054656F646F726F2043686173736572696175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26773 AND CAST(`address1` AS BINARY) = X'43616C6C65204472612E204D6172C383C2AD61204D6F6E746573736F7269202333206573712E2054656F646F726F2043686173736572696175';

-- Entry 501: school id 26775, column `address1`, deleted=no
-- School (as reported): "Instituto Montessori"
-- Original: "Calle Juan SÃ¡nchez RamÃ­rez, # 3, "
-- Decoded (before cleanup): "Calle Juan Sánchez Ramírez, # 3, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calle Juan Sánchez Ramírez, # 3,"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204A75616E2053C3A16E6368657A2052616DC3AD72657A2C202320332C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26775 AND CAST(`address1` AS BINARY) = X'43616C6C65204A75616E2053C383C2A16E6368657A2052616DC383C2AD72657A2C202320332C20';

-- Entry 502: school id 26775, column `contactname`, deleted=no
-- School (as reported): "Instituto Montessori"
-- Original: "MarÃ­a Consuelo RuÃ­z de Royuela and JosÃ© Antonio Royuela"
-- Proposed: "María Consuelo Ruíz de Royuela and José Antonio Royuela"
UPDATE `schools` SET `contactname` = CONVERT(X'4D6172C3AD6120436F6E7375656C6F205275C3AD7A20646520526F7975656C6120616E64204A6F73C3A920416E746F6E696F20526F7975656C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26775 AND CAST(`contactname` AS BINARY) = X'4D6172C383C2AD6120436F6E7375656C6F205275C383C2AD7A20646520526F7975656C6120616E64204A6F73C383C2A920416E746F6E696F20526F7975656C61';

-- Entry 503: school id 26775, column `headofschoolname`, deleted=no
-- School (as reported): "Instituto Montessori"
-- Original: "MarÃ­a Consuelo RuÃ­z de Royuela and JosÃ© Antonio Royuela"
-- Proposed: "María Consuelo Ruíz de Royuela and José Antonio Royuela"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D6172C3AD6120436F6E7375656C6F205275C3AD7A20646520526F7975656C6120616E64204A6F73C3A920416E746F6E696F20526F7975656C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26775 AND CAST(`headofschoolname` AS BINARY) = X'4D6172C383C2AD6120436F6E7375656C6F205275C383C2AD7A20646520526F7975656C6120616E64204A6F73C383C2A920416E746F6E696F20526F7975656C61';

-- Entry 504: school id 26778, column `address1`, deleted=no
-- School (as reported): "Pre-escolar Montessori"
-- Original: "Av. Gustavo MejÃ­a Ricart 156"
-- Proposed: "Av. Gustavo Mejía Ricart 156"
UPDATE `schools` SET `address1` = CONVERT(X'41762E204775737461766F204D656AC3AD612052696361727420313536' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26778 AND CAST(`address1` AS BINARY) = X'41762E204775737461766F204D656AC383C2AD612052696361727420313536';

-- Entry 505: school id 26779, column `address1`, deleted=no
-- School (as reported): "Gamification Montessori School"
-- Original: "Residencial Bavaro Punta Cana BÃ¡varo"
-- Proposed: "Residencial Bavaro Punta Cana Bávaro"
UPDATE `schools` SET `address1` = CONVERT(X'5265736964656E6369616C2042617661726F2050756E74612043616E612042C3A17661726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26779 AND CAST(`address1` AS BINARY) = X'5265736964656E6369616C2042617661726F2050756E74612043616E612042C383C2A17661726F';

-- Entry 506: school id 26784, column `address1`, deleted=yes
-- School (as reported): "Montessori School \"Luceritos del Senor\"- Campus #2"
-- Original: "Calle El Naranjo #22 UrbanizaciÃ³n MÃ¡ximo GÃ³mez, Villa Mella"
-- Proposed: "Calle El Naranjo #22 Urbanización Máximo Gómez, Villa Mella"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520456C204E6172616E6A6F2023323220557262616E697A616369C3B36E204DC3A178696D6F2047C3B36D657A2C2056696C6C61204D656C6C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26784 AND CAST(`address1` AS BINARY) = X'43616C6C6520456C204E6172616E6A6F2023323220557262616E697A616369C383C2B36E204DC383C2A178696D6F2047C383C2B36D657A2C2056696C6C61204D656C6C61';

-- Entry 507: school id 26786, column `schoolname`, deleted=no
-- School (as reported): "FundaciÃ³n SKAS"
-- Original: "FundaciÃ³n SKAS"
-- Proposed: "Fundación SKAS"
UPDATE `schools` SET `schoolname` = CONVERT(X'46756E64616369C3B36E20534B4153' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26786 AND CAST(`schoolname` AS BINARY) = X'46756E64616369C383C2B36E20534B4153';

-- Entry 508: school id 26789, column `address1`, deleted=yes
-- School (as reported): "Colegio Montessoriano"
-- Original: "UrbanizaciÃ³n Siglo XXI"
-- Proposed: "Urbanización Siglo XXI"
UPDATE `schools` SET `address1` = CONVERT(X'557262616E697A616369C3B36E205369676C6F20585849' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26789 AND CAST(`address1` AS BINARY) = X'557262616E697A616369C383C2B36E205369676C6F20585849';

-- Entry 509: school id 26790, column `address1`, deleted=no
-- School (as reported): "Montessori Children's Center"
-- Original: "A.H.Tammsaare tee 89â€“42"
-- Proposed: "A.H.Tammsaare tee 89–42"
UPDATE `schools` SET `address1` = CONVERT(X'412E482E54616D6D736161726520746565203839E280933432' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26790 AND CAST(`address1` AS BINARY) = X'412E482E54616D6D736161726520746565203839C3A2E282ACE2809C3432';

-- Entry 510: school id 26792, column `address1`, deleted=no
-- School (as reported): "Montessori Community"
-- Original: "SelkÃ¤merenkatu 10"
-- Proposed: "Selkämerenkatu 10"
UPDATE `schools` SET `address1` = CONVERT(X'53656C6BC3A46D6572656E6B617475203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26792 AND CAST(`address1` AS BINARY) = X'53656C6BC383C2A46D6572656E6B617475203130';

-- Entry 511: school id 26796, column `address1`, deleted=no
-- School (as reported): "Plaisir d'Enfance- Pantin"
-- Original: "12 Rue MÃ©hul"
-- Proposed: "12 Rue Méhul"
UPDATE `schools` SET `address1` = CONVERT(X'313220527565204DC3A968756C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26796 AND CAST(`address1` AS BINARY) = X'313220527565204DC383C2A968756C';

-- Entry 512: school id 26797, column `schoolname`, deleted=no
-- School (as reported): "Ecole AthÃ©na Clichy"
-- Original: "Ecole AthÃ©na Clichy"
-- Proposed: "Ecole Athéna Clichy"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C6520417468C3A96E6120436C69636879' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26797 AND CAST(`schoolname` AS BINARY) = X'45636F6C6520417468C383C2A96E6120436C69636879';

-- Entry 513: school id 26798, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Carvin"
-- Original: "Sylvie d'Esclaibes and JoÃ«l Philippin"
-- Proposed: "Sylvie d'Esclaibes and Joël Philippin"
UPDATE `schools` SET `contactname` = CONVERT(X'53796C7669652064274573636C616962657320616E64204A6FC3AB6C205068696C697070696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26798 AND CAST(`contactname` AS BINARY) = X'53796C7669652064274573636C616962657320616E64204A6FC383C2AB6C205068696C697070696E';

-- Entry 514: school id 26798, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Carvin"
-- Original: "Sylvie d'Esclaibes and JoÃ«l Philippin"
-- Proposed: "Sylvie d'Esclaibes and Joël Philippin"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'53796C7669652064274573636C616962657320616E64204A6FC3AB6C205068696C697070696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26798 AND CAST(`headofschoolname` AS BINARY) = X'53796C7669652064274573636C616962657320616E64204A6FC383C2AB6C205068696C697070696E';

-- Entry 515: school id 26798, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Carvin"
-- Original: "Ecole Montessori AthÃ©na de Carvin"
-- Proposed: "Ecole Montessori Athéna de Carvin"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920417468C3A96E612064652043617276696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26798 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920417468C383C2A96E612064652043617276696E';

-- Entry 516: school id 26799, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Montherlant"
-- Original: "9 rue de l'Ã‰glise"
-- Proposed: "9 rue de l'Église"
UPDATE `schools` SET `address1` = CONVERT(X'3920727565206465206C27C389676C697365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26799 AND CAST(`address1` AS BINARY) = X'3920727565206465206C27C383E280B0676C697365';

-- Entry 517: school id 26799, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Montherlant"
-- Original: "CÃ©cile Logeay"
-- Proposed: "Cécile Logeay"
UPDATE `schools` SET `contactname` = CONVERT(X'43C3A963696C65204C6F67656179' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26799 AND CAST(`contactname` AS BINARY) = X'43C383C2A963696C65204C6F67656179';

-- Entry 518: school id 26799, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Montherlant"
-- Original: "CÃ©cile Logeay"
-- Proposed: "Cécile Logeay"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'43C3A963696C65204C6F67656179' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26799 AND CAST(`headofschoolname` AS BINARY) = X'43C383C2A963696C65204C6F67656179';

-- Entry 519: school id 26799, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori AthÃ©na de Montherlant"
-- Original: "Ecole Montessori AthÃ©na de Montherlant"
-- Proposed: "Ecole Montessori Athéna de Montherlant"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920417468C3A96E61206465204D6F6E746865726C616E74' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26799 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920417468C383C2A96E61206465204D6F6E746865726C616E74';

-- Entry 520: school id 26800, column `address1`, deleted=no
-- School (as reported): "Ecole Internationale Montessori Esclaibes- Paris"
-- Original: "43 rue FranÃ§ois GÃ©rard"
-- Proposed: "43 rue François Gérard"
UPDATE `schools` SET `address1` = CONVERT(X'343320727565204672616EC3A76F69732047C3A972617264' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26800 AND CAST(`address1` AS BINARY) = X'343320727565204672616EC383C2A76F69732047C383C2A972617264';

-- Entry 521: school id 26806, column `city`, deleted=no
-- School (as reported): "Lâ€™Ecole des Essentiels"
-- Original: "ChÃ¢teau Gaillard"
-- Proposed: "Château Gaillard"
UPDATE `schools` SET `city` = CONVERT(X'4368C3A274656175204761696C6C617264' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26806 AND CAST(`city` AS BINARY) = X'4368C383C2A274656175204761696C6C617264';

-- Entry 522: school id 26806, column `schoolname`, deleted=no
-- School (as reported): "Lâ€™Ecole des Essentiels"
-- Original: "Lâ€™Ecole des Essentiels"
-- Proposed: "L’Ecole des Essentiels"
UPDATE `schools` SET `schoolname` = CONVERT(X'4CE2809945636F6C652064657320457373656E7469656C73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26806 AND CAST(`schoolname` AS BINARY) = X'4CC3A2E282ACE284A245636F6C652064657320457373656E7469656C73';

-- Entry 523: school id 26807, column `address1`, deleted=no
-- School (as reported): "Beautiful Minds Ecole Montessori Internationale Puteaux AmpÃ¨re"
-- Original: "10, rue AmpÃ¨re"
-- Proposed: "10, rue Ampère"
UPDATE `schools` SET `address1` = CONVERT(X'31302C2072756520416D70C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26807 AND CAST(`address1` AS BINARY) = X'31302C2072756520416D70C383C2A87265';

-- Entry 524: school id 26807, column `schoolname`, deleted=no
-- School (as reported): "Beautiful Minds Ecole Montessori Internationale Puteaux AmpÃ¨re"
-- Original: "Beautiful Minds Ecole Montessori Internationale Puteaux AmpÃ¨re"
-- Proposed: "Beautiful Minds Ecole Montessori Internationale Puteaux Ampère"
UPDATE `schools` SET `schoolname` = CONVERT(X'42656175746966756C204D696E64732045636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65205075746561757820416D70C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26807 AND CAST(`schoolname` AS BINARY) = X'42656175746966756C204D696E64732045636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65205075746561757820416D70C383C2A87265';

-- Entry 525: school id 26808, column `address1`, deleted=no
-- School (as reported): "Beautiful Minds Ecole Montessori Internationale ThÃ©Ã¢tre"
-- Original: "1, place du ThÃ©Ã¢tre"
-- Proposed: "1, place du Théâtre"
UPDATE `schools` SET `address1` = CONVERT(X'312C20706C616365206475205468C3A9C3A2747265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26808 AND CAST(`address1` AS BINARY) = X'312C20706C616365206475205468C383C2A9C383C2A2747265';

-- Entry 526: school id 26808, column `schoolname`, deleted=no
-- School (as reported): "Beautiful Minds Ecole Montessori Internationale ThÃ©Ã¢tre"
-- Original: "Beautiful Minds Ecole Montessori Internationale ThÃ©Ã¢tre"
-- Proposed: "Beautiful Minds Ecole Montessori Internationale Théâtre"
UPDATE `schools` SET `schoolname` = CONVERT(X'42656175746966756C204D696E64732045636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65205468C3A9C3A2747265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26808 AND CAST(`schoolname` AS BINARY) = X'42656175746966756C204D696E64732045636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65205468C383C2A9C383C2A2747265';

-- Entry 527: school id 26809, column `schoolname`, deleted=no
-- School (as reported): "Ecole Montessori Internationale Le KalÃ©idoscop- rue du Four location"
-- Original: "Ecole Montessori Internationale Le KalÃ©idoscop- rue du Four location"
-- Proposed: "Ecole Montessori Internationale Le Kaléidoscop- rue du Four location"
UPDATE `schools` SET `schoolname` = CONVERT(X'45636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65204C65204B616CC3A969646F73636F702D2072756520647520466F7572206C6F636174696F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26809 AND CAST(`schoolname` AS BINARY) = X'45636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C65204C65204B616CC383C2A969646F73636F702D2072756520647520466F7572206C6F636174696F6E';

-- Entry 528: school id 26814, column `contactname`, deleted=no
-- School (as reported): "Ecole Montessoride La Colline-Montcalm"
-- Original: "VÃ©ronique GagnÃ©"
-- Proposed: "Véronique Gagné"
UPDATE `schools` SET `contactname` = CONVERT(X'56C3A9726F6E69717565204761676EC3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26814 AND CAST(`contactname` AS BINARY) = X'56C383C2A9726F6E69717565204761676EC383C2A9';

-- Entry 529: school id 26814, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessoride La Colline-Montcalm"
-- Original: "VÃ©ronique GagnÃ©"
-- Proposed: "Véronique Gagné"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'56C3A9726F6E69717565204761676EC3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26814 AND CAST(`headofschoolname` AS BINARY) = X'56C383C2A9726F6E69717565204761676EC383C2A9';

-- Entry 530: school id 26825, column `schoolname`, deleted=no
-- School (as reported): "Island Childrenâ€™s Montessori School & Kindergarten"
-- Original: "Island Childrenâ€™s Montessori School & Kindergarten"
-- Proposed: "Island Children’s Montessori School & Kindergarten"
UPDATE `schools` SET `schoolname` = CONVERT(X'49736C616E64204368696C6472656EE2809973204D6F6E746573736F7269205363686F6F6C2026204B696E64657267617274656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26825 AND CAST(`schoolname` AS BINARY) = X'49736C616E64204368696C6472656EC3A2E282ACE284A273204D6F6E746573736F7269205363686F6F6C2026204B696E64657267617274656E';

-- Entry 531: school id 26828, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole at Montessori- Notre-Dame-des-Champs"
-- Original: "Ã‰cole at Montessori- Notre-Dame-des-Champs"
-- Proposed: "École at Montessori- Notre-Dame-des-Champs"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65206174204D6F6E746573736F72692D204E6F7472652D44616D652D6465732D4368616D7073' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26828 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65206174204D6F6E746573736F72692D204E6F7472652D44616D652D6465732D4368616D7073';

-- Entry 532: school id 26829, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole at Montessori- Villars"
-- Original: "Ã‰cole at Montessori- Villars"
-- Proposed: "École at Montessori- Villars"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65206174204D6F6E746573736F72692D2056696C6C617273' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26829 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65206174204D6F6E746573736F72692D2056696C6C617273';

-- Entry 533: school id 26831, column `address1`, deleted=no
-- School (as reported): "IMagine Montessori Angers"
-- Original: "74 rue Haute de ReculÃ©e"
-- Proposed: "74 rue Haute de Reculée"
UPDATE `schools` SET `address1` = CONVERT(X'37342072756520486175746520646520526563756CC3A965' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26831 AND CAST(`address1` AS BINARY) = X'37342072756520486175746520646520526563756CC383C2A965';

-- Entry 534: school id 26838, column `address1`, deleted=no
-- School (as reported): "Ecole Montessori de Pau"
-- Original: "4 Bis Rue Maryse BastiÃ©"
-- Proposed: "4 Bis Rue Maryse Bastié"
UPDATE `schools` SET `address1` = CONVERT(X'342042697320527565204D6172797365204261737469C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26838 AND CAST(`address1` AS BINARY) = X'342042697320527565204D6172797365204261737469C383C2A9';

-- Entry 535: school id 26839, column `address1`, deleted=no
-- School (as reported): "Montessori Hossegor"
-- Original: "189 Avenue de PÃ©debert"
-- Proposed: "189 Avenue de Pédebert"
UPDATE `schools` SET `address1` = CONVERT(X'313839204176656E75652064652050C3A9646562657274' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26839 AND CAST(`address1` AS BINARY) = X'313839204176656E75652064652050C383C2A9646562657274';

-- Entry 536: school id 26840, column `headofschoolname`, deleted=no
-- School (as reported): "Ecole Montessori d'Uzes"
-- Original: "Camille HÃ©riard Dubreuil"
-- Proposed: "Camille Hériard Dubreuil"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'43616D696C6C652048C3A9726961726420447562726575696C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26840 AND CAST(`headofschoolname` AS BINARY) = X'43616D696C6C652048C383C2A9726961726420447562726575696C';

-- Entry 537: school id 26843, column `address1`, deleted=no
-- School (as reported): "Ecole La Vie est Belle"
-- Original: "ChÃ¢teau Latour SÃ©gur"
-- Proposed: "Château Latour Ségur"
UPDATE `schools` SET `address1` = CONVERT(X'4368C3A274656175204C61746F75722053C3A9677572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26843 AND CAST(`address1` AS BINARY) = X'4368C383C2A274656175204C61746F75722053C383C2A9677572';

-- Entry 538: school id 26844, column `address1`, deleted=no
-- School (as reported): "Le Verger d'Elisa Ecole Montessori Bilingue"
-- Original: "5 Rue de penthiÃ¨vre,"
-- Proposed: "5 Rue de penthièvre,"
UPDATE `schools` SET `address1` = CONVERT(X'35205275652064652070656E746869C3A87672652C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26844 AND CAST(`address1` AS BINARY) = X'35205275652064652070656E746869C383C2A87672652C';

-- Entry 539: school id 26844, column `city`, deleted=no
-- School (as reported): "Le Verger d'Elisa Ecole Montessori Bilingue"
-- Original: "CrÃ©cy-la-Chapelle"
-- Proposed: "Crécy-la-Chapelle"
UPDATE `schools` SET `city` = CONVERT(X'4372C3A963792D6C612D43686170656C6C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26844 AND CAST(`city` AS BINARY) = X'4372C383C2A963792D6C612D43686170656C6C65';

-- Entry 540: school id 26847, column `city`, deleted=no
-- School (as reported): "We Love MÃ´mes"
-- Original: "CarriÃ¨res-sur-Seine"
-- Proposed: "Carrières-sur-Seine"
UPDATE `schools` SET `city` = CONVERT(X'4361727269C3A87265732D7375722D5365696E65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26847 AND CAST(`city` AS BINARY) = X'4361727269C383C2A87265732D7375722D5365696E65';

-- Entry 541: school id 26847, column `schoolname`, deleted=no
-- School (as reported): "We Love MÃ´mes"
-- Original: "We Love MÃ´mes"
-- Proposed: "We Love Mômes"
UPDATE `schools` SET `schoolname` = CONVERT(X'5765204C6F7665204DC3B46D6573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26847 AND CAST(`schoolname` AS BINARY) = X'5765204C6F7665204DC383C2B46D6573';

-- Entry 542: school id 26848, column `address1`, deleted=no
-- School (as reported): "Kiddy Planet- A Montessori Bilingual School"
-- Original: "Quartier SabliÃ¨re (AKANDA)"
-- Proposed: "Quartier Sablière (AKANDA)"
UPDATE `schools` SET `address1` = CONVERT(X'5175617274696572205361626C69C3A872652028414B414E444129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26848 AND CAST(`address1` AS BINARY) = X'5175617274696572205361626C69C383C2A872652028414B414E444129';

-- Entry 543: school id 26850, column `city`, deleted=no
-- School (as reported): "Montessori-Kinderhaus St. Theresia"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26850 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 544: school id 26855, column `city`, deleted=no
-- School (as reported): "Today's Kids Montessori School"
-- Original: "BayamÃ³n"
-- Proposed: "Bayamón"
UPDATE `schools` SET `city` = CONVERT(X'426179616DC3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26855 AND CAST(`city` AS BINARY) = X'426179616DC383C2B36E';

-- Entry 545: school id 26856, column `city`, deleted=no
-- School (as reported): "Colegio Akua"
-- Original: "Santa Coloma de CervellÃ³"
-- Proposed: "Santa Coloma de Cervelló"
UPDATE `schools` SET `city` = CONVERT(X'53616E746120436F6C6F6D612064652043657276656C6CC3B3' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26856 AND CAST(`city` AS BINARY) = X'53616E746120436F6C6F6D612064652043657276656C6CC383C2B3';

-- Entry 546: school id 26857, column `schoolname`, deleted=no
-- School (as reported): "La TrÃ©bola Montessori School"
-- Original: "La TrÃ©bola Montessori School"
-- Proposed: "La Trébola Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C61205472C3A9626F6C61204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26857 AND CAST(`schoolname` AS BINARY) = X'4C61205472C383C2A9626F6C61204D6F6E746573736F7269205363686F6F6C';

-- Entry 547: school id 26857, column `stateprovince`, deleted=no
-- School (as reported): "La TrÃ©bola Montessori School"
-- Original: "CÃ³rdoba"
-- Proposed: "Córdoba"
UPDATE `schools` SET `stateprovince` = CONVERT(X'43C3B372646F6261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26857 AND CAST(`stateprovince` AS BINARY) = X'43C383C2B372646F6261';

-- Entry 548: school id 26858, column `city`, deleted=no
-- School (as reported): "Euscuela Montessori La Aldea"
-- Original: "BayamÃ³n"
-- Proposed: "Bayamón"
UPDATE `schools` SET `city` = CONVERT(X'426179616DC3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26858 AND CAST(`city` AS BINARY) = X'426179616DC383C2B36E';

-- Entry 549: school id 26860, column `schoolname`, deleted=no
-- School (as reported): "Casa Montessori Del NiÃ±o"
-- Original: "Casa Montessori Del NiÃ±o"
-- Proposed: "Casa Montessori Del Niño"
UPDATE `schools` SET `schoolname` = CONVERT(X'43617361204D6F6E746573736F72692044656C204E69C3B16F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26860 AND CAST(`schoolname` AS BINARY) = X'43617361204D6F6E746573736F72692044656C204E69C383C2B16F';

-- Entry 550: school id 26861, column `city`, deleted=no
-- School (as reported): "Montessori Garden School"
-- Original: "Lomas Verdes BayamÃ³n"
-- Proposed: "Lomas Verdes Bayamón"
UPDATE `schools` SET `city` = CONVERT(X'4C6F6D61732056657264657320426179616DC3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26861 AND CAST(`city` AS BINARY) = X'4C6F6D61732056657264657320426179616DC383C2B36E';

-- Entry 551: school id 26865, column `schoolname`, deleted=no
-- School (as reported): "Ambiente Montessori Mundo Del NiÃ±o"
-- Original: "Ambiente Montessori Mundo Del NiÃ±o"
-- Proposed: "Ambiente Montessori Mundo Del Niño"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D6269656E7465204D6F6E746573736F7269204D756E646F2044656C204E69C3B16F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26865 AND CAST(`schoolname` AS BINARY) = X'416D6269656E7465204D6F6E746573736F7269204D756E646F2044656C204E69C383C2B16F';

-- Entry 552: school id 26866, column `address1`, deleted=no
-- School (as reported): "Instituto Nueva Escuela "
-- Original: "Ave. Ponce de LeÃ³n #1101, Altos Esq."
-- Proposed: "Ave. Ponce de León #1101, Altos Esq."
UPDATE `schools` SET `address1` = CONVERT(X'4176652E20506F6E6365206465204C65C3B36E2023313130312C20416C746F73204573712E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26866 AND CAST(`address1` AS BINARY) = X'4176652E20506F6E6365206465204C65C383C2B36E2023313130312C20416C746F73204573712E';

-- Entry 553: school id 26866, column `city`, deleted=no
-- School (as reported): "Instituto Nueva Escuela "
-- Original: "â€‹RÃ­o Piedras"
-- Decoded (before cleanup): "​Río Piedras"
-- Cleanup: removed invisible U+200B ZERO WIDTH SPACE
-- Proposed: "Río Piedras"
UPDATE `schools` SET `city` = CONVERT(X'52C3AD6F2050696564726173' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26866 AND CAST(`city` AS BINARY) = X'C3A2E282ACE280B952C383C2AD6F2050696564726173';

-- Entry 554: school id 26867, column `schoolname`, deleted=no
-- School (as reported): "Escuela Montessori San CristÃ³bal"
-- Original: "Escuela Montessori San CristÃ³bal"
-- Proposed: "Escuela Montessori San Cristóbal"
UPDATE `schools` SET `schoolname` = CONVERT(X'45736375656C61204D6F6E746573736F72692053616E204372697374C3B362616C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26867 AND CAST(`schoolname` AS BINARY) = X'45736375656C61204D6F6E746573736F72692053616E204372697374C383C2B362616C';

-- Entry 555: school id 26870, column `schoolname`, deleted=yes
-- School (as reported): "MorivivÃ­ Montessori School"
-- Original: "MorivivÃ­ Montessori School"
-- Proposed: "Moriviví Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F7269766976C3AD204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26870 AND CAST(`schoolname` AS BINARY) = X'4D6F7269766976C383C2AD204D6F6E746573736F7269205363686F6F6C';

-- Entry 556: school id 26871, column `address1`, deleted=yes
-- School (as reported): "Pasiflora Montessori"
-- Original: "Bo. Rio CaÃ±as Sector Quebrada Arenas PR-799"
-- Proposed: "Bo. Rio Cañas Sector Quebrada Arenas PR-799"
UPDATE `schools` SET `address1` = CONVERT(X'426F2E2052696F204361C3B1617320536563746F72205175656272616461204172656E61732050522D373939' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26871 AND CAST(`address1` AS BINARY) = X'426F2E2052696F204361C383C2B1617320536563746F72205175656272616461204172656E61732050522D373939';

-- Entry 557: school id 26873, column `address1`, deleted=yes
-- School (as reported): "Cundeamor Montessori"
-- Original: "Nuevas Villas del ManatÃ­"
-- Proposed: "Nuevas Villas del Manatí"
UPDATE `schools` SET `address1` = CONVERT(X'4E75657661732056696C6C61732064656C204D616E6174C3AD' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26873 AND CAST(`address1` AS BINARY) = X'4E75657661732056696C6C61732064656C204D616E6174C383C2AD';

-- Entry 558: school id 26873, column `city`, deleted=yes
-- School (as reported): "Cundeamor Montessori"
-- Original: "ManatÃ­"
-- Proposed: "Manatí"
UPDATE `schools` SET `city` = CONVERT(X'4D616E6174C3AD' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26873 AND CAST(`city` AS BINARY) = X'4D616E6174C383C2AD';

-- Entry 559: school id 26878, column `schoolname`, deleted=no
-- School (as reported): "La Casa del NiÃ±o Montessori School"
-- Original: "La Casa del NiÃ±o Montessori School"
-- Proposed: "La Casa del Niño Montessori School"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C6120436173612064656C204E69C3B16F204D6F6E746573736F7269205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26878 AND CAST(`schoolname` AS BINARY) = X'4C6120436173612064656C204E69C383C2B16F204D6F6E746573736F7269205363686F6F6C';

-- Entry 560: school id 26879, column `address1`, deleted=no
-- School (as reported): "El Cole Montessori"
-- Original: "FÃ¡brica de Armas No. 18"
-- Proposed: "Fábrica de Armas No. 18"
UPDATE `schools` SET `address1` = CONVERT(X'46C3A162726963612064652041726D6173204E6F2E203138' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26879 AND CAST(`address1` AS BINARY) = X'46C383C2A162726963612064652041726D6173204E6F2E203138';

-- Entry 561: school id 26884, column `city`, deleted=no
-- School (as reported): "Cintli Montessori School"
-- Original: "Naucalpan de JuÃ¡rez"
-- Proposed: "Naucalpan de Juárez"
UPDATE `schools` SET `city` = CONVERT(X'4E617563616C70616E206465204A75C3A172657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26884 AND CAST(`city` AS BINARY) = X'4E617563616C70616E206465204A75C383C2A172657A';

-- Entry 562: school id 26885, column `schoolname`, deleted=no
-- School (as reported): "Comunidad Educativa LeÃ³n Felipe"
-- Original: "Comunidad Educativa LeÃ³n Felipe"
-- Proposed: "Comunidad Educativa León Felipe"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6D756E6964616420456475636174697661204C65C3B36E2046656C697065' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26885 AND CAST(`schoolname` AS BINARY) = X'436F6D756E6964616420456475636174697661204C65C383C2B36E2046656C697065';

-- Entry 563: school id 26886, column `schoolname`, deleted=yes
-- School (as reported): "EmunÃ¡ Montessori"
-- Original: "EmunÃ¡ Montessori"
-- Proposed: "Emuná Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'456D756EC3A1204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26886 AND CAST(`schoolname` AS BINARY) = X'456D756EC383C2A1204D6F6E746573736F7269';

-- Entry 564: school id 26887, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori Lindavista"
-- Original: "Maria del C. MontaÃ±o"
-- Proposed: "Maria del C. Montaño"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D617269612064656C20432E204D6F6E7461C3B16F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26887 AND CAST(`headofschoolname` AS BINARY) = X'4D617269612064656C20432E204D6F6E7461C383C2B16F';

-- Entry 565: school id 26890, column `address1`, deleted=no
-- School (as reported): "Kuni Montessori"
-- Original: "la Colonia Condesa de la Cd. de MÃ©xico en la calle de Cuernavaca #16."
-- Proposed: "la Colonia Condesa de la Cd. de México en la calle de Cuernavaca #16."
UPDATE `schools` SET `address1` = CONVERT(X'6C6120436F6C6F6E696120436F6E64657361206465206C612043642E206465204DC3A97869636F20656E206C612063616C6C6520646520437565726E6176616361202331362E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26890 AND CAST(`address1` AS BINARY) = X'6C6120436F6C6F6E696120436F6E64657361206465206C612043642E206465204DC383C2A97869636F20656E206C612063616C6C6520646520437565726E6176616361202331362E';

-- Entry 566: school id 26891, column `headofschoolname`, deleted=no
-- School (as reported): "The Oak Tree School"
-- Original: "AÃ­da BolaÃ±os"
-- Proposed: "Aída Bolaños"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'41C3AD646120426F6C61C3B16F73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26891 AND CAST(`headofschoolname` AS BINARY) = X'41C383C2AD646120426F6C61C383C2B16F73';

-- Entry 567: school id 26893, column `address1`, deleted=no
-- School (as reported): "Peterson School Lomas"
-- Original: "Monte Himalaya #615- Lomas de ChapultepÃ©c"
-- Proposed: "Monte Himalaya #615- Lomas de Chapultepéc"
UPDATE `schools` SET `address1` = CONVERT(X'4D6F6E74652048696D616C61796120233631352D204C6F6D61732064652043686170756C746570C3A963' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26893 AND CAST(`address1` AS BINARY) = X'4D6F6E74652048696D616C61796120233631352D204C6F6D61732064652043686170756C746570C383C2A963';

-- Entry 568: school id 26895, column `address1`, deleted=no
-- School (as reported): "Peterson School Pedregal"
-- Original: "RocÃ­o # 42, Jardines del Pedregal"
-- Proposed: "Rocío # 42, Jardines del Pedregal"
UPDATE `schools` SET `address1` = CONVERT(X'526F63C3AD6F20232034322C204A617264696E65732064656C20506564726567616C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26895 AND CAST(`address1` AS BINARY) = X'526F63C383C2AD6F20232034322C204A617264696E65732064656C20506564726567616C';

-- Entry 569: school id 26895, column `headofschoolname`, deleted=no
-- School (as reported): "Peterson School Pedregal"
-- Original: "MÃ³nica DurÃ¡n"
-- Proposed: "Mónica Durán"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4DC3B36E69636120447572C3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26895 AND CAST(`headofschoolname` AS BINARY) = X'4DC383C2B36E69636120447572C383C2A16E';

-- Entry 570: school id 26900, column `address2`, deleted=no
-- School (as reported): "The Montessori School of Mallorca"
-- Original: "Santa Maria del CamÃ­"
-- Proposed: "Santa Maria del Camí"
UPDATE `schools` SET `address2` = CONVERT(X'53616E7461204D617269612064656C2043616DC3AD' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26900 AND CAST(`address2` AS BINARY) = X'53616E7461204D617269612064656C2043616DC383C2AD';

-- Entry 571: school id 26901, column `address2`, deleted=yes
-- School (as reported): "Casa del Mar Montessori Marbella"
-- Original: "San Pedro AlcÃ¡ntara"
-- Proposed: "San Pedro Alcántara"
UPDATE `schools` SET `address2` = CONVERT(X'53616E20506564726F20416C63C3A16E74617261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26901 AND CAST(`address2` AS BINARY) = X'53616E20506564726F20416C63C383C2A16E74617261';

-- Entry 572: school id 26902, column `address2`, deleted=yes
-- School (as reported): "Colegio Saint George's Schoo"
-- Original: "San Pedro AlcÃ¡ntara Marbella"
-- Proposed: "San Pedro Alcántara Marbella"
UPDATE `schools` SET `address2` = CONVERT(X'53616E20506564726F20416C63C3A16E74617261204D617262656C6C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26902 AND CAST(`address2` AS BINARY) = X'53616E20506564726F20416C63C383C2A16E74617261204D617262656C6C61';

-- Entry 573: school id 26902, column `city`, deleted=yes
-- School (as reported): "Colegio Saint George's Schoo"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `city` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26902 AND CAST(`city` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 574: school id 26902, column `headofschoolname`, deleted=yes
-- School (as reported): "Colegio Saint George's Schoo"
-- Original: "Andrew & Maria JosÃ© Mardlin"
-- Proposed: "Andrew & Maria José Mardlin"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'416E647265772026204D61726961204A6F73C3A9204D6172646C696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26902 AND CAST(`headofschoolname` AS BINARY) = X'416E647265772026204D61726961204A6F73C383C2A9204D6172646C696E';

-- Entry 575: school id 26903, column `city`, deleted=yes
-- School (as reported): "Calpe School"
-- Original: "Marbella (MÃ¡laga)"
-- Proposed: "Marbella (Málaga)"
UPDATE `schools` SET `city` = CONVERT(X'4D617262656C6C6120284DC3A16C61676129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26903 AND CAST(`city` AS BINARY) = X'4D617262656C6C6120284DC383C2A16C61676129';

-- Entry 576: school id 26912, column `city`, deleted=no
-- School (as reported): "Cotlegi Creanova"
-- Original: "Sant Cugat del VallÃ©s"
-- Proposed: "Sant Cugat del Vallés"
UPDATE `schools` SET `city` = CONVERT(X'53616E742043756761742064656C2056616C6CC3A973' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26912 AND CAST(`city` AS BINARY) = X'53616E742043756761742064656C2056616C6CC383C2A973';

-- Entry 577: school id 26913, column `address1`, deleted=no
-- School (as reported): "Centre La Poma"
-- Original: "C/ de ValÃ¨ncia, 87"
-- Proposed: "C/ de València, 87"
UPDATE `schools` SET `address1` = CONVERT(X'432F2064652056616CC3A86E6369612C203837' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26913 AND CAST(`address1` AS BINARY) = X'432F2064652056616CC383C2A86E6369612C203837';

-- Entry 578: school id 26914, column `city`, deleted=no
-- School (as reported): "Palma Kids Escuela Infantil Montessori"
-- Original: "La CaÃ±ada"
-- Proposed: "La Cañada"
UPDATE `schools` SET `city` = CONVERT(X'4C61204361C3B1616461' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26914 AND CAST(`city` AS BINARY) = X'4C61204361C383C2B1616461';

-- Entry 579: school id 26915, column `contactname`, deleted=no
-- School (as reported): "Dilyan Montessori Barakaldo"
-- Original: "Ãngela Ospina"
-- Proposed: "Ángela Ospina"
UPDATE `schools` SET `contactname` = CONVERT(X'C3816E67656C61204F7370696E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26915 AND CAST(`contactname` AS BINARY) = X'C383C2816E67656C61204F7370696E61';

-- Entry 580: school id 26916, column `address1`, deleted=yes
-- School (as reported): "The English Garden Montessori Preschool"
-- Original: "Calle MarÃ­a La JudÃ­a, 18"
-- Proposed: "Calle María La Judía, 18"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204D6172C3AD61204C61204A7564C3AD612C203138' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26916 AND CAST(`address1` AS BINARY) = X'43616C6C65204D6172C383C2AD61204C61204A7564C383C2AD612C203138';

-- Entry 581: school id 26916, column `city`, deleted=yes
-- School (as reported): "The English Garden Montessori Preschool"
-- Original: "CÃ³doba"
-- Proposed: "Códoba"
UPDATE `schools` SET `city` = CONVERT(X'43C3B3646F6261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26916 AND CAST(`city` AS BINARY) = X'43C383C2B3646F6261';

-- Entry 582: school id 26917, column `address1`, deleted=no
-- School (as reported): "Montessori CÃ³rdoba International School"
-- Original: "Calle SansueÃ±a, 66"
-- Proposed: "Calle Sansueña, 66"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C652053616E737565C3B1612C203636' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26917 AND CAST(`address1` AS BINARY) = X'43616C6C652053616E737565C383C2B1612C203636';

-- Entry 583: school id 26917, column `schoolname`, deleted=no
-- School (as reported): "Montessori CÃ³rdoba International School"
-- Original: "Montessori CÃ³rdoba International School"
-- Proposed: "Montessori Córdoba International School"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692043C3B372646F626120496E7465726E6174696F6E616C205363686F6F6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26917 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692043C383C2B372646F626120496E7465726E6174696F6E616C205363686F6F6C';

-- Entry 584: school id 26918, column `city`, deleted=no
-- School (as reported): "Casa de NiÃ±os Ãrbol Madre"
-- Original: "Ã“rgiva"
-- Proposed: "Órgiva"
UPDATE `schools` SET `city` = CONVERT(X'C3937267697661' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26918 AND CAST(`city` AS BINARY) = X'C383E2809C7267697661';

-- Entry 585: school id 26918, column `schoolname`, deleted=no
-- School (as reported): "Casa de NiÃ±os Ãrbol Madre"
-- Original: "Casa de NiÃ±os Ãrbol Madre"
-- Proposed: "Casa de Niños Árbol Madre"
UPDATE `schools` SET `schoolname` = CONVERT(X'43617361206465204E69C3B16F7320C38172626F6C204D61647265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26918 AND CAST(`schoolname` AS BINARY) = X'43617361206465204E69C383C2B16F7320C383C28172626F6C204D61647265';

-- Entry 586: school id 26920, column `address1`, deleted=no
-- School (as reported): "The InglÃ©s Garden"
-- Original: "Calle SansueÃ±a, 66"
-- Proposed: "Calle Sansueña, 66"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C652053616E737565C3B1612C203636' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26920 AND CAST(`address1` AS BINARY) = X'43616C6C652053616E737565C383C2B1612C203636';

-- Entry 587: school id 26920, column `schoolname`, deleted=no
-- School (as reported): "The InglÃ©s Garden"
-- Original: "The InglÃ©s Garden"
-- Proposed: "The Inglés Garden"
UPDATE `schools` SET `schoolname` = CONVERT(X'54686520496E676CC3A9732047617264656E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26920 AND CAST(`schoolname` AS BINARY) = X'54686520496E676CC383C2A9732047617264656E';

-- Entry 588: school id 26920, column `stateprovince`, deleted=no
-- School (as reported): "The InglÃ©s Garden"
-- Original: "CÃ³rdoba"
-- Proposed: "Córdoba"
UPDATE `schools` SET `stateprovince` = CONVERT(X'43C3B372646F6261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26920 AND CAST(`stateprovince` AS BINARY) = X'43C383C2B372646F6261';

-- Entry 589: school id 26921, column `city`, deleted=no
-- School (as reported): "Galapagos Montessori Center"
-- Original: "GÃ³jar"
-- Proposed: "Gójar"
UPDATE `schools` SET `city` = CONVERT(X'47C3B36A6172' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26921 AND CAST(`city` AS BINARY) = X'47C383C2B36A6172';

-- Entry 590: school id 26922, column `schoolname`, deleted=yes
-- School (as reported): "Centro de FormaciÃ³n Montessori S.L."
-- Original: "Centro de FormaciÃ³n Montessori S.L."
-- Proposed: "Centro de Formación Montessori S.L."
UPDATE `schools` SET `schoolname` = CONVERT(X'43656E74726F20646520466F726D616369C3B36E204D6F6E746573736F726920532E4C2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26922 AND CAST(`schoolname` AS BINARY) = X'43656E74726F20646520466F726D616369C383C2B36E204D6F6E746573736F726920532E4C2E';

-- Entry 591: school id 26926, column `contactname`, deleted=yes
-- School (as reported): "Montessori Village Maresme"
-- Original: "Maria GimÃ©nez"
-- Proposed: "Maria Giménez"
UPDATE `schools` SET `contactname` = CONVERT(X'4D617269612047696DC3A96E657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26926 AND CAST(`contactname` AS BINARY) = X'4D617269612047696DC383C2A96E657A';

-- Entry 592: school id 26927, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori Community Granada"
-- Original: "EstefanÃ­a AlbarrÃ¡n"
-- Proposed: "Estefanía Albarrán"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4573746566616EC3AD6120416C62617272C3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26927 AND CAST(`headofschoolname` AS BINARY) = X'4573746566616EC383C2AD6120416C62617272C383C2A16E';

-- Entry 593: school id 26928, column `address1`, deleted=no
-- School (as reported): "Sendas Espacio De Aprendizaje Montessori"
-- Original: "Ctra. Aracena-CorteconcepciÃ³n, Km.0.5"
-- Proposed: "Ctra. Aracena-Corteconcepción, Km.0.5"
UPDATE `schools` SET `address1` = CONVERT(X'437472612E2041726163656E612D436F727465636F6E6365706369C3B36E2C204B6D2E302E35' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26928 AND CAST(`address1` AS BINARY) = X'437472612E2041726163656E612D436F727465636F6E6365706369C383C2B36E2C204B6D2E302E35';

-- Entry 594: school id 26929, column `city`, deleted=no
-- School (as reported): "Colegio Internacional MarÃ­a Montessori"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `city` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26929 AND CAST(`city` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 595: school id 26929, column `schoolname`, deleted=no
-- School (as reported): "Colegio Internacional MarÃ­a Montessori"
-- Original: "Colegio Internacional MarÃ­a Montessori"
-- Proposed: "Colegio Internacional María Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F20496E7465726E6163696F6E616C204D6172C3AD61204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26929 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F20496E7465726E6163696F6E616C204D6172C383C2AD61204D6F6E746573736F7269';

-- Entry 596: school id 26930, column `address1`, deleted=no
-- School (as reported): "International Montessori School - Caracoliris"
-- Original: "Avda de la MÃºsica 120, Urb La CapellÃ¡nia"
-- Proposed: "Avda de la Música 120, Urb La Capellánia"
UPDATE `schools` SET `address1` = CONVERT(X'41766461206465206C61204DC3BA73696361203132302C20557262204C6120436170656C6CC3A16E6961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26930 AND CAST(`address1` AS BINARY) = X'41766461206465206C61204DC383C2BA73696361203132302C20557262204C6120436170656C6CC383C2A16E6961';

-- Entry 597: school id 26930, column `headofschoolname`, deleted=no
-- School (as reported): "International Montessori School - Caracoliris"
-- Original: "Marina Osorio and M. Beatriz RamÃ­rez"
-- Proposed: "Marina Osorio and M. Beatriz Ramírez"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D6172696E61204F736F72696F20616E64204D2E204265617472697A2052616DC3AD72657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26930 AND CAST(`headofschoolname` AS BINARY) = X'4D6172696E61204F736F72696F20616E64204D2E204265617472697A2052616DC383C2AD72657A';

-- Entry 598: school id 26930, column `stateprovince`, deleted=no
-- School (as reported): "International Montessori School - Caracoliris"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `stateprovince` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26930 AND CAST(`stateprovince` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 599: school id 26931, column `address1`, deleted=no
-- School (as reported): "RaÃ­ces Montessori BenalmÃ¡dena"
-- Original: "Nueva Torrequebrada BenalmÃ¡dena Costa"
-- Proposed: "Nueva Torrequebrada Benalmádena Costa"
UPDATE `schools` SET `address1` = CONVERT(X'4E7565766120546F72726571756562726164612042656E616C6DC3A164656E6120436F737461' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26931 AND CAST(`address1` AS BINARY) = X'4E7565766120546F72726571756562726164612042656E616C6DC383C2A164656E6120436F737461';

-- Entry 600: school id 26931, column `city`, deleted=no
-- School (as reported): "RaÃ­ces Montessori BenalmÃ¡dena"
-- Original: "BenalmÃ¡dena"
-- Proposed: "Benalmádena"
UPDATE `schools` SET `city` = CONVERT(X'42656E616C6DC3A164656E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26931 AND CAST(`city` AS BINARY) = X'42656E616C6DC383C2A164656E61';

-- Entry 601: school id 26931, column `schoolname`, deleted=no
-- School (as reported): "RaÃ­ces Montessori BenalmÃ¡dena"
-- Original: "RaÃ­ces Montessori BenalmÃ¡dena"
-- Proposed: "Raíces Montessori Benalmádena"
UPDATE `schools` SET `schoolname` = CONVERT(X'5261C3AD636573204D6F6E746573736F72692042656E616C6DC3A164656E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26931 AND CAST(`schoolname` AS BINARY) = X'5261C383C2AD636573204D6F6E746573736F72692042656E616C6DC383C2A164656E61';

-- Entry 602: school id 26931, column `stateprovince`, deleted=no
-- School (as reported): "RaÃ­ces Montessori BenalmÃ¡dena"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `stateprovince` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26931 AND CAST(`stateprovince` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 603: school id 26932, column `city`, deleted=yes
-- School (as reported): "RaÃ­ces Montessori - BenalmÃ¡dena"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `city` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26932 AND CAST(`city` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 604: school id 26932, column `schoolname`, deleted=yes
-- School (as reported): "RaÃ­ces Montessori - BenalmÃ¡dena"
-- Original: "RaÃ­ces Montessori - BenalmÃ¡dena"
-- Proposed: "Raíces Montessori - Benalmádena"
UPDATE `schools` SET `schoolname` = CONVERT(X'5261C3AD636573204D6F6E746573736F7269202D2042656E616C6DC3A164656E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26932 AND CAST(`schoolname` AS BINARY) = X'5261C383C2AD636573204D6F6E746573736F7269202D2042656E616C6DC383C2A164656E61';

-- Entry 605: school id 26932, column `stateprovince`, deleted=yes
-- School (as reported): "RaÃ­ces Montessori - BenalmÃ¡dena"
-- Original: "BenalmÃ¡dena"
-- Proposed: "Benalmádena"
UPDATE `schools` SET `stateprovince` = CONVERT(X'42656E616C6DC3A164656E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26932 AND CAST(`stateprovince` AS BINARY) = X'42656E616C6DC383C2A164656E61';

-- Entry 606: school id 26940, column `address1`, deleted=no
-- School (as reported): "El Petit PrÃ­ncep"
-- Original: "CorrÃ³ 159-161, Balxos"
-- Proposed: "Corró 159-161, Balxos"
UPDATE `schools` SET `address1` = CONVERT(X'436F7272C3B3203135392D3136312C2042616C786F73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26940 AND CAST(`address1` AS BINARY) = X'436F7272C383C2B3203135392D3136312C2042616C786F73';

-- Entry 607: school id 26940, column `schoolname`, deleted=no
-- School (as reported): "El Petit PrÃ­ncep"
-- Original: "El Petit PrÃ­ncep"
-- Proposed: "El Petit Príncep"
UPDATE `schools` SET `schoolname` = CONVERT(X'456C205065746974205072C3AD6E636570' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26940 AND CAST(`schoolname` AS BINARY) = X'456C205065746974205072C383C2AD6E636570';

-- Entry 608: school id 26941, column `address1`, deleted=no
-- School (as reported): "Escola Natura-EducaciÃ³ Montessori"
-- Original: "CamÃ­ Antic de Santa Creu D'Olorda S/N"
-- Proposed: "Camí Antic de Santa Creu D'Olorda S/N"
UPDATE `schools` SET `address1` = CONVERT(X'43616DC3AD20416E7469632064652053616E746120437265752044274F6C6F72646120532F4E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26941 AND CAST(`address1` AS BINARY) = X'43616DC383C2AD20416E7469632064652053616E746120437265752044274F6C6F72646120532F4E';

-- Entry 609: school id 26941, column `schoolname`, deleted=no
-- School (as reported): "Escola Natura-EducaciÃ³ Montessori"
-- Original: "Escola Natura-EducaciÃ³ Montessori"
-- Proposed: "Escola Natura-Educació Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'4573636F6C61204E61747572612D45647563616369C3B3204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26941 AND CAST(`schoolname` AS BINARY) = X'4573636F6C61204E61747572612D45647563616369C383C2B3204D6F6E746573736F7269';

-- Entry 610: school id 26942, column `address1`, deleted=no
-- School (as reported): "La Casa de Fio"
-- Original: "Carrer de Joan GÃ¼ell"
-- Proposed: "Carrer de Joan Güell"
UPDATE `schools` SET `address1` = CONVERT(X'436172726572206465204A6F616E2047C3BC656C6C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26942 AND CAST(`address1` AS BINARY) = X'436172726572206465204A6F616E2047C383C2BC656C6C';

-- Entry 611: school id 26943, column `address1`, deleted=no
-- School (as reported): "Moderato Montessori Barcelona"
-- Original: "Carrer de LucÃ  8"
-- Proposed: "Carrer de Lucà 8"
UPDATE `schools` SET `address1` = CONVERT(X'436172726572206465204C7563C3A02038' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26943 AND CAST(`address1` AS BINARY) = X'436172726572206465204C7563C383C2A02038';

-- Entry 612: school id 26948, column `schoolname`, deleted=no
-- School (as reported): "Escuela Pangea - A CoruÃ±a"
-- Original: "Escuela Pangea - A CoruÃ±a"
-- Proposed: "Escuela Pangea - A Coruña"
UPDATE `schools` SET `schoolname` = CONVERT(X'45736375656C612050616E676561202D204120436F7275C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26948 AND CAST(`schoolname` AS BINARY) = X'45736375656C612050616E676561202D204120436F7275C383C2B161';

-- Entry 613: school id 26948, column `stateprovince`, deleted=no
-- School (as reported): "Escuela Pangea - A CoruÃ±a"
-- Original: "A CoruÃ±a"
-- Proposed: "A Coruña"
UPDATE `schools` SET `stateprovince` = CONVERT(X'4120436F7275C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26948 AND CAST(`stateprovince` AS BINARY) = X'4120436F7275C383C2B161';

-- Entry 614: school id 26949, column `city`, deleted=no
-- School (as reported): "Cuarto Creciente Montessori School"
-- Original: "LogroÃ±o"
-- Proposed: "Logroño"
UPDATE `schools` SET `city` = CONVERT(X'4C6F67726FC3B16F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26949 AND CAST(`city` AS BINARY) = X'4C6F67726FC383C2B16F';

-- Entry 615: school id 26952, column `address1`, deleted=no
-- School (as reported): "Montessori Alicante"
-- Original: "Calle HondÃ³n de los frailes 2"
-- Proposed: "Calle Hondón de los frailes 2"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520486F6E64C3B36E206465206C6F7320667261696C65732032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26952 AND CAST(`address1` AS BINARY) = X'43616C6C6520486F6E64C383C2B36E206465206C6F7320667261696C65732032';

-- Entry 616: school id 26954, column `city`, deleted=no
-- School (as reported): "Los Garabatos de Montessori"
-- Original: "AlcalÃ¡ de Henares (Madrid)"
-- Proposed: "Alcalá de Henares (Madrid)"
UPDATE `schools` SET `city` = CONVERT(X'416C63616CC3A12064652048656E6172657320284D616472696429' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26954 AND CAST(`city` AS BINARY) = X'416C63616CC383C2A12064652048656E6172657320284D616472696429';

-- Entry 617: school id 26955, column `schoolname`, deleted=no
-- School (as reported): "Casa Nido Centro Montessori BilingÃ¼e"
-- Original: "Casa Nido Centro Montessori BilingÃ¼e"
-- Proposed: "Casa Nido Centro Montessori Bilingüe"
UPDATE `schools` SET `schoolname` = CONVERT(X'43617361204E69646F2043656E74726F204D6F6E746573736F72692042696C696E67C3BC65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26955 AND CAST(`schoolname` AS BINARY) = X'43617361204E69646F2043656E74726F204D6F6E746573736F72692042696C696E67C383C2BC65';

-- Entry 618: school id 26957, column `address1`, deleted=no
-- School (as reported): "My Little Montessori"
-- Original: "Carrer d' AstÃºries 10- B2"
-- Proposed: "Carrer d' Astúries 10- B2"
UPDATE `schools` SET `address1` = CONVERT(X'43617272657220642720417374C3BA726965732031302D204232' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26957 AND CAST(`address1` AS BINARY) = X'43617272657220642720417374C383C2BA726965732031302D204232';

-- Entry 619: school id 26958, column `address1`, deleted=no
-- School (as reported): "Escola Montessori"
-- Original: "Mare de DÃ©u dels desemparats, 43"
-- Proposed: "Mare de Déu dels desemparats, 43"
UPDATE `schools` SET `address1` = CONVERT(X'4D6172652064652044C3A9752064656C7320646573656D7061726174732C203433' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26958 AND CAST(`address1` AS BINARY) = X'4D6172652064652044C383C2A9752064656C7320646573656D7061726174732C203433';

-- Entry 620: school id 26959, column `schoolname`, deleted=no
-- School (as reported): "Montessori Village SarriÃ¡"
-- Original: "Montessori Village SarriÃ¡"
-- Proposed: "Montessori Village Sarriá"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692056696C6C616765205361727269C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26959 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692056696C6C616765205361727269C383C2A1';

-- Entry 621: school id 26963, column `city`, deleted=no
-- School (as reported): "Kindergarten Maria Montessori"
-- Original: "AsunciÃ³n"
-- Proposed: "Asunción"
UPDATE `schools` SET `city` = CONVERT(X'4173756E6369C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26963 AND CAST(`city` AS BINARY) = X'4173756E6369C383C2B36E';

-- Entry 622: school id 26964, column `contactname`, deleted=no
-- School (as reported): "Caballito De Mar"
-- Original: "Luciana PÃ©rez"
-- Proposed: "Luciana Pérez"
UPDATE `schools` SET `contactname` = CONVERT(X'4C756369616E612050C3A972657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26964 AND CAST(`contactname` AS BINARY) = X'4C756369616E612050C383C2A972657A';

-- Entry 623: school id 26965, column `schoolname`, deleted=yes
-- School (as reported): "IEMarÃ­a Montessori"
-- Original: "IEMarÃ­a Montessori"
-- Proposed: "IEMaría Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'49454D6172C3AD61204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26965 AND CAST(`schoolname` AS BINARY) = X'49454D6172C383C2AD61204D6F6E746573736F7269';

-- Entry 624: school id 26969, column `address2`, deleted=yes
-- School (as reported): "Escuela Bosque TrillingÃ¼e Montessori"
-- Original: "BalcÃ³ De Tarragona"
-- Proposed: "Balcó De Tarragona"
UPDATE `schools` SET `address2` = CONVERT(X'42616C63C3B3204465205461727261676F6E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26969 AND CAST(`address2` AS BINARY) = X'42616C63C383C2B3204465205461727261676F6E61';

-- Entry 625: school id 26969, column `schoolname`, deleted=yes
-- School (as reported): "Escuela Bosque TrillingÃ¼e Montessori"
-- Original: "Escuela Bosque TrillingÃ¼e Montessori"
-- Proposed: "Escuela Bosque Trillingüe Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'45736375656C6120426F73717565205472696C6C696E67C3BC65204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26969 AND CAST(`schoolname` AS BINARY) = X'45736375656C6120426F73717565205472696C6C696E67C383C2BC65204D6F6E746573736F7269';

-- Entry 626: school id 26971, column `address1`, deleted=no
-- School (as reported): "Crecer sin prisa "
-- Original: "Calle JosÃ© SÃ¡ez 18"
-- Proposed: "Calle José Sáez 18"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204A6F73C3A92053C3A1657A203138' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26971 AND CAST(`address1` AS BINARY) = X'43616C6C65204A6F73C383C2A92053C383C2A1657A203138';

-- Entry 627: school id 26971, column `city`, deleted=no
-- School (as reported): "Crecer sin prisa "
-- Original: "BÃ©tera"
-- Proposed: "Bétera"
UPDATE `schools` SET `city` = CONVERT(X'42C3A974657261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26971 AND CAST(`city` AS BINARY) = X'42C383C2A974657261';

-- Entry 628: school id 26974, column `headofschoolname`, deleted=no
-- School (as reported): "Imagine Montessori School - La Pinada"
-- Original: "Mariano PontÃ³n"
-- Proposed: "Mariano Pontón"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D617269616E6F20506F6E74C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26974 AND CAST(`headofschoolname` AS BINARY) = X'4D617269616E6F20506F6E74C383C2B36E';

-- Entry 629: school id 26976, column `address1`, deleted=yes
-- School (as reported): "Montessori School Almeria"
-- Original: "Avda Nueva AlmerÃ­a 27"
-- Proposed: "Avda Nueva Almería 27"
UPDATE `schools` SET `address1` = CONVERT(X'41766461204E7565766120416C6D6572C3AD61203237' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26976 AND CAST(`address1` AS BINARY) = X'41766461204E7565766120416C6D6572C383C2AD61203237';

-- Entry 630: school id 26976, column `city`, deleted=yes
-- School (as reported): "Montessori School Almeria"
-- Original: "AlmerÃ­a"
-- Proposed: "Almería"
UPDATE `schools` SET `city` = CONVERT(X'416C6D6572C3AD61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26976 AND CAST(`city` AS BINARY) = X'416C6D6572C383C2AD61';

-- Entry 631: school id 26977, column `address1`, deleted=yes
-- School (as reported): "Montessori Palau Girona"
-- Original: "CamÃ­ Vell de Fornells 33"
-- Proposed: "Camí Vell de Fornells 33"
UPDATE `schools` SET `address1` = CONVERT(X'43616DC3AD2056656C6C20646520466F726E656C6C73203333' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26977 AND CAST(`address1` AS BINARY) = X'43616DC383C2AD2056656C6C20646520466F726E656C6C73203333';

-- Entry 632: school id 26979, column `address1`, deleted=no
-- School (as reported): "Beautiful Minds Montessori School"
-- Original: "Carrer d' AragÃ³,182"
-- Proposed: "Carrer d' Aragó,182"
UPDATE `schools` SET `address1` = CONVERT(X'4361727265722064272041726167C3B32C313832' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26979 AND CAST(`address1` AS BINARY) = X'4361727265722064272041726167C383C2B32C313832';

-- Entry 633: school id 26980, column `city`, deleted=no
-- School (as reported): "Centro educativo Montessori Rincon de Luz"
-- Original: "EstelÃ­"
-- Proposed: "Estelí"
UPDATE `schools` SET `city` = CONVERT(X'457374656CC3AD' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26980 AND CAST(`city` AS BINARY) = X'457374656CC383C2AD';

-- Entry 634: school id 26981, column `address1`, deleted=no
-- School (as reported): "Mi Casita Montessori"
-- Original: "UNAN Law School - LeÃ³n"
-- Proposed: "UNAN Law School - León"
UPDATE `schools` SET `address1` = CONVERT(X'554E414E204C6177205363686F6F6C202D204C65C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26981 AND CAST(`address1` AS BINARY) = X'554E414E204C6177205363686F6F6C202D204C65C383C2B36E';

-- Entry 635: school id 26981, column `city`, deleted=no
-- School (as reported): "Mi Casita Montessori"
-- Original: "LeÃ³n"
-- Proposed: "León"
UPDATE `schools` SET `city` = CONVERT(X'4C65C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26981 AND CAST(`city` AS BINARY) = X'4C65C383C2B36E';

-- Entry 636: school id 26983, column `address1`, deleted=no
-- School (as reported): "Mi Jardin Montessori"
-- Original: "Av 5 C Sur, PanamÃ¡"
-- Proposed: "Av 5 C Sur, Panamá"
UPDATE `schools` SET `address1` = CONVERT(X'417620352043205375722C2050616E616DC3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26983 AND CAST(`address1` AS BINARY) = X'417620352043205375722C2050616E616DC383C2A1';

-- Entry 637: school id 26986, column `address1`, deleted=no
-- School (as reported): "Montessori-Kinderhaus Arche Noah Donrath"
-- Original: "In der HÃ¼hene 28"
-- Proposed: "In der Hühene 28"
UPDATE `schools` SET `address1` = CONVERT(X'496E206465722048C3BC68656E65203238' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26986 AND CAST(`address1` AS BINARY) = X'496E206465722048C383C2BC68656E65203238';

-- Entry 638: school id 26992, column `address1`, deleted=no
-- School (as reported): "A Brighter Child Montessori of Ramstein"
-- Original: "BuchholzstraÃŸe 53"
-- Proposed: "Buchholzstraße 53"
UPDATE `schools` SET `address1` = CONVERT(X'42756368686F6C7A73747261C39F65203533' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26992 AND CAST(`address1` AS BINARY) = X'42756368686F6C7A73747261C383C5B865203533';

-- Entry 639: school id 26992, column `city`, deleted=no
-- School (as reported): "A Brighter Child Montessori of Ramstein"
-- Original: "BruchmÃ¼hlbach-Miesau"
-- Proposed: "Bruchmühlbach-Miesau"
UPDATE `schools` SET `city` = CONVERT(X'42727563686DC3BC686C626163682D4D6965736175' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26992 AND CAST(`city` AS BINARY) = X'42727563686DC383C2BC686C626163682D4D6965736175';

-- Entry 640: school id 26993, column `address1`, deleted=no
-- School (as reported): "International Montessori School- Barabara House"
-- Original: "SpissenagelstraÃŸe 23"
-- Proposed: "Spissenagelstraße 23"
UPDATE `schools` SET `address1` = CONVERT(X'5370697373656E6167656C73747261C39F65203233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26993 AND CAST(`address1` AS BINARY) = X'5370697373656E6167656C73747261C383C5B865203233';

-- Entry 641: school id 26994, column `address1`, deleted=no
-- School (as reported): "Freie Montessori Schule Worms"
-- Original: "BrÃ¼ckenstraÃŸe 2"
-- Proposed: "Brückenstraße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4272C3BC636B656E73747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26994 AND CAST(`address1` AS BINARY) = X'4272C383C2BC636B656E73747261C383C5B8652032';

-- Entry 642: school id 26995, column `address1`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule (Jahrgangsstufen 5 â€“ 7)"
-- Original: "LindenstraÃŸe 140"
-- Proposed: "Lindenstraße 140"
UPDATE `schools` SET `address1` = CONVERT(X'4C696E64656E73747261C39F6520313430' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26995 AND CAST(`address1` AS BINARY) = X'4C696E64656E73747261C383C5B86520313430';

-- Entry 643: school id 26995, column `city`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule (Jahrgangsstufen 5 â€“ 7)"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26995 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 644: school id 26995, column `schoolname`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule (Jahrgangsstufen 5 â€“ 7)"
-- Original: "Maria-Montessori-Gesamtschule (Jahrgangsstufen 5 â€“ 7)"
-- Proposed: "Maria-Montessori-Gesamtschule (Jahrgangsstufen 5 – 7)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D617269612D4D6F6E746573736F72692D476573616D74736368756C6520284A61687267616E677373747566656E203520E28093203729' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26995 AND CAST(`schoolname` AS BINARY) = X'4D617269612D4D6F6E746573736F72692D476573616D74736368756C6520284A61687267616E677373747566656E203520C3A2E282ACE2809C203729';

-- Entry 645: school id 26996, column `address1`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule ( Jahrgangsstufen 8 â€“ 12)"
-- Original: "RosmarinstraÃŸe 28"
-- Proposed: "Rosmarinstraße 28"
UPDATE `schools` SET `address1` = CONVERT(X'526F736D6172696E73747261C39F65203238' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26996 AND CAST(`address1` AS BINARY) = X'526F736D6172696E73747261C383C5B865203238';

-- Entry 646: school id 26996, column `city`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule ( Jahrgangsstufen 8 â€“ 12)"
-- Original: "DÃ¼sseldorf"
-- Proposed: "Düsseldorf"
UPDATE `schools` SET `city` = CONVERT(X'44C3BC7373656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26996 AND CAST(`city` AS BINARY) = X'44C383C2BC7373656C646F7266';

-- Entry 647: school id 26996, column `schoolname`, deleted=no
-- School (as reported): "Maria-Montessori-Gesamtschule ( Jahrgangsstufen 8 â€“ 12)"
-- Original: "Maria-Montessori-Gesamtschule ( Jahrgangsstufen 8 â€“ 12)"
-- Proposed: "Maria-Montessori-Gesamtschule ( Jahrgangsstufen 8 – 12)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D617269612D4D6F6E746573736F72692D476573616D74736368756C652028204A61687267616E677373747566656E203820E2809320313229' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26996 AND CAST(`schoolname` AS BINARY) = X'4D617269612D4D6F6E746573736F72692D476573616D74736368756C652028204A61687267616E677373747566656E203820C3A2E282ACE2809C20313229';

-- Entry 648: school id 26997, column `address1`, deleted=no
-- School (as reported): "StÃ¤dtische Maria-Montessori-Gesamtschule Meerbusch"
-- Original: "WeiÃŸenberger Weg 8 â€“ 12"
-- Proposed: "Weißenberger Weg 8 – 12"
UPDATE `schools` SET `address1` = CONVERT(X'576569C39F656E62657267657220576567203820E28093203132' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26997 AND CAST(`address1` AS BINARY) = X'576569C383C5B8656E62657267657220576567203820C3A2E282ACE2809C203132';

-- Entry 649: school id 26997, column `schoolname`, deleted=no
-- School (as reported): "StÃ¤dtische Maria-Montessori-Gesamtschule Meerbusch"
-- Original: "StÃ¤dtische Maria-Montessori-Gesamtschule Meerbusch"
-- Proposed: "Städtische Maria-Montessori-Gesamtschule Meerbusch"
UPDATE `schools` SET `schoolname` = CONVERT(X'5374C3A464746973636865204D617269612D4D6F6E746573736F72692D476573616D74736368756C65204D6565726275736368' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26997 AND CAST(`schoolname` AS BINARY) = X'5374C383C2A464746973636865204D617269612D4D6F6E746573736F72692D476573616D74736368756C65204D6565726275736368';

-- Entry 650: school id 26998, column `address1`, deleted=no
-- School (as reported): "Anna-Schmidt-Schule"
-- Original: "GÃ¤rtnerweg 29"
-- Proposed: "Gärtnerweg 29"
UPDATE `schools` SET `address1` = CONVERT(X'47C3A472746E6572776567203239' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26998 AND CAST(`address1` AS BINARY) = X'47C383C2A472746E6572776567203239';

-- Entry 651: school id 26998, column `headofschoolname`, deleted=no
-- School (as reported): "Anna-Schmidt-Schule"
-- Original: "Petra KÃ¶nig"
-- Proposed: "Petra König"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'5065747261204BC3B66E6967' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26998 AND CAST(`headofschoolname` AS BINARY) = X'5065747261204BC383C2B66E6967';

-- Entry 652: school id 26999, column `city`, deleted=no
-- School (as reported): "Maria Montessori Schule Am Pistorhof"
-- Original: "KÃ¶ln"
-- Proposed: "Köln"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B66C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 26999 AND CAST(`city` AS BINARY) = X'4BC383C2B66C6E';

-- Entry 653: school id 27000, column `city`, deleted=no
-- School (as reported): "Montessori Grundschule- KÃ¶ln"
-- Original: "KÃ¶ln"
-- Proposed: "Köln"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B66C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27000 AND CAST(`city` AS BINARY) = X'4BC383C2B66C6E';

-- Entry 654: school id 27000, column `schoolname`, deleted=no
-- School (as reported): "Montessori Grundschule- KÃ¶ln"
-- Original: "Montessori Grundschule- KÃ¶ln"
-- Proposed: "Montessori Grundschule- Köln"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204772756E64736368756C652D204BC3B66C6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27000 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204772756E64736368756C652D204BC383C2B66C6E';

-- Entry 655: school id 27001, column `address1`, deleted=no
-- School (as reported): "Montessori Campus Berlin KÃ¶penick"
-- Original: "KÃ¶penzeile 125"
-- Proposed: "Köpenzeile 125"
UPDATE `schools` SET `address1` = CONVERT(X'4BC3B670656E7A65696C6520313235' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27001 AND CAST(`address1` AS BINARY) = X'4BC383C2B670656E7A65696C6520313235';

-- Entry 656: school id 27001, column `schoolname`, deleted=no
-- School (as reported): "Montessori Campus Berlin KÃ¶penick"
-- Original: "Montessori Campus Berlin KÃ¶penick"
-- Proposed: "Montessori Campus Berlin Köpenick"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692043616D707573204265726C696E204BC3B670656E69636B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27001 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692043616D707573204265726C696E204BC383C2B670656E69636B';

-- Entry 657: school id 27002, column `address1`, deleted=no
-- School (as reported): "Montessori-Schule EichstÃ¤tt"
-- Original: "Kardinal-SchrÃ¶ffer-StraÃŸe 5"
-- Proposed: "Kardinal-Schröffer-Straße 5"
UPDATE `schools` SET `address1` = CONVERT(X'4B617264696E616C2D53636872C3B6666665722D53747261C39F652035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27002 AND CAST(`address1` AS BINARY) = X'4B617264696E616C2D53636872C383C2B6666665722D53747261C383C5B8652035';

-- Entry 658: school id 27002, column `city`, deleted=no
-- School (as reported): "Montessori-Schule EichstÃ¤tt"
-- Original: "EichstÃ¤tt"
-- Proposed: "Eichstätt"
UPDATE `schools` SET `city` = CONVERT(X'456963687374C3A47474' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27002 AND CAST(`city` AS BINARY) = X'456963687374C383C2A47474';

-- Entry 659: school id 27002, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Schule EichstÃ¤tt"
-- Original: "Montessori-Schule EichstÃ¤tt"
-- Proposed: "Montessori-Schule Eichstätt"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D536368756C6520456963687374C3A47474' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27002 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D536368756C6520456963687374C383C2A47474';

-- Entry 660: school id 27004, column `address1`, deleted=no
-- School (as reported): "monaddrei- Montessori Kinderhaus & Schule"
-- Original: "SchÃ¤ferkampsallee 27"
-- Proposed: "Schäferkampsallee 27"
UPDATE `schools` SET `address1` = CONVERT(X'536368C3A46665726B616D7073616C6C6565203237' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27004 AND CAST(`address1` AS BINARY) = X'536368C383C2A46665726B616D7073616C6C6565203237';

-- Entry 661: school id 27005, column `address1`, deleted=yes
-- School (as reported): "Montessori-PÃ¤dagogik in Ulm und Neu-Ulm"
-- Original: "BaumgartenstraÃŸe 7"
-- Proposed: "Baumgartenstraße 7"
UPDATE `schools` SET `address1` = CONVERT(X'4261756D67617274656E73747261C39F652037' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27005 AND CAST(`address1` AS BINARY) = X'4261756D67617274656E73747261C383C5B8652037';

-- Entry 662: school id 27005, column `schoolname`, deleted=yes
-- School (as reported): "Montessori-PÃ¤dagogik in Ulm und Neu-Ulm"
-- Original: "Montessori-PÃ¤dagogik in Ulm und Neu-Ulm"
-- Proposed: "Montessori-Pädagogik in Ulm und Neu-Ulm"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D50C3A46461676F67696B20696E20556C6D20756E64204E65752D556C6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27005 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D50C383C2A46461676F67696B20696E20556C6D20756E64204E65752D556C6D';

-- Entry 663: school id 27006, column `address1`, deleted=yes
-- School (as reported): "Montessori-Kinderhaus am Eselsberg in Ulm"
-- Original: "CartesiusstraÃŸe 6"
-- Proposed: "Cartesiusstraße 6"
UPDATE `schools` SET `address1` = CONVERT(X'43617274657369757373747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27006 AND CAST(`address1` AS BINARY) = X'43617274657369757373747261C383C5B8652036';

-- Entry 664: school id 27007, column `address1`, deleted=no
-- School (as reported): "BischÃ¶fliches Maria-Montessori-Schulzentrum Leipzig"
-- Original: "Alte SalzstraÃŸe 61 & 65"
-- Proposed: "Alte Salzstraße 61 & 65"
UPDATE `schools` SET `address1` = CONVERT(X'416C74652053616C7A73747261C39F652036312026203635' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27007 AND CAST(`address1` AS BINARY) = X'416C74652053616C7A73747261C383C5B8652036312026203635';

-- Entry 665: school id 27007, column `schoolname`, deleted=no
-- School (as reported): "BischÃ¶fliches Maria-Montessori-Schulzentrum Leipzig"
-- Original: "BischÃ¶fliches Maria-Montessori-Schulzentrum Leipzig"
-- Proposed: "Bischöfliches Maria-Montessori-Schulzentrum Leipzig"
UPDATE `schools` SET `schoolname` = CONVERT(X'4269736368C3B6666C6963686573204D617269612D4D6F6E746573736F72692D536368756C7A656E7472756D204C6569707A6967' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27007 AND CAST(`schoolname` AS BINARY) = X'4269736368C383C2B6666C6963686573204D617269612D4D6F6E746573736F72692D536368756C7A656E7472756D204C6569707A6967';

-- Entry 666: school id 27008, column `address1`, deleted=no
-- School (as reported): "Kinderhaus Friedenau- Montessori & Friends"
-- Original: "HandjerystraÃŸe 46"
-- Proposed: "Handjerystraße 46"
UPDATE `schools` SET `address1` = CONVERT(X'48616E646A65727973747261C39F65203436' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27008 AND CAST(`address1` AS BINARY) = X'48616E646A65727973747261C383C5B865203436';

-- Entry 667: school id 27009, column `address1`, deleted=no
-- School (as reported): "Maria Montessori-Schule Freiburg"
-- Original: "GÃ¼nterstalstraÃŸe 72"
-- Proposed: "Günterstalstraße 72"
UPDATE `schools` SET `address1` = CONVERT(X'47C3BC6E7465727374616C73747261C39F65203732' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27009 AND CAST(`address1` AS BINARY) = X'47C383C2BC6E7465727374616C73747261C383C5B865203732';

-- Entry 668: school id 27011, column `address1`, deleted=no
-- School (as reported): "Montessorischule Jena â€“ Staatliche Gemeinschaftsschule"
-- Original: "Friedrich-Wolf-StraÃŸe 2"
-- Proposed: "Friedrich-Wolf-Straße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4672696564726963682D576F6C662D53747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27011 AND CAST(`address1` AS BINARY) = X'4672696564726963682D576F6C662D53747261C383C5B8652032';

-- Entry 669: school id 27011, column `schoolname`, deleted=no
-- School (as reported): "Montessorischule Jena â€“ Staatliche Gemeinschaftsschule"
-- Original: "Montessorischule Jena â€“ Staatliche Gemeinschaftsschule"
-- Proposed: "Montessorischule Jena – Staatliche Gemeinschaftsschule"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269736368756C65204A656E6120E280932053746161746C696368652047656D65696E73636861667473736368756C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27011 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269736368756C65204A656E6120C3A2E282ACE2809C2053746161746C696368652047656D65696E73636861667473736368756C65';

-- Entry 670: school id 27013, column `schoolname`, deleted=no
-- School (as reported): "Private Montessori-Schule des Montessori FÃ¶rderkreises Rothenburg o.d.T.e.V. in Neusitz- Sekundarstufe"
-- Original: "Private Montessori-Schule des Montessori FÃ¶rderkreises Rothenburg o.d.T.e.V. in Neusitz- Sekundarstufe"
-- Proposed: "Private Montessori-Schule des Montessori Förderkreises Rothenburg o.d.T.e.V. in Neusitz- Sekundarstufe"
UPDATE `schools` SET `schoolname` = CONVERT(X'50726976617465204D6F6E746573736F72692D536368756C6520646573204D6F6E746573736F72692046C3B6726465726B72656973657320526F7468656E62757267206F2E642E542E652E562E20696E204E65757369747A2D2053656B756E6461727374756665' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27013 AND CAST(`schoolname` AS BINARY) = X'50726976617465204D6F6E746573736F72692D536368756C6520646573204D6F6E746573736F72692046C383C2B6726465726B72656973657320526F7468656E62757267206F2E642E542E652E562E20696E204E65757369747A2D2053656B756E6461727374756665';

-- Entry 671: school id 27014, column `address1`, deleted=no
-- School (as reported): "Montessori FÃ¶rderkreis Nuremberg eV"
-- Original: "Dr.-Carlo-Schmid-StraÃŸe 130"
-- Proposed: "Dr.-Carlo-Schmid-Straße 130"
UPDATE `schools` SET `address1` = CONVERT(X'44722E2D4361726C6F2D5363686D69642D53747261C39F6520313330' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27014 AND CAST(`address1` AS BINARY) = X'44722E2D4361726C6F2D5363686D69642D53747261C383C5B86520313330';

-- Entry 672: school id 27014, column `city`, deleted=no
-- School (as reported): "Montessori FÃ¶rderkreis Nuremberg eV"
-- Original: "NÃ¼rnberg"
-- Proposed: "Nürnberg"
UPDATE `schools` SET `city` = CONVERT(X'4EC3BC726E62657267' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27014 AND CAST(`city` AS BINARY) = X'4EC383C2BC726E62657267';

-- Entry 673: school id 27014, column `schoolname`, deleted=no
-- School (as reported): "Montessori FÃ¶rderkreis Nuremberg eV"
-- Original: "Montessori FÃ¶rderkreis Nuremberg eV"
-- Proposed: "Montessori Förderkreis Nuremberg eV"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692046C3B6726465726B72656973204E7572656D62657267206556' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27014 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692046C383C2B6726465726B72656973204E7572656D62657267206556';

-- Entry 674: school id 27015, column `address1`, deleted=no
-- School (as reported): "Montessori Campus am Tegeler Forst"
-- Original: "GabrielenstraÃŸe 12-18"
-- Proposed: "Gabrielenstraße 12-18"
UPDATE `schools` SET `address1` = CONVERT(X'4761627269656C656E73747261C39F652031322D3138' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27015 AND CAST(`address1` AS BINARY) = X'4761627269656C656E73747261C383C5B8652031322D3138';

-- Entry 675: school id 27017, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus"
-- Original: "GÃ¼nther-Simon-Str. 4"
-- Proposed: "Günther-Simon-Str. 4"
UPDATE `schools` SET `address1` = CONVERT(X'47C3BC6E746865722D53696D6F6E2D5374722E2034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27017 AND CAST(`address1` AS BINARY) = X'47C383C2BC6E746865722D53696D6F6E2D5374722E2034';

-- Entry 676: school id 27018, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus an der Elbe e.V."
-- Original: "JenischstraÃŸe 48"
-- Proposed: "Jenischstraße 48"
UPDATE `schools` SET `address1` = CONVERT(X'4A656E6973636873747261C39F65203438' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27018 AND CAST(`address1` AS BINARY) = X'4A656E6973636873747261C383C5B865203438';

-- Entry 677: school id 27019, column `headofschoolname`, deleted=no
-- School (as reported): "Evangelisches Montessori-Schulhaus Freiburg- Gemeinschaftsschule"
-- Original: "Klaus-Dieter SchÃ¶fer-Bea"
-- Proposed: "Klaus-Dieter Schöfer-Bea"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4B6C6175732D44696574657220536368C3B66665722D426561' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27019 AND CAST(`headofschoolname` AS BINARY) = X'4B6C6175732D44696574657220536368C383C2B66665722D426561';

-- Entry 678: school id 27020, column `address1`, deleted=no
-- School (as reported): "Montessori-Schule Geisenhausen bei Landshut"
-- Original: "MartinstraÃŸe 3,"
-- Proposed: "Martinstraße 3,"
UPDATE `schools` SET `address1` = CONVERT(X'4D617274696E73747261C39F6520332C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27020 AND CAST(`address1` AS BINARY) = X'4D617274696E73747261C383C5B86520332C';

-- Entry 679: school id 27021, column `address1`, deleted=no
-- School (as reported): "Montessori-Fachoberschule Wertingen"
-- Original: "Zusmarshauser StraÃŸe 19a"
-- Proposed: "Zusmarshauser Straße 19a"
UPDATE `schools` SET `address1` = CONVERT(X'5A75736D6172736861757365722053747261C39F6520313961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27021 AND CAST(`address1` AS BINARY) = X'5A75736D6172736861757365722053747261C383C5B86520313961';

-- Entry 680: school id 27022, column `city`, deleted=no
-- School (as reported): "Montessori-Kinderhaus FÃ¼rstenfeldbruck"
-- Original: "FÃ¼rstenfeldbruck"
-- Proposed: "Fürstenfeldbruck"
UPDATE `schools` SET `city` = CONVERT(X'46C3BC727374656E66656C64627275636B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27022 AND CAST(`city` AS BINARY) = X'46C383C2BC727374656E66656C64627275636B';

-- Entry 681: school id 27022, column `schoolname`, deleted=no
-- School (as reported): "Montessori-Kinderhaus FÃ¼rstenfeldbruck"
-- Original: "Montessori-Kinderhaus FÃ¼rstenfeldbruck"
-- Proposed: "Montessori-Kinderhaus Fürstenfeldbruck"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D4B696E646572686175732046C3BC727374656E66656C64627275636B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27022 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D4B696E646572686175732046C383C2BC727374656E66656C64627275636B';

-- Entry 682: school id 27024, column `address1`, deleted=no
-- School (as reported): "Montessori- Schule PeiÃŸenberg- Montessori Kinderhaus"
-- Original: "Am Ã–ferl 23"
-- Proposed: "Am Öferl 23"
UPDATE `schools` SET `address1` = CONVERT(X'416D20C3966665726C203233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27024 AND CAST(`address1` AS BINARY) = X'416D20C383E280936665726C203233';

-- Entry 683: school id 27024, column `schoolname`, deleted=no
-- School (as reported): "Montessori- Schule PeiÃŸenberg- Montessori Kinderhaus"
-- Original: "Montessori- Schule PeiÃŸenberg- Montessori Kinderhaus"
-- Proposed: "Montessori- Schule Peißenberg- Montessori Kinderhaus"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D20536368756C6520506569C39F656E626572672D204D6F6E746573736F7269204B696E64657268617573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27024 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D20536368756C6520506569C383C5B8656E626572672D204D6F6E746573736F7269204B696E64657268617573';

-- Entry 684: school id 27025, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kindergarten AllgÃ¤u"
-- Original: "Montessori Kindergarten AllgÃ¤u"
-- Proposed: "Montessori Kindergarten Allgäu"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E64657267617274656E20416C6C67C3A475' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27025 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E64657267617274656E20416C6C67C383C2A475';

-- Entry 685: school id 27026, column `address1`, deleted=no
-- School (as reported): "Montessori Inning am Ammersee- Montessori-Kinderhaus"
-- Original: "Landsberger StraÃŸe 2"
-- Proposed: "Landsberger Straße 2"
UPDATE `schools` SET `address1` = CONVERT(X'4C616E64736265726765722053747261C39F652032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27026 AND CAST(`address1` AS BINARY) = X'4C616E64736265726765722053747261C383C5B8652032';

-- Entry 686: school id 27027, column `city`, deleted=no
-- School (as reported): "Montessori Verein KÃ¶sching e.V.- Montessori Kinderkrippe KÃ¶sching"
-- Original: "KÃ¶sching"
-- Proposed: "Kösching"
UPDATE `schools` SET `city` = CONVERT(X'4BC3B6736368696E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27027 AND CAST(`city` AS BINARY) = X'4BC383C2B6736368696E67';

-- Entry 687: school id 27027, column `schoolname`, deleted=no
-- School (as reported): "Montessori Verein KÃ¶sching e.V.- Montessori Kinderkrippe KÃ¶sching"
-- Original: "Montessori Verein KÃ¶sching e.V.- Montessori Kinderkrippe KÃ¶sching"
-- Proposed: "Montessori Verein Kösching e.V.- Montessori Kinderkrippe Kösching"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692056657265696E204BC3B6736368696E6720652E562E2D204D6F6E746573736F7269204B696E6465726B7269707065204BC3B6736368696E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27027 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692056657265696E204BC383C2B6736368696E6720652E562E2D204D6F6E746573736F7269204B696E6465726B7269707065204BC383C2B6736368696E67';

-- Entry 688: school id 27028, column `address1`, deleted=no
-- School (as reported): "Montessori Nord gGmbH"
-- Original: "GlockengieÃŸerstr. 9a"
-- Proposed: "Glockengießerstr. 9a"
UPDATE `schools` SET `address1` = CONVERT(X'476C6F636B656E676965C39F65727374722E203961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27028 AND CAST(`address1` AS BINARY) = X'476C6F636B656E676965C383C5B865727374722E203961';

-- Entry 689: school id 27028, column `city`, deleted=no
-- School (as reported): "Montessori Nord gGmbH"
-- Original: "LÃ¼beck"
-- Proposed: "Lübeck"
UPDATE `schools` SET `city` = CONVERT(X'4CC3BC6265636B' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27028 AND CAST(`city` AS BINARY) = X'4CC383C2BC6265636B';

-- Entry 690: school id 27028, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori Nord gGmbH"
-- Original: "Andreas HagenkÃ¶tter"
-- Proposed: "Andreas Hagenkötter"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'416E647265617320486167656E6BC3B674746572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27028 AND CAST(`headofschoolname` AS BINARY) = X'416E647265617320486167656E6BC383C2B674746572';

-- Entry 691: school id 27029, column `address1`, deleted=no
-- School (as reported): "Montessori Dorsten- Montessori Reform School"
-- Original: "DÃ¼lmener Strasse 40"
-- Proposed: "Dülmener Strasse 40"
UPDATE `schools` SET `address1` = CONVERT(X'44C3BC6C6D656E65722053747261737365203430' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27029 AND CAST(`address1` AS BINARY) = X'44C383C2BC6C6D656E65722053747261737365203430';

-- Entry 692: school id 27031, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Dinkelscherban- Montessori Campus (Stufe 7-10)"
-- Original: "St.-Stephan-StraÃŸe 4-6"
-- Proposed: "St.-Stephan-Straße 4-6"
UPDATE `schools` SET `address1` = CONVERT(X'53742E2D5374657068616E2D53747261C39F6520342D36' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27031 AND CAST(`address1` AS BINARY) = X'53742E2D5374657068616E2D53747261C383C5B86520342D36';

-- Entry 693: school id 27032, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Dinkelscherban (Stufe 1-6)"
-- Original: "Dr.-Franz-Grabowski-StraÃŸe 6"
-- Proposed: "Dr.-Franz-Grabowski-Straße 6"
UPDATE `schools` SET `address1` = CONVERT(X'44722E2D4672616E7A2D477261626F77736B692D53747261C39F652036' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27032 AND CAST(`address1` AS BINARY) = X'44722E2D4672616E7A2D477261626F77736B692D53747261C383C5B8652036';

-- Entry 694: school id 27033, column `address1`, deleted=no
-- School (as reported): "Montessori Schule Biberkor"
-- Original: "BiberkorstraÃŸe 19-23"
-- Proposed: "Biberkorstraße 19-23"
UPDATE `schools` SET `address1` = CONVERT(X'42696265726B6F7273747261C39F652031392D3233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27033 AND CAST(`address1` AS BINARY) = X'42696265726B6F7273747261C383C5B8652031392D3233';

-- Entry 695: school id 27034, column `address1`, deleted=no
-- School (as reported): "Freie Montessori Schule Landau- Kinderhaus"
-- Original: "Luise-Harteneck-StraÃŸe 13"
-- Proposed: "Luise-Harteneck-Straße 13"
UPDATE `schools` SET `address1` = CONVERT(X'4C756973652D48617274656E65636B2D53747261C39F65203133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27034 AND CAST(`address1` AS BINARY) = X'4C756973652D48617274656E65636B2D53747261C383C5B865203133';

-- Entry 696: school id 27037, column `schoolname`, deleted=no
-- School (as reported): "Musisch-aktiver Montessori-Kindergarten Bad TÃ¶lz "
-- Original: "Musisch-aktiver Montessori-Kindergarten Bad TÃ¶lz "
-- Decoded (before cleanup): "Musisch-aktiver Montessori-Kindergarten Bad Tölz "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Musisch-aktiver Montessori-Kindergarten Bad Tölz"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D7573697363682D616B7469766572204D6F6E746573736F72692D4B696E64657267617274656E204261642054C3B66C7A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27037 AND CAST(`schoolname` AS BINARY) = X'4D7573697363682D616B7469766572204D6F6E746573736F72692D4B696E64657267617274656E204261642054C383C2B66C7A20';

-- Entry 697: school id 27040, column `address1`, deleted=no
-- School (as reported): "Ev. Montessori Oberschule Plauen"
-- Original: "Anton-Kraus-StraÃŸe 18"
-- Proposed: "Anton-Kraus-Straße 18"
UPDATE `schools` SET `address1` = CONVERT(X'416E746F6E2D4B726175732D53747261C39F65203138' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27040 AND CAST(`address1` AS BINARY) = X'416E746F6E2D4B726175732D53747261C383C5B865203138';

-- Entry 698: school id 27047, column `address1`, deleted=no
-- School (as reported): "Am Sternenwinkel â€“ Maxvorstadt"
-- Original: "TheresienstraÃŸe 71b"
-- Proposed: "Theresienstraße 71b"
UPDATE `schools` SET `address1` = CONVERT(X'54686572657369656E73747261C39F6520373162' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27047 AND CAST(`address1` AS BINARY) = X'54686572657369656E73747261C383C5B86520373162';

-- Entry 699: school id 27047, column `schoolname`, deleted=no
-- School (as reported): "Am Sternenwinkel â€“ Maxvorstadt"
-- Original: "Am Sternenwinkel â€“ Maxvorstadt"
-- Proposed: "Am Sternenwinkel – Maxvorstadt"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D20537465726E656E77696E6B656C20E28093204D6178766F727374616474' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27047 AND CAST(`schoolname` AS BINARY) = X'416D20537465726E656E77696E6B656C20C3A2E282ACE2809C204D6178766F727374616474';

-- Entry 700: school id 27232, column `address1`, deleted=no
-- School (as reported): "Giardino Montessori"
-- Original: "Calle Durango No. 2613, Col. Cacho Tijuana, Baja California MÃ©xico C.P. 22040"
-- Proposed: "Calle Durango No. 2613, Col. Cacho Tijuana, Baja California México C.P. 22040"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520447572616E676F204E6F2E20323631332C20436F6C2E20436163686F2054696A75616E612C2042616A612043616C69666F726E6961204DC3A97869636F20432E502E203232303430' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27232 AND CAST(`address1` AS BINARY) = X'43616C6C6520447572616E676F204E6F2E20323631332C20436F6C2E20436163686F2054696A75616E612C2042616A612043616C69666F726E6961204DC383C2A97869636F20432E502E203232303430';

-- Entry 701: school id 27237, column `address1`, deleted=no
-- School (as reported): "Colegio Ekiraya Montessori"
-- Original: "Km. 7 vÃ­a La Calera, 300 mts despuÃ©s del peaje de Patios"
-- Proposed: "Km. 7 vía La Calera, 300 mts después del peaje de Patios"
UPDATE `schools` SET `address1` = CONVERT(X'4B6D2E20372076C3AD61204C612043616C6572612C20333030206D7473206465737075C3A9732064656C207065616A6520646520506174696F73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27237 AND CAST(`address1` AS BINARY) = X'4B6D2E20372076C383C2AD61204C612043616C6572612C20333030206D7473206465737075C383C2A9732064656C207065616A6520646520506174696F73';

-- Entry 702: school id 27240, column `address1`, deleted=no
-- School (as reported): "Colegio LatinoAmericano Bilingue"
-- Original: "RepÃºblica de Brasil #305"
-- Proposed: "República de Brasil #305"
UPDATE `schools` SET `address1` = CONVERT(X'526570C3BA626C6963612064652042726173696C2023333035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27240 AND CAST(`address1` AS BINARY) = X'526570C383C2BA626C6963612064652042726173696C2023333035';

-- Entry 703: school id 27250, column `address1`, deleted=no
-- School (as reported): "Liceo Montessori Bilingual School"
-- Original: "Calle 54 Diag. 28B - 28 UrbanizaciÃ³n las Mercedes"
-- Proposed: "Calle 54 Diag. 28B - 28 Urbanización las Mercedes"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520353420446961672E20323842202D20323820557262616E697A616369C3B36E206C6173204D65726365646573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27250 AND CAST(`address1` AS BINARY) = X'43616C6C6520353420446961672E20323842202D20323820557262616E697A616369C383C2B36E206C6173204D65726365646573';

-- Entry 704: school id 27258, column `address1`, deleted=yes
-- School (as reported): "Colegio Maria Montessori"
-- Original: "BenjamÃ­n Franklin No. 164 Col. EscandÃ³n"
-- Proposed: "Benjamín Franklin No. 164 Col. Escandón"
UPDATE `schools` SET `address1` = CONVERT(X'42656E6A616DC3AD6E204672616E6B6C696E204E6F2E2031363420436F6C2E20457363616E64C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27258 AND CAST(`address1` AS BINARY) = X'42656E6A616DC383C2AD6E204672616E6B6C696E204E6F2E2031363420436F6C2E20457363616E64C383C2B36E';

-- Entry 705: school id 27258, column `address2`, deleted=yes
-- School (as reported): "Colegio Maria Montessori"
-- Original: "JosÃ© MartÃ­ No. 240 Col. EscandÃ³n, "
-- Decoded (before cleanup): "José Martí No. 240 Col. Escandón, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "José Martí No. 240 Col. Escandón,"
UPDATE `schools` SET `address2` = CONVERT(X'4A6F73C3A9204D617274C3AD204E6F2E2032343020436F6C2E20457363616E64C3B36E2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27258 AND CAST(`address2` AS BINARY) = X'4A6F73C383C2A9204D617274C383C2AD204E6F2E2032343020436F6C2E20457363616E64C383C2B36E2C20';

-- Entry 706: school id 27259, column `accreditations`, deleted=yes
-- School (as reported): "Madrid Montessori"
-- Original: "MSA (Middle States Association), CEXTRAN (Colegio privado extranjero en EspaÃ±a)"
-- Proposed: "MSA (Middle States Association), CEXTRAN (Colegio privado extranjero en España)"
UPDATE `schools` SET `accreditations` = CONVERT(X'4D534120284D6964646C6520537461746573204173736F63696174696F6E292C204345585452414E2028436F6C6567696F207072697661646F2065787472616E6A65726F20656E2045737061C3B16129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27259 AND CAST(`accreditations` AS BINARY) = X'4D534120284D6964646C6520537461746573204173736F63696174696F6E292C204345585452414E2028436F6C6567696F207072697661646F2065787472616E6A65726F20656E2045737061C383C2B16129';

-- Entry 707: school id 27259, column `affiliations`, deleted=yes
-- School (as reported): "Madrid Montessori"
-- Original: "AMI (Association Montessori Internationale), AME (AsociaciÃ³n Montessori EspaÃ±a)"
-- Proposed: "AMI (Association Montessori Internationale), AME (Asociación Montessori España)"
UPDATE `schools` SET `affiliations` = CONVERT(X'414D4920284173736F63696174696F6E204D6F6E746573736F726920496E7465726E6174696F6E616C65292C20414D45202841736F6369616369C3B36E204D6F6E746573736F72692045737061C3B16129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27259 AND CAST(`affiliations` AS BINARY) = X'414D4920284173736F63696174696F6E204D6F6E746573736F726920496E7465726E6174696F6E616C65292C20414D45202841736F6369616369C383C2B36E204D6F6E746573736F72692045737061C383C2B16129';

-- Entry 708: school id 27259, column `contactname`, deleted=yes
-- School (as reported): "Madrid Montessori"
-- Original: "AINHOA MARTÃN-CHICO"
-- Proposed: "AINHOA MARTÍN-CHICO"
UPDATE `schools` SET `contactname` = CONVERT(X'41494E484F41204D415254C38D4E2D434849434F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27259 AND CAST(`contactname` AS BINARY) = X'41494E484F41204D415254C383C28D4E2D434849434F';

-- Entry 709: school id 27270, column `address1`, deleted=yes
-- School (as reported): "Mi Jardin Montessori"
-- Original: "Av 5 C Sur 1, PanamÃ¡, Panama"
-- Proposed: "Av 5 C Sur 1, Panamá, Panama"
UPDATE `schools` SET `address1` = CONVERT(X'4176203520432053757220312C2050616E616DC3A12C2050616E616D61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27270 AND CAST(`address1` AS BINARY) = X'4176203520432053757220312C2050616E616DC383C2A12C2050616E616D61';

-- Entry 710: school id 27272, column `address1`, deleted=yes
-- School (as reported): "SRL Olivos Montessori School"
-- Original: "Salta 2821 (y calle R. Saenz PeÃ±a) Olivos (1636) Buenos Aires - Argentina"
-- Proposed: "Salta 2821 (y calle R. Saenz Peña) Olivos (1636) Buenos Aires - Argentina"
UPDATE `schools` SET `address1` = CONVERT(X'53616C746120323832312028792063616C6C6520522E205361656E7A205065C3B16129204F6C69766F7320283136333629204275656E6F73204169726573202D20417267656E74696E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27272 AND CAST(`address1` AS BINARY) = X'53616C746120323832312028792063616C6C6520522E205361656E7A205065C383C2B16129204F6C69766F7320283136333629204275656E6F73204169726573202D20417267656E74696E61';

-- Entry 711: school id 27281, column `address1`, deleted=no
-- School (as reported): "Liceo Montessori de La Paz"
-- Original: "Ignacio RamÃ­rez 3510 esquina Oaxaca"
-- Proposed: "Ignacio Ramírez 3510 esquina Oaxaca"
UPDATE `schools` SET `address1` = CONVERT(X'49676E6163696F2052616DC3AD72657A20333531302065737175696E61204F6178616361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27281 AND CAST(`address1` AS BINARY) = X'49676E6163696F2052616DC383C2AD72657A20333531302065737175696E61204F6178616361';

-- Entry 712: school id 27283, column `address1`, deleted=no
-- School (as reported): "CEIP Maria Montesori"
-- Original: "Avd. de los Arenales s/nÂº"
-- Proposed: "Avd. de los Arenales s/nº"
UPDATE `schools` SET `address1` = CONVERT(X'4176642E206465206C6F73204172656E616C657320732F6EC2BA' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27283 AND CAST(`address1` AS BINARY) = X'4176642E206465206C6F73204172656E616C657320732F6EC382C2BA';

-- Entry 713: school id 27284, column `city`, deleted=no
-- School (as reported): "Centro Internacional Maria Montessori"
-- Original: "BailÃ©n-Miraflores"
-- Proposed: "Bailén-Miraflores"
UPDATE `schools` SET `city` = CONVERT(X'4261696CC3A96E2D4D697261666C6F726573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27284 AND CAST(`city` AS BINARY) = X'4261696CC383C2A96E2D4D697261666C6F726573';

-- Entry 714: school id 27284, column `stateprovince`, deleted=no
-- School (as reported): "Centro Internacional Maria Montessori"
-- Original: "MÃ¡laga"
-- Proposed: "Málaga"
UPDATE `schools` SET `stateprovince` = CONVERT(X'4DC3A16C616761' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27284 AND CAST(`stateprovince` AS BINARY) = X'4DC383C2A16C616761';

-- Entry 715: school id 27308, column `address1`, deleted=yes
-- School (as reported): "Montessori Learning Center"
-- Original: "Lomas de Ayarco, Curridabat Del Restaurante DoÃ±a Lela 800m sur 75m este."
-- Proposed: "Lomas de Ayarco, Curridabat Del Restaurante Doña Lela 800m sur 75m este."
UPDATE `schools` SET `address1` = CONVERT(X'4C6F6D61732064652041796172636F2C20437572726964616261742044656C2052657374617572616E746520446FC3B161204C656C61203830306D207375722037356D20657374652E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27308 AND CAST(`address1` AS BINARY) = X'4C6F6D61732064652041796172636F2C20437572726964616261742044656C2052657374617572616E746520446FC383C2B161204C656C61203830306D207375722037356D20657374652E';

-- Entry 716: school id 27327, column `address1`, deleted=yes
-- School (as reported): "Montessori School Almeria "
-- Original: "C/Nueva AlmerÃ­a nÂº27 AlmerÃ­a"
-- Proposed: "C/Nueva Almería nº27 Almería"
UPDATE `schools` SET `address1` = CONVERT(X'432F4E7565766120416C6D6572C3AD61206EC2BA323720416C6D6572C3AD61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27327 AND CAST(`address1` AS BINARY) = X'432F4E7565766120416C6D6572C383C2AD61206EC382C2BA323720416C6D6572C383C2AD61';

-- Entry 717: school id 27331, column `address1`, deleted=no
-- School (as reported): "ABC Montessori Kinder & Daycare"
-- Original: "Av. 21, Barrio Los Maderos, LimÃ³n, GuÃ¡piles, Costa Rica"
-- Proposed: "Av. 21, Barrio Los Maderos, Limón, Guápiles, Costa Rica"
UPDATE `schools` SET `address1` = CONVERT(X'41762E2032312C2042617272696F204C6F73204D616465726F732C204C696DC3B36E2C204775C3A170696C65732C20436F7374612052696361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27331 AND CAST(`address1` AS BINARY) = X'41762E2032312C2042617272696F204C6F73204D616465726F732C204C696DC383C2B36E2C204775C383C2A170696C65732C20436F7374612052696361';

-- Entry 718: school id 27334, column `address1`, deleted=yes
-- School (as reported): "Treehouse Montessori"
-- Original: "Calle Los Gatos, San JosÃ©, San Rafael, Costa Rica"
-- Proposed: "Calle Los Gatos, San José, San Rafael, Costa Rica"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204C6F73204761746F732C2053616E204A6F73C3A92C2053616E2052616661656C2C20436F7374612052696361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27334 AND CAST(`address1` AS BINARY) = X'43616C6C65204C6F73204761746F732C2053616E204A6F73C383C2A92C2053616E2052616661656C2C20436F7374612052696361';

-- Entry 719: school id 27336, column `address1`, deleted=no
-- School (as reported): "Barcelona Montessori School"
-- Original: "Carrer de l'EsperanÃ§a, 13"
-- Proposed: "Carrer de l'Esperança, 13"
UPDATE `schools` SET `address1` = CONVERT(X'436172726572206465206C274573706572616EC3A7612C203133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27336 AND CAST(`address1` AS BINARY) = X'436172726572206465206C274573706572616EC383C2A7612C203133';

-- Entry 720: school id 27338, column `address1`, deleted=no
-- School (as reported): "Casa de Nino Uvita Montessori "
-- Original: "BahÃ­a, Puntarenas Province"
-- Proposed: "Bahía, Puntarenas Province"
UPDATE `schools` SET `address1` = CONVERT(X'426168C3AD612C2050756E746172656E61732050726F76696E6365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27338 AND CAST(`address1` AS BINARY) = X'426168C383C2AD612C2050756E746172656E61732050726F76696E6365';

-- Entry 721: school id 27340, column `address1`, deleted=no
-- School (as reported): "Prodigy Kids Academy Montessori"
-- Original: "Trejos Montealegre, San JosÃ© Province, San Rafael de EscazÃº, Costa Rica"
-- Proposed: "Trejos Montealegre, San José Province, San Rafael de Escazú, Costa Rica"
UPDATE `schools` SET `address1` = CONVERT(X'5472656A6F73204D6F6E7465616C656772652C2053616E204A6F73C3A92050726F76696E63652C2053616E2052616661656C20646520457363617AC3BA2C20436F7374612052696361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27340 AND CAST(`address1` AS BINARY) = X'5472656A6F73204D6F6E7465616C656772652C2053616E204A6F73C383C2A92050726F76696E63652C2053616E2052616661656C20646520457363617AC383C2BA2C20436F7374612052696361';

-- Entry 722: school id 27358, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori Montevideo"
-- Original: "Av. MillÃ¡n 4613"
-- Proposed: "Av. Millán 4613"
UPDATE `schools` SET `address1` = CONVERT(X'41762E204D696C6CC3A16E2034363133' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27358 AND CAST(`address1` AS BINARY) = X'41762E204D696C6CC383C2A16E2034363133';

-- Entry 723: school id 27361, column `address1`, deleted=no
-- School (as reported): "Colegio Karmel Montessori"
-- Original: "980, CÃ³rdoba"
-- Proposed: "980, Córdoba"
UPDATE `schools` SET `address1` = CONVERT(X'3938302C2043C3B372646F6261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27361 AND CAST(`address1` AS BINARY) = X'3938302C2043C383C2B372646F6261';

-- Entry 724: school id 27367, column `city`, deleted=no
-- School (as reported): "Montessori Delta School"
-- Original: "Dique LujÃ¡n"
-- Proposed: "Dique Luján"
UPDATE `schools` SET `city` = CONVERT(X'4469717565204C756AC3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27367 AND CAST(`city` AS BINARY) = X'4469717565204C756AC383C2A16E';

-- Entry 725: school id 27368, column `address1`, deleted=no
-- School (as reported): "Saint Paul Montessori School"
-- Original: "AlcÃ¡ntara 464"
-- Proposed: "Alcántara 464"
UPDATE `schools` SET `address1` = CONVERT(X'416C63C3A16E7461726120343634' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27368 AND CAST(`address1` AS BINARY) = X'416C63C383C2A16E7461726120343634';

-- Entry 726: school id 27369, column `address1`, deleted=yes
-- School (as reported): "Colegio Huelquen Montessori"
-- Original: "El Rodeo 13798, Santiago, Lo Barnechea, RegiÃ³n Metropolitana, Chile"
-- Proposed: "El Rodeo 13798, Santiago, Lo Barnechea, Región Metropolitana, Chile"
UPDATE `schools` SET `address1` = CONVERT(X'456C20526F64656F2031333739382C2053616E746961676F2C204C6F204261726E65636865612C2052656769C3B36E204D6574726F706F6C6974616E612C204368696C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27369 AND CAST(`address1` AS BINARY) = X'456C20526F64656F2031333739382C2053616E746961676F2C204C6F204261726E65636865612C2052656769C383C2B36E204D6574726F706F6C6974616E612C204368696C65';

-- Entry 727: school id 27372, column `schoolname`, deleted=no
-- School (as reported): "Unidad Educativa Montessori Estrellas del MaÃ±ana"
-- Original: "Unidad Educativa Montessori Estrellas del MaÃ±ana"
-- Proposed: "Unidad Educativa Montessori Estrellas del Mañana"
UPDATE `schools` SET `schoolname` = CONVERT(X'556E6964616420456475636174697661204D6F6E746573736F72692045737472656C6C61732064656C204D61C3B1616E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27372 AND CAST(`schoolname` AS BINARY) = X'556E6964616420456475636174697661204D6F6E746573736F72692045737472656C6C61732064656C204D61C383C2B1616E61';

-- Entry 728: school id 27375, column `address1`, deleted=no
-- School (as reported): "Centro Educativo Montessori Gonzaga"
-- Original: "C. Alberto AchÃ¡ entre c. Cidar Humerez y c. Luis MontaÃ±o Milan"
-- Proposed: "C. Alberto Achá entre c. Cidar Humerez y c. Luis Montaño Milan"
UPDATE `schools` SET `address1` = CONVERT(X'432E20416C626572746F20416368C3A120656E74726520632E2043696461722048756D6572657A207920632E204C756973204D6F6E7461C3B16F204D696C616E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27375 AND CAST(`address1` AS BINARY) = X'432E20416C626572746F20416368C383C2A120656E74726520632E2043696461722048756D6572657A207920632E204C756973204D6F6E7461C383C2B16F204D696C616E';

-- Entry 729: school id 27379, column `address1`, deleted=no
-- School (as reported): "Villa Montessori School"
-- Original: "Sector 3 Grupo 14 Mz C Lte. 1 ,  2 y 24 â€“ Villa el Salvador"
-- Proposed: "Sector 3 Grupo 14 Mz C Lte. 1 ,  2 y 24 – Villa el Salvador"
UPDATE `schools` SET `address1` = CONVERT(X'536563746F72203320477275706F203134204D7A2043204C74652E2031202C202032207920323420E280932056696C6C6120656C2053616C7661646F72' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27379 AND CAST(`address1` AS BINARY) = X'536563746F72203320477275706F203134204D7A2043204C74652E2031202C202032207920323420C3A2E282ACE2809C2056696C6C6120656C2053616C7661646F72';

-- Entry 730: school id 27380, column `address1`, deleted=no
-- School (as reported): "Maria Montessori School of Jose Galvez"
-- Original: "Lima 35, JirÃ³n MaraÃ±Ã³n 159, JosÃ© GÃ¡lvez, Villa MarÃ­a del Triunfo, Lima, Peru"
-- Proposed: "Lima 35, Jirón Marañón 159, José Gálvez, Villa María del Triunfo, Lima, Peru"
UPDATE `schools` SET `address1` = CONVERT(X'4C696D612033352C204A6972C3B36E204D617261C3B1C3B36E203135392C204A6F73C3A92047C3A16C76657A2C2056696C6C61204D6172C3AD612064656C20547269756E666F2C204C696D612C2050657275' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27380 AND CAST(`address1` AS BINARY) = X'4C696D612033352C204A6972C383C2B36E204D617261C383C2B1C383C2B36E203135392C204A6F73C383C2A92047C383C2A16C76657A2C2056696C6C61204D6172C383C2AD612064656C20547269756E666F2C204C696D612C2050657275';

-- Entry 731: school id 27382, column `address1`, deleted=no
-- School (as reported): "Maria Montessori School"
-- Original: "Av. Los Tallanes NÂº 20, Urb. San Eduardo â€“ Piura."
-- Proposed: "Av. Los Tallanes Nº 20, Urb. San Eduardo – Piura."
UPDATE `schools` SET `address1` = CONVERT(X'41762E204C6F732054616C6C616E6573204EC2BA2032302C205572622E2053616E204564756172646F20E280932050697572612E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27382 AND CAST(`address1` AS BINARY) = X'41762E204C6F732054616C6C616E6573204EC382C2BA2032302C205572622E2053616E204564756172646F20C3A2E282ACE2809C2050697572612E';

-- Entry 732: school id 27383, column `address1`, deleted=no
-- School (as reported): "Baby School Montessori"
-- Original: "HipÃ³lito Bouchard 1580"
-- Proposed: "Hipólito Bouchard 1580"
UPDATE `schools` SET `address1` = CONVERT(X'486970C3B36C69746F20426F7563686172642031353830' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27383 AND CAST(`address1` AS BINARY) = X'486970C383C2B36C69746F20426F7563686172642031353830';

-- Entry 733: school id 27383, column `zippostal`, deleted=no
-- School (as reported): "Baby School Montessori"
-- Original: "B1846 AdroguÃ©"
-- Proposed: "B1846 Adrogué"
UPDATE `schools` SET `zippostal` = CONVERT(X'4231383436204164726F6775C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27383 AND CAST(`zippostal` AS BINARY) = X'4231383436204164726F6775C383C2A9';

-- Entry 734: school id 27384, column `address1`, deleted=yes
-- School (as reported): "Colegio Montessori Funes"
-- Original: " RodrÃ­guez 6117 (4,436.29 mi) , 2132"
-- Decoded (before cleanup): " Rodríguez 6117 (4,436.29 mi) , 2132"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Rodríguez 6117 (4,436.29 mi) , 2132"
UPDATE `schools` SET `address1` = CONVERT(X'526F6472C3AD6775657A20363131372028342C3433362E3239206D6929202C2032313332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27384 AND CAST(`address1` AS BINARY) = X'20526F6472C383C2AD6775657A20363131372028342C3433362E3239206D6929202C2032313332';

-- Entry 735: school id 27385, column `address1`, deleted=no
-- School (as reported): "Jardin de Infantes & Maternal Maria Montessori"
-- Original: "BolÃ­var 6263"
-- Proposed: "Bolívar 6263"
UPDATE `schools` SET `address1` = CONVERT(X'426F6CC3AD7661722036323633' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27385 AND CAST(`address1` AS BINARY) = X'426F6CC383C2AD7661722036323633';

-- Entry 736: school id 27386, column `address1`, deleted=yes
-- School (as reported): "Pedagojia Montessori"
-- Original: " Caseros 794 timbre 2 (4,485.67 mi) RÃ­o Cuarto, CÃ³rdoba, 5800"
-- Decoded (before cleanup): " Caseros 794 timbre 2 (4,485.67 mi) Río Cuarto, Córdoba, 5800"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Caseros 794 timbre 2 (4,485.67 mi) Río Cuarto, Córdoba, 5800"
UPDATE `schools` SET `address1` = CONVERT(X'43617365726F73203739342074696D62726520322028342C3438352E3637206D69292052C3AD6F2043756172746F2C2043C3B372646F62612C2035383030' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27386 AND CAST(`address1` AS BINARY) = X'2043617365726F73203739342074696D62726520322028342C3438352E3637206D69292052C383C2AD6F2043756172746F2C2043C383C2B372646F62612C2035383030';

-- Entry 737: school id 27388, column `address1`, deleted=yes
-- School (as reported): "Barrie Montessori"
-- Original: "Barrie Montessori school - Alvaro Casanova 701, Penalolen, PeÃ±alolÃ©n, RegiÃ³n Metropolitana, Chile"
-- Proposed: "Barrie Montessori school - Alvaro Casanova 701, Penalolen, Peñalolén, Región Metropolitana, Chile"
UPDATE `schools` SET `address1` = CONVERT(X'426172726965204D6F6E746573736F7269207363686F6F6C202D20416C7661726F20436173616E6F7661203730312C2050656E616C6F6C656E2C205065C3B1616C6F6CC3A96E2C2052656769C3B36E204D6574726F706F6C6974616E612C204368696C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27388 AND CAST(`address1` AS BINARY) = X'426172726965204D6F6E746573736F7269207363686F6F6C202D20416C7661726F20436173616E6F7661203730312C2050656E616C6F6C656E2C205065C383C2B1616C6F6CC383C2A96E2C2052656769C383C2B36E204D6574726F706F6C6974616E612C204368696C65';

-- Entry 738: school id 27389, column `address2`, deleted=no
-- School (as reported): "Highlands Montessori School"
-- Original: "PeÃ±alolÃ©n,"
-- Proposed: "Peñalolén,"
UPDATE `schools` SET `address2` = CONVERT(X'5065C3B1616C6F6CC3A96E2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27389 AND CAST(`address2` AS BINARY) = X'5065C383C2B1616C6F6CC383C2A96E2C';

-- Entry 739: school id 27389, column `city`, deleted=no
-- School (as reported): "Highlands Montessori School"
-- Original: "RegiÃ³n Metropolitana,"
-- Proposed: "Región Metropolitana,"
UPDATE `schools` SET `city` = CONVERT(X'52656769C3B36E204D6574726F706F6C6974616E612C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27389 AND CAST(`city` AS BINARY) = X'52656769C383C2B36E204D6574726F706F6C6974616E612C';

-- Entry 740: school id 27391, column `address1`, deleted=no
-- School (as reported): "Colegio Anida Montessori"
-- Original: "calle Palena NÂ° 2956"
-- Proposed: "calle Palena N° 2956"
UPDATE `schools` SET `address1` = CONVERT(X'63616C6C652050616C656E61204EC2B02032393536' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27391 AND CAST(`address1` AS BINARY) = X'63616C6C652050616C656E61204EC382C2B02032393536';

-- Entry 741: school id 27392, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori de Valparaiso"
-- Original: "Av. Hospital Dr. Guillermo MÃ¼nnich 733 "
-- Decoded (before cleanup): "Av. Hospital Dr. Guillermo Münnich 733 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Av. Hospital Dr. Guillermo Münnich 733"
UPDATE `schools` SET `address1` = CONVERT(X'41762E20486F73706974616C2044722E204775696C6C65726D6F204DC3BC6E6E69636820373333' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27392 AND CAST(`address1` AS BINARY) = X'41762E20486F73706974616C2044722E204775696C6C65726D6F204DC383C2BC6E6E6963682037333320';

-- Entry 742: school id 27396, column `address1`, deleted=no
-- School (as reported): "Colegio Montessori Antillal"
-- Original: "Av. BerlÃ­n, Parcela 15, PeÃ±aflor, RM"
-- Proposed: "Av. Berlín, Parcela 15, Peñaflor, RM"
UPDATE `schools` SET `address1` = CONVERT(X'41762E204265726CC3AD6E2C2050617263656C612031352C205065C3B161666C6F722C20524D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27396 AND CAST(`address1` AS BINARY) = X'41762E204265726CC383C2AD6E2C2050617263656C612031352C205065C383C2B161666C6F722C20524D';

-- Entry 743: school id 27397, column `address1`, deleted=yes
-- School (as reported): "Andes Montessori"
-- Original: "Las Rosas 70, San Pedro de la Paz.  RegiÃ³n del BiobÃ­o."
-- Proposed: "Las Rosas 70, San Pedro de la Paz.  Región del Biobío."
UPDATE `schools` SET `address1` = CONVERT(X'4C617320526F7361732037302C2053616E20506564726F206465206C612050617A2E202052656769C3B36E2064656C2042696F62C3AD6F2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27397 AND CAST(`address1` AS BINARY) = X'4C617320526F7361732037302C2053616E20506564726F206465206C612050617A2E202052656769C383C2B36E2064656C2042696F62C383C2AD6F2E';

-- Entry 744: school id 27401, column `address1`, deleted=no
-- School (as reported): "Colegio Montessori Calama"
-- Original: "Aconcagua NÂ° 3009"
-- Proposed: "Aconcagua N° 3009"
UPDATE `schools` SET `address1` = CONVERT(X'41636F6E6361677561204EC2B02033303039' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27401 AND CAST(`address1` AS BINARY) = X'41636F6E6361677561204EC382C2B02033303039';

-- Entry 745: school id 27403, column `headofschoolname`, deleted=no
-- School (as reported): "Colegio Montessori Newen Mapu"
-- Original: "HernÃ¡n Lemus"
-- Proposed: "Hernán Lemus"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4865726EC3A16E204C656D7573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27403 AND CAST(`headofschoolname` AS BINARY) = X'4865726EC383C2A16E204C656D7573';

-- Entry 746: school id 27404, column `address1`, deleted=yes
-- School (as reported): "Colegio Terraustral Montessori"
-- Original: "Ruta O-60 s/n - Fundo BelÃ©n - Comuna de Hualqui"
-- Proposed: "Ruta O-60 s/n - Fundo Belén - Comuna de Hualqui"
UPDATE `schools` SET `address1` = CONVERT(X'52757461204F2D363020732F6E202D2046756E646F2042656CC3A96E202D20436F6D756E61206465204875616C717569' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27404 AND CAST(`address1` AS BINARY) = X'52757461204F2D363020732F6E202D2046756E646F2042656CC383C2A96E202D20436F6D756E61206465204875616C717569';

-- Entry 747: school id 27406, column `address1`, deleted=yes
-- School (as reported): "Casa Montessori Peru"
-- Original: "Jr. SatÃ©lite NÂ° 288 - Urb Santa Elizabeth, 1ra Etapa San Juan de Lurigancho, Peru"
-- Proposed: "Jr. Satélite N° 288 - Urb Santa Elizabeth, 1ra Etapa San Juan de Lurigancho, Peru"
UPDATE `schools` SET `address1` = CONVERT(X'4A722E20536174C3A96C697465204EC2B020323838202D205572622053616E746120456C697A61626574682C203172612045746170612053616E204A75616E206465204C75726967616E63686F2C2050657275' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27406 AND CAST(`address1` AS BINARY) = X'4A722E20536174C383C2A96C697465204EC382C2B020323838202D205572622053616E746120456C697A61626574682C203172612045746170612053616E204A75616E206465204C75726967616E63686F2C2050657275';

-- Entry 748: school id 27410, column `address1`, deleted=yes
-- School (as reported): "Montessori Unidad Educativa"
-- Original: "Urdesa Central Calle Tercera numero 426, entre DÃ¡tiles y avenida Las Monjas.  Guayaquil - Ecuador"
-- Proposed: "Urdesa Central Calle Tercera numero 426, entre Dátiles y avenida Las Monjas.  Guayaquil - Ecuador"
UPDATE `schools` SET `address1` = CONVERT(X'5572646573612043656E7472616C2043616C6C652054657263657261206E756D65726F203432362C20656E7472652044C3A174696C65732079206176656E696461204C6173204D6F6E6A61732E202047756179617175696C202D2045637561646F72' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27410 AND CAST(`address1` AS BINARY) = X'5572646573612043656E7472616C2043616C6C652054657263657261206E756D65726F203432362C20656E7472652044C383C2A174696C65732079206176656E696461204C6173204D6F6E6A61732E202047756179617175696C202D2045637561646F72';

-- Entry 749: school id 27411, column `address1`, deleted=no
-- School (as reported): "Montessori La Mana"
-- Original: "Montessori Escuela de EducaciÃ³n BÃ¡sica"
-- Proposed: "Montessori Escuela de Educación Básica"
UPDATE `schools` SET `address1` = CONVERT(X'4D6F6E746573736F72692045736375656C612064652045647563616369C3B36E2042C3A173696361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27411 AND CAST(`address1` AS BINARY) = X'4D6F6E746573736F72692045736375656C612064652045647563616369C383C2B36E2042C383C2A173696361';

-- Entry 750: school id 27412, column `address1`, deleted=no
-- School (as reported): "Unidad Educativa Despertar"
-- Original: "JosÃ© Plaza E1-97 y Gonzalo Pizarro"
-- Proposed: "José Plaza E1-97 y Gonzalo Pizarro"
UPDATE `schools` SET `address1` = CONVERT(X'4A6F73C3A920506C617A612045312D3937207920476F6E7A616C6F2050697A6172726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27412 AND CAST(`address1` AS BINARY) = X'4A6F73C383C2A920506C617A612045312D3937207920476F6E7A616C6F2050697A6172726F';

-- Entry 751: school id 27413, column `address1`, deleted=no
-- School (as reported): "Escuea Maria Montessori"
-- Original: "Modesto ChÃ¡vez Franco 1933 entre TulcÃ¡n y Los RÃ­os. "
-- Decoded (before cleanup): "Modesto Chávez Franco 1933 entre Tulcán y Los Ríos. "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Modesto Chávez Franco 1933 entre Tulcán y Los Ríos."
UPDATE `schools` SET `address1` = CONVERT(X'4D6F646573746F204368C3A176657A204672616E636F203139333320656E7472652054756C63C3A16E2079204C6F732052C3AD6F732E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27413 AND CAST(`address1` AS BINARY) = X'4D6F646573746F204368C383C2A176657A204672616E636F203139333320656E7472652054756C63C383C2A16E2079204C6F732052C383C2AD6F732E20';

-- Entry 752: school id 27415, column `address1`, deleted=no
-- School (as reported): "Granja Escuela Montessori Cayambe"
-- Original: "Panamerica Sur - San Luis de GuachalÃ¡ Km 5 y Pasaje S/N. Barrio El Vicundo"
-- Proposed: "Panamerica Sur - San Luis de Guachalá Km 5 y Pasaje S/N. Barrio El Vicundo"
UPDATE `schools` SET `address1` = CONVERT(X'50616E616D657269636120537572202D2053616E204C756973206465204775616368616CC3A1204B6D2035207920506173616A6520532F4E2E2042617272696F20456C20566963756E646F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27415 AND CAST(`address1` AS BINARY) = X'50616E616D657269636120537572202D2053616E204C756973206465204775616368616CC383C2A1204B6D2035207920506173616A6520532F4E2E2042617272696F20456C20566963756E646F';

-- Entry 753: school id 27416, column `address1`, deleted=no
-- School (as reported): "Jardin Infantil Serderito Montessori"
-- Original: "DarÃ­o UrzÃºa 1523 "
-- Decoded (before cleanup): "Darío Urzúa 1523 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Darío Urzúa 1523"
UPDATE `schools` SET `address1` = CONVERT(X'446172C3AD6F2055727AC3BA612031353233' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27416 AND CAST(`address1` AS BINARY) = X'446172C383C2AD6F2055727AC383C2BA61203135323320';

-- Entry 754: school id 27416, column `headofschoolname`, deleted=no
-- School (as reported): "Jardin Infantil Serderito Montessori"
-- Original: "Marcela SÃ¡ez CatalÃ¡n"
-- Proposed: "Marcela Sáez Catalán"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D617263656C612053C3A1657A20436174616CC3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27416 AND CAST(`headofschoolname` AS BINARY) = X'4D617263656C612053C383C2A1657A20436174616CC383C2A16E';

-- Entry 755: school id 27417, column `schoolname`, deleted=no
-- School (as reported): "Ayekan Jardin Infantil Montessori- PeÃ±alolÃ©n"
-- Original: "Ayekan Jardin Infantil Montessori- PeÃ±alolÃ©n"
-- Proposed: "Ayekan Jardin Infantil Montessori- Peñalolén"
UPDATE `schools` SET `schoolname` = CONVERT(X'4179656B616E204A617264696E20496E66616E74696C204D6F6E746573736F72692D205065C3B1616C6F6CC3A96E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27417 AND CAST(`schoolname` AS BINARY) = X'4179656B616E204A617264696E20496E66616E74696C204D6F6E746573736F72692D205065C383C2B1616C6F6CC383C2A96E';

-- Entry 756: school id 27421, column `city`, deleted=no
-- School (as reported): "TremÃ¼n Montessori Macul"
-- Original: "Macul, RegiÃ³n Metropolitana"
-- Proposed: "Macul, Región Metropolitana"
UPDATE `schools` SET `city` = CONVERT(X'4D6163756C2C2052656769C3B36E204D6574726F706F6C6974616E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27421 AND CAST(`city` AS BINARY) = X'4D6163756C2C2052656769C383C2B36E204D6574726F706F6C6974616E61';

-- Entry 757: school id 27421, column `schoolname`, deleted=no
-- School (as reported): "TremÃ¼n Montessori Macul"
-- Original: "TremÃ¼n Montessori Macul"
-- Proposed: "Tremün Montessori Macul"
UPDATE `schools` SET `schoolname` = CONVERT(X'5472656DC3BC6E204D6F6E746573736F7269204D6163756C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27421 AND CAST(`schoolname` AS BINARY) = X'5472656DC383C2BC6E204D6F6E746573736F7269204D6163756C';

-- Entry 758: school id 27422, column `address1`, deleted=yes
-- School (as reported): "Meli Montessori"
-- Original: "Fernando de AragÃ³n 4251 Las Condes"
-- Proposed: "Fernando de Aragón 4251 Las Condes"
UPDATE `schools` SET `address1` = CONVERT(X'4665726E616E646F2064652041726167C3B36E2034323531204C617320436F6E646573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27422 AND CAST(`address1` AS BINARY) = X'4665726E616E646F2064652041726167C383C2B36E2034323531204C617320436F6E646573';

-- Entry 759: school id 27428, column `address1`, deleted=no
-- School (as reported): "Little House School"
-- Original: "Calle PeÃ±uelas 59, "
-- Decoded (before cleanup): "Calle Peñuelas 59, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calle Peñuelas 59,"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65205065C3B175656C61732035392C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27428 AND CAST(`address1` AS BINARY) = X'43616C6C65205065C383C2B175656C61732035392C20';

-- Entry 760: school id 27447, column `address1`, deleted=yes
-- School (as reported): "Barrie Montessori"
-- Original: "PrÃ­ncipe de Gales 6450, La Reina, RegiÃ³n Metropolitana, Chile"
-- Proposed: "Príncipe de Gales 6450, La Reina, Región Metropolitana, Chile"
UPDATE `schools` SET `address1` = CONVERT(X'5072C3AD6E636970652064652047616C657320363435302C204C61205265696E612C2052656769C3B36E204D6574726F706F6C6974616E612C204368696C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27447 AND CAST(`address1` AS BINARY) = X'5072C383C2AD6E636970652064652047616C657320363435302C204C61205265696E612C2052656769C383C2B36E204D6574726F706F6C6974616E612C204368696C65';

-- Entry 761: school id 27449, column `address1`, deleted=no
-- School (as reported): "Montessori Rayhue Vitacura"
-- Original: "Carmen FariÃ±a #6532"
-- Proposed: "Carmen Fariña #6532"
UPDATE `schools` SET `address1` = CONVERT(X'4361726D656E2046617269C3B161202336353332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27449 AND CAST(`address1` AS BINARY) = X'4361726D656E2046617269C383C2B161202336353332';

-- Entry 762: school id 27452, column `address1`, deleted=no
-- School (as reported): "Montessori Lafquen"
-- Original: "EgaÃ±a 538 "
-- Decoded (before cleanup): "Egaña 538 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Egaña 538"
UPDATE `schools` SET `address1` = CONVERT(X'456761C3B16120353338' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27452 AND CAST(`address1` AS BINARY) = X'456761C383C2B1612035333820';

-- Entry 763: school id 27459, column `address1`, deleted=no
-- School (as reported): "Colegio S. Maria Montessori"
-- Original: "Calle Carlos Basadre #351, Urb. IngenierÃ­a (2,778.41 mi) San MartÃ­n de Porres, Peru, 31"
-- Proposed: "Calle Carlos Basadre #351, Urb. Ingeniería (2,778.41 mi) San Martín de Porres, Peru, 31"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204361726C6F73204261736164726520233335312C205572622E20496E67656E696572C3AD612028322C3737382E3431206D69292053616E204D617274C3AD6E20646520506F727265732C20506572752C203331' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27459 AND CAST(`address1` AS BINARY) = X'43616C6C65204361726C6F73204261736164726520233335312C205572622E20496E67656E696572C383C2AD612028322C3737382E3431206D69292053616E204D617274C383C2AD6E20646520506F727265732C20506572752C203331';

-- Entry 764: school id 27460, column `address1`, deleted=no
-- School (as reported): "Colegio Maria Montessori Pisco"
-- Original: "Lotz. Nueva JerusalÃ©n (2,902.51 mi) Pisco, Peru,"
-- Proposed: "Lotz. Nueva Jerusalén (2,902.51 mi) Pisco, Peru,"
UPDATE `schools` SET `address1` = CONVERT(X'4C6F747A2E204E75657661204A65727573616CC3A96E2028322C3930322E3531206D692920506973636F2C20506572752C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27460 AND CAST(`address1` AS BINARY) = X'4C6F747A2E204E75657661204A65727573616CC383C2A96E2028322C3930322E3531206D692920506973636F2C20506572752C';

-- Entry 765: school id 27485, column `address1`, deleted=yes
-- School (as reported): "Maria Montessori School Choluteca"
-- Original: "MARIA MONTESSORI SCHOOL, Anillo PerifÃ©rico, Choluteca, Honduras"
-- Proposed: "MARIA MONTESSORI SCHOOL, Anillo Periférico, Choluteca, Honduras"
UPDATE `schools` SET `address1` = CONVERT(X'4D41524941204D4F4E544553534F5249205343484F4F4C2C20416E696C6C6F205065726966C3A97269636F2C2043686F6C75746563612C20486F6E6475726173' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27485 AND CAST(`address1` AS BINARY) = X'4D41524941204D4F4E544553534F5249205343484F4F4C2C20416E696C6C6F205065726966C383C2A97269636F2C2043686F6C75746563612C20486F6E6475726173';

-- Entry 766: school id 27487, column `address1`, deleted=yes
-- School (as reported): "Colegio Montessori de Guatemala"
-- Original: "Âª. Avenida 3-55 zona 10, Ciudad de Guatemala"
-- Proposed: "ª. Avenida 3-55 zona 10, Ciudad de Guatemala"
UPDATE `schools` SET `address1` = CONVERT(X'C2AA2E204176656E69646120332D3535207A6F6E612031302C204369756461642064652047756174656D616C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27487 AND CAST(`address1` AS BINARY) = X'C382C2AA2E204176656E69646120332D3535207A6F6E612031302C204369756461642064652047756174656D616C61';

-- Entry 767: school id 27489, column `address1`, deleted=no
-- School (as reported): "Montessori Cordoba International School"
-- Original: "Calle SansueÃ±a 66, "
-- Decoded (before cleanup): "Calle Sansueña 66, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calle Sansueña 66,"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C652053616E737565C3B1612036362C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27489 AND CAST(`address1` AS BINARY) = X'43616C6C652053616E737565C383C2B1612036362C20';

-- Entry 768: school id 27495, column `address1`, deleted=no
-- School (as reported): "Centro Educativo Infantil Montessori"
-- Original: "16a. Avenida 16-47 Colonia Las Brisas Barrio Hacienda la Virgen SalamÃ¡ Baja Verapaz"
-- Proposed: "16a. Avenida 16-47 Colonia Las Brisas Barrio Hacienda la Virgen Salamá Baja Verapaz"
UPDATE `schools` SET `address1` = CONVERT(X'3136612E204176656E6964612031362D343720436F6C6F6E6961204C6173204272697361732042617272696F2048616369656E6461206C612056697267656E2053616C616DC3A12042616A61205665726170617A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27495 AND CAST(`address1` AS BINARY) = X'3136612E204176656E6964612031362D343720436F6C6F6E6961204C6173204272697361732042617272696F2048616369656E6461206C612056697267656E2053616C616DC383C2A12042616A61205665726170617A';

-- Entry 769: school id 27503, column `address1`, deleted=no
-- School (as reported): "Domani Montessori"
-- Original: "San Lorenzo #174 Col. Del Valle AlcaldÃ­a Benito JuÃ¡rez"
-- Proposed: "San Lorenzo #174 Col. Del Valle Alcaldía Benito Juárez"
UPDATE `schools` SET `address1` = CONVERT(X'53616E204C6F72656E7A6F202331373420436F6C2E2044656C2056616C6C6520416C63616C64C3AD612042656E69746F204A75C3A172657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27503 AND CAST(`address1` AS BINARY) = X'53616E204C6F72656E7A6F202331373420436F6C2E2044656C2056616C6C6520416C63616C64C383C2AD612042656E69746F204A75C383C2A172657A';

-- Entry 770: school id 27507, column `address1`, deleted=no
-- School (as reported): "Colegio Montessori Arboledas"
-- Original: "Blvd. RamÃ³n G. Bonfil No. 3000 "
-- Decoded (before cleanup): "Blvd. Ramón G. Bonfil No. 3000 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Blvd. Ramón G. Bonfil No. 3000"
UPDATE `schools` SET `address1` = CONVERT(X'426C76642E2052616DC3B36E20472E20426F6E66696C204E6F2E2033303030' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27507 AND CAST(`address1` AS BINARY) = X'426C76642E2052616DC383C2B36E20472E20426F6E66696C204E6F2E203330303020';

-- Entry 771: school id 27509, column `address1`, deleted=yes
-- School (as reported): "Oaks Leadership School"
-- Original: "SECCIÃ“N PREESCOLAR  Av. Secretaria de Marina No. 510 Lomas del Chamizal 4ta. SecciÃ³n Ciudad de MÃ©xico."
-- Proposed: "SECCIÓN PREESCOLAR  Av. Secretaria de Marina No. 510 Lomas del Chamizal 4ta. Sección Ciudad de México."
UPDATE `schools` SET `address1` = CONVERT(X'5345434349C3934E205052454553434F4C4152202041762E2053656372657461726961206465204D6172696E61204E6F2E20353130204C6F6D61732064656C204368616D697A616C203474612E205365636369C3B36E20436975646164206465204DC3A97869636F2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27509 AND CAST(`address1` AS BINARY) = X'5345434349C383E2809C4E205052454553434F4C4152202041762E2053656372657461726961206465204D6172696E61204E6F2E20353130204C6F6D61732064656C204368616D697A616C203474612E205365636369C383C2B36E20436975646164206465204DC383C2A97869636F2E';

-- Entry 772: school id 27511, column `address1`, deleted=no
-- School (as reported): "Montessori Baby's House "
-- Original: "GuanÃ¡bana 331"
-- Proposed: "Guanábana 331"
UPDATE `schools` SET `address1` = CONVERT(X'4775616EC3A162616E6120333331' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27511 AND CAST(`address1` AS BINARY) = X'4775616EC383C2A162616E6120333331';

-- Entry 773: school id 27512, column `address1`, deleted=yes
-- School (as reported): "Propuesta Educativa MM"
-- Original: "Propuesta Educativa MarÃ­a Montessori, Carr. Mezcales - San Vicente # 249, ICA, Mexico, Nayarit, 63735, MÃ©xico"
-- Proposed: "Propuesta Educativa María Montessori, Carr. Mezcales - San Vicente # 249, ICA, Mexico, Nayarit, 63735, México"
UPDATE `schools` SET `address1` = CONVERT(X'50726F70756573746120456475636174697661204D6172C3AD61204D6F6E746573736F72692C20436172722E204D657A63616C6573202D2053616E20566963656E74652023203234392C204943412C204D657869636F2C204E6179617269742C2036333733352C204DC3A97869636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27512 AND CAST(`address1` AS BINARY) = X'50726F70756573746120456475636174697661204D6172C383C2AD61204D6F6E746573736F72692C20436172722E204D657A63616C6573202D2053616E20566963656E74652023203234392C204943412C204D657869636F2C204E6179617269742C2036333733352C204DC383C2A97869636F';

-- Entry 774: school id 27513, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori de Puerto Vallarta"
-- Original: "Calle MarÃ­a Montessori 220 "
-- Decoded (before cleanup): "Calle María Montessori 220 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calle María Montessori 220"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204D6172C3AD61204D6F6E746573736F726920323230' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27513 AND CAST(`address1` AS BINARY) = X'43616C6C65204D6172C383C2AD61204D6F6E746573736F72692032323020';

-- Entry 775: school id 27516, column `address1`, deleted=no
-- School (as reported): "Colegio Comunidad Montessori"
-- Original: "Calle CuliacÃ¡n No.86"
-- Proposed: "Calle Culiacán No.86"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C652043756C696163C3A16E204E6F2E3836' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27516 AND CAST(`address1` AS BINARY) = X'43616C6C652043756C696163C383C2A16E204E6F2E3836';

-- Entry 776: school id 27523, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori de la Ciudad de Mexico A.C."
-- Original: "Sierra FrÃ­a 355, Lomas de Chapultepec"
-- Proposed: "Sierra Fría 355, Lomas de Chapultepec"
UPDATE `schools` SET `address1` = CONVERT(X'536965727261204672C3AD61203335352C204C6F6D61732064652043686170756C7465706563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27523 AND CAST(`address1` AS BINARY) = X'536965727261204672C383C2AD61203335352C204C6F6D61732064652043686170756C7465706563';

-- Entry 777: school id 27526, column `address1`, deleted=no
-- School (as reported): "Instituto Stoppani de Mexico"
-- Original: "Calle 13 entre 28 y 30 NÃºmero ,"
-- Proposed: "Calle 13 entre 28 y 30 Número ,"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C6520313320656E7472652032382079203330204EC3BA6D65726F202C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27526 AND CAST(`address1` AS BINARY) = X'43616C6C6520313320656E7472652032382079203330204EC383C2BA6D65726F202C';

-- Entry 778: school id 27526, column `address2`, deleted=no
-- School (as reported): "Instituto Stoppani de Mexico"
-- Original: "129 Col. MÃ©xico,  YucatÃ¡n"
-- Proposed: "129 Col. México,  Yucatán"
UPDATE `schools` SET `address2` = CONVERT(X'31323920436F6C2E204DC3A97869636F2C20205975636174C3A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27526 AND CAST(`address2` AS BINARY) = X'31323920436F6C2E204DC383C2A97869636F2C20205975636174C383C2A16E';

-- Entry 779: school id 27528, column `address1`, deleted=yes
-- School (as reported): "Montessori School Itard and Seguin "
-- Original: "Senda Eterna 368, Milenio III QuerÃ©taro, Qro.  Leer mÃ¡s: https://montessoriitardyseguin.webnode.mx/"
-- Proposed: "Senda Eterna 368, Milenio III Querétaro, Qro.  Leer más: https://montessoriitardyseguin.webnode.mx/"
UPDATE `schools` SET `address1` = CONVERT(X'53656E646120457465726E61203336382C204D696C656E696F204949492051756572C3A97461726F2C2051726F2E20204C656572206DC3A1733A2068747470733A2F2F6D6F6E746573736F726969746172647973656775696E2E7765626E6F64652E6D782F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27528 AND CAST(`address1` AS BINARY) = X'53656E646120457465726E61203336382C204D696C656E696F204949492051756572C383C2A97461726F2C2051726F2E20204C656572206DC383C2A1733A2068747470733A2F2F6D6F6E746573736F726969746172647973656775696E2E7765626E6F64652E6D782F';

-- Entry 780: school id 27529, column `address1`, deleted=no
-- School (as reported): "Colegio de Educacion Montessori"
-- Original: "Juan Sarabia 137 Col. Nueva Santa MarÃ­a Azcapotzalco CDMX"
-- Proposed: "Juan Sarabia 137 Col. Nueva Santa María Azcapotzalco CDMX"
UPDATE `schools` SET `address1` = CONVERT(X'4A75616E20536172616269612031333720436F6C2E204E756576612053616E7461204D6172C3AD6120417A6361706F747A616C636F2043444D58' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27529 AND CAST(`address1` AS BINARY) = X'4A75616E20536172616269612031333720436F6C2E204E756576612053616E7461204D6172C383C2AD6120417A6361706F747A616C636F2043444D58';

-- Entry 781: school id 27533, column `address1`, deleted=no
-- School (as reported): "Sunflower Montessori Creche- Alizeti"
-- Original: "13 route de TrÃ¨ves"
-- Proposed: "13 route de Trèves"
UPDATE `schools` SET `address1` = CONVERT(X'313320726F757465206465205472C3A8766573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27533 AND CAST(`address1` AS BINARY) = X'313320726F757465206465205472C383C2A8766573';

-- Entry 782: school id 27550, column `address1`, deleted=no
-- School (as reported): "Colegio Nuevo Montessori"
-- Original: "BogotÃ¡, Colombia Calle 23 # 81B - 05"
-- Proposed: "Bogotá, Colombia Calle 23 # 81B - 05"
UPDATE `schools` SET `address1` = CONVERT(X'426F676F74C3A12C20436F6C6F6D6269612043616C6C65203233202320383142202D203035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27550 AND CAST(`address1` AS BINARY) = X'426F676F74C383C2A12C20436F6C6F6D6269612043616C6C65203233202320383142202D203035';

-- Entry 783: school id 27551, column `address1`, deleted=no
-- School (as reported): "Casa Montessori "
-- Original: "Vereda el Placer UrbanizaciÃ³n Murillo Comuna 11 Armenia - QuindÃ­o"
-- Proposed: "Vereda el Placer Urbanización Murillo Comuna 11 Armenia - Quindío"
UPDATE `schools` SET `address1` = CONVERT(X'56657265646120656C20506C6163657220557262616E697A616369C3B36E204D7572696C6C6F20436F6D756E612031312041726D656E6961202D205175696E64C3AD6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27551 AND CAST(`address1` AS BINARY) = X'56657265646120656C20506C6163657220557262616E697A616369C383C2B36E204D7572696C6C6F20436F6D756E612031312041726D656E6961202D205175696E64C383C2AD6F';

-- Entry 784: school id 27554, column `address1`, deleted=no
-- School (as reported): "Montessori Kids"
-- Original: "Estamos en C/ Cervantes nÂº 34, C.P 50006, Zaragoza."
-- Proposed: "Estamos en C/ Cervantes nº 34, C.P 50006, Zaragoza."
UPDATE `schools` SET `address1` = CONVERT(X'457374616D6F7320656E20432F2043657276616E746573206EC2BA2033342C20432E502035303030362C205A617261676F7A612E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27554 AND CAST(`address1` AS BINARY) = X'457374616D6F7320656E20432F2043657276616E746573206EC382C2BA2033342C20432E502035303030362C205A617261676F7A612E';

-- Entry 785: school id 27559, column `address1`, deleted=no
-- School (as reported): "Colegio Maria Montessori Arauca SAS"
-- Original: "Carrera 18 NÂ° 25a - 80 San Luis  Arauca, Colombia"
-- Proposed: "Carrera 18 N° 25a - 80 San Luis  Arauca, Colombia"
UPDATE `schools` SET `address1` = CONVERT(X'43617272657261203138204EC2B020323561202D2038302053616E204C75697320204172617563612C20436F6C6F6D626961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27559 AND CAST(`address1` AS BINARY) = X'43617272657261203138204EC382C2B020323561202D2038302053616E204C75697320204172617563612C20436F6C6F6D626961';

-- Entry 786: school id 27565, column `address1`, deleted=yes
-- School (as reported): "Colegio Integrado Maria Montessori"
-- Original: "AVENIDA LA FLORIDA TUMACO, NARIÃ‘O Colombia"
-- Proposed: "AVENIDA LA FLORIDA TUMACO, NARIÑO Colombia"
UPDATE `schools` SET `address1` = CONVERT(X'4156454E494441204C4120464C4F524944412054554D41434F2C204E415249C3914F20436F6C6F6D626961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27565 AND CAST(`address1` AS BINARY) = X'4156454E494441204C4120464C4F524944412054554D41434F2C204E415249C383E280984F20436F6C6F6D626961';

-- Entry 787: school id 27565, column `city`, deleted=yes
-- School (as reported): "Colegio Integrado Maria Montessori"
-- Original: "NariÃ±o"
-- Proposed: "Nariño"
UPDATE `schools` SET `city` = CONVERT(X'4E617269C3B16F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27565 AND CAST(`city` AS BINARY) = X'4E617269C383C2B16F';

-- Entry 788: school id 27568, column `address1`, deleted=no
-- School (as reported): "Achara Montessori School"
-- Original: "Vereda Fonqueta, Sector Taller Artesanal. Via La Valvanera. ChÃ­a, Cundinamarca Colombia"
-- Proposed: "Vereda Fonqueta, Sector Taller Artesanal. Via La Valvanera. Chía, Cundinamarca Colombia"
UPDATE `schools` SET `address1` = CONVERT(X'56657265646120466F6E71756574612C20536563746F722054616C6C6572204172746573616E616C2E20566961204C612056616C76616E6572612E204368C3AD612C2043756E64696E616D6172636120436F6C6F6D626961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27568 AND CAST(`address1` AS BINARY) = X'56657265646120466F6E71756574612C20536563746F722054616C6C6572204172746573616E616C2E20566961204C612056616C76616E6572612E204368C383C2AD612C2043756E64696E616D6172636120436F6C6F6D626961';

-- Entry 789: school id 27569, column `address1`, deleted=yes
-- School (as reported): "Montessori Planet Jardin Infantil"
-- Original: "calle 120 #70-19 BogotÃ¡ D.C."
-- Proposed: "calle 120 #70-19 Bogotá D.C."
UPDATE `schools` SET `address1` = CONVERT(X'63616C6C6520313230202337302D313920426F676F74C3A120442E432E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27569 AND CAST(`address1` AS BINARY) = X'63616C6C6520313230202337302D313920426F676F74C383C2A120442E432E';

-- Entry 790: school id 27580, column `address1`, deleted=yes
-- School (as reported): "Gimnasio Pedagogico Maria Montessori"
-- Original: "KR 114 A 152 B 67, COLOMBIA, BOGOTÃ."
-- Proposed: "KR 114 A 152 B 67, COLOMBIA, BOGOTÁ."
UPDATE `schools` SET `address1` = CONVERT(X'4B522031313420412031353220422036372C20434F4C4F4D4249412C20424F474F54C3812E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27580 AND CAST(`address1` AS BINARY) = X'4B522031313420412031353220422036372C20434F4C4F4D4249412C20424F474F54C383C2812E';

-- Entry 791: school id 27581, column `address1`, deleted=yes
-- School (as reported): "International Montessori Casa del Mar"
-- Original: "Calle Linda Vista, 10 29670 San Pedro AlcÃ¡ntara Marbella"
-- Proposed: "Calle Linda Vista, 10 29670 San Pedro Alcántara Marbella"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204C696E64612056697374612C2031302032393637302053616E20506564726F20416C63C3A16E74617261204D617262656C6C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27581 AND CAST(`address1` AS BINARY) = X'43616C6C65204C696E64612056697374612C2031302032393637302053616E20506564726F20416C63C383C2A16E74617261204D617262656C6C61';

-- Entry 792: school id 27584, column `address1`, deleted=no
-- School (as reported): "New World Montessori Peru"
-- Original: "Urb. Tupac Amaru E-27, San SebastiÃ¡n Cusco - PerÃº"
-- Proposed: "Urb. Tupac Amaru E-27, San Sebastián Cusco - Perú"
UPDATE `schools` SET `address1` = CONVERT(X'5572622E20547570616320416D61727520452D32372C2053616E2053656261737469C3A16E20437573636F202D20506572C3BA' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27584 AND CAST(`address1` AS BINARY) = X'5572622E20547570616320416D61727520452D32372C2053616E2053656261737469C383C2A16E20437573636F202D20506572C383C2BA';

-- Entry 793: school id 27590, column `address1`, deleted=no
-- School (as reported): "Nido Maria Guia Montessori"
-- Original: "Calle MarÃ­a JosÃ© de Arce 235 San Miguel"
-- Proposed: "Calle María José de Arce 235 San Miguel"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65204D6172C3AD61204A6F73C3A92064652041726365203233352053616E204D696775656C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27590 AND CAST(`address1` AS BINARY) = X'43616C6C65204D6172C383C2AD61204A6F73C383C2A92064652041726365203233352053616E204D696775656C';

-- Entry 794: school id 27591, column `address1`, deleted=no
-- School (as reported): "Ecomont Ecologico Montessori"
-- Original: "Las Poncianas NÂ° 520. Urb. Santa Edelmira - Trujillo"
-- Proposed: "Las Poncianas N° 520. Urb. Santa Edelmira - Trujillo"
UPDATE `schools` SET `address1` = CONVERT(X'4C617320506F6E6369616E6173204EC2B0203532302E205572622E2053616E7461204564656C6D697261202D205472756A696C6C6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27591 AND CAST(`address1` AS BINARY) = X'4C617320506F6E6369616E6173204EC382C2B0203532302E205572622E2053616E7461204564656C6D697261202D205472756A696C6C6F';

-- Entry 795: school id 27595, column `address1`, deleted=no
-- School (as reported): "Montessori Lancaster Centro Educativo"
-- Original: "Calle 15 #127A x 26 y 28, Colonia MÃ©xico"
-- Proposed: "Calle 15 #127A x 26 y 28, Colonia México"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C65203135202331323741207820323620792032382C20436F6C6F6E6961204DC3A97869636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27595 AND CAST(`address1` AS BINARY) = X'43616C6C65203135202331323741207820323620792032382C20436F6C6F6E6961204DC383C2A97869636F';

-- Entry 796: school id 27596, column `address1`, deleted=no
-- School (as reported): "Escuela Montessori Mercedes Benet"
-- Original: "EjÃ©rcito Nacional 1137"
-- Proposed: "Ejército Nacional 1137"
UPDATE `schools` SET `address1` = CONVERT(X'456AC3A9726369746F204E6163696F6E616C2031313337' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27596 AND CAST(`address1` AS BINARY) = X'456AC383C2A9726369746F204E6163696F6E616C2031313337';

-- Entry 797: school id 27599, column `address1`, deleted=no
-- School (as reported): "Montessori Nexhie"
-- Original: "Enrique RÃ©bsamen 327"
-- Proposed: "Enrique Rébsamen 327"
UPDATE `schools` SET `address1` = CONVERT(X'456E72697175652052C3A96273616D656E20333237' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27599 AND CAST(`address1` AS BINARY) = X'456E72697175652052C383C2A96273616D656E20333237';

-- Entry 798: school id 27603, column `address1`, deleted=no
-- School (as reported): "Centro Cultural Montessori Casa de Bambini"
-- Original: "Insurgentes Sur 4004  Ciudad de MÃ©xico, Tlalpan 14000"
-- Proposed: "Insurgentes Sur 4004  Ciudad de México, Tlalpan 14000"
UPDATE `schools` SET `address1` = CONVERT(X'496E73757267656E7465732053757220343030342020436975646164206465204DC3A97869636F2C20546C616C70616E203134303030' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27603 AND CAST(`address1` AS BINARY) = X'496E73757267656E7465732053757220343030342020436975646164206465204DC383C2A97869636F2C20546C616C70616E203134303030';

-- Entry 799: school id 27604, column `address1`, deleted=no
-- School (as reported): "Centro Educativo Montessori Isku Irekhoreni"
-- Original: "DivisiÃ³n del Norte 35 "
-- Decoded (before cleanup): "División del Norte 35 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "División del Norte 35"
UPDATE `schools` SET `address1` = CONVERT(X'446976697369C3B36E2064656C204E6F727465203335' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27604 AND CAST(`address1` AS BINARY) = X'446976697369C383C2B36E2064656C204E6F72746520333520';

-- Entry 800: school id 27605, column `address1`, deleted=no
-- School (as reported): "Vidya Montessori"
-- Original: "Avenida Adolfo LÃ³pez Mateos no. 71"
-- Proposed: "Avenida Adolfo López Mateos no. 71"
UPDATE `schools` SET `address1` = CONVERT(X'4176656E6964612041646F6C666F204CC3B370657A204D6174656F73206E6F2E203731' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27605 AND CAST(`address1` AS BINARY) = X'4176656E6964612041646F6C666F204CC383C2B370657A204D6174656F73206E6F2E203731';

-- Entry 801: school id 27606, column `address1`, deleted=no
-- School (as reported): "Galicia Montessori"
-- Original: "RÃºa Agrelo N 3 Bajo BertamirÃ¡ns"
-- Proposed: "Rúa Agrelo N 3 Bajo Bertamiráns"
UPDATE `schools` SET `address1` = CONVERT(X'52C3BA6120416772656C6F204E20332042616A6F2042657274616D6972C3A16E73' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27606 AND CAST(`address1` AS BINARY) = X'52C383C2BA6120416772656C6F204E20332042616A6F2042657274616D6972C383C2A16E73';

-- Entry 802: school id 27610, column `headofschoolname`, deleted=no
-- School (as reported): "Colegio Montessori de la MontaÃ±a"
-- Original: "Maria Leticia IÃ±iguez Snyder"
-- Proposed: "Maria Leticia Iñiguez Snyder"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D61726961204C6574696369612049C3B1696775657A20536E79646572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27610 AND CAST(`headofschoolname` AS BINARY) = X'4D61726961204C6574696369612049C383C2B1696775657A20536E79646572';

-- Entry 803: school id 27610, column `schoolname`, deleted=no
-- School (as reported): "Colegio Montessori de la MontaÃ±a"
-- Original: "Colegio Montessori de la MontaÃ±a"
-- Proposed: "Colegio Montessori de la Montaña"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F204D6F6E746573736F7269206465206C61204D6F6E7461C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27610 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F204D6F6E746573736F7269206465206C61204D6F6E7461C383C2B161';

-- Entry 804: school id 27611, column `address1`, deleted=no
-- School (as reported): "Comunidad Montessori- Colegio Millantu"
-- Original: "Colegio Montessori MillantÃº Calle ParÃ­s 998, Villa Alemana"
-- Proposed: "Colegio Montessori Millantú Calle París 998, Villa Alemana"
UPDATE `schools` SET `address1` = CONVERT(X'436F6C6567696F204D6F6E746573736F7269204D696C6C616E74C3BA2043616C6C6520506172C3AD73203939382C2056696C6C6120416C656D616E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27611 AND CAST(`address1` AS BINARY) = X'436F6C6567696F204D6F6E746573736F7269204D696C6C616E74C383C2BA2043616C6C6520506172C383C2AD73203939382C2056696C6C6120416C656D616E61';

-- Entry 805: school id 27612, column `address1`, deleted=yes
-- School (as reported): "Jardin Infantil Munayi"
-- Original: "Mariscal Castilla 2854  Iquique REGIÃ“N DE TARAPACÃ"
-- Proposed: "Mariscal Castilla 2854  Iquique REGIÓN DE TARAPACÁ"
UPDATE `schools` SET `address1` = CONVERT(X'4D6172697363616C2043617374696C6C6120323835342020497175697175652052454749C3934E2044452054415241504143C381' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27612 AND CAST(`address1` AS BINARY) = X'4D6172697363616C2043617374696C6C6120323835342020497175697175652052454749C383E2809C4E2044452054415241504143C383C281';

-- Entry 806: school id 27613, column `address1`, deleted=yes
-- School (as reported): "Jardin Infantil Montessori Enanitos Traviesos"
-- Original: "Manuel RodrÃ­guez 3365, MaipÃº."
-- Proposed: "Manuel Rodríguez 3365, Maipú."
UPDATE `schools` SET `address1` = CONVERT(X'4D616E75656C20526F6472C3AD6775657A20333336352C204D616970C3BA2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27613 AND CAST(`address1` AS BINARY) = X'4D616E75656C20526F6472C383C2AD6775657A20333336352C204D616970C383C2BA2E';

-- Entry 807: school id 27614, column `schoolname`, deleted=yes
-- School (as reported): "Colegio Casa de NiÃ±os Montessori"
-- Original: "Colegio Casa de NiÃ±os Montessori"
-- Proposed: "Colegio Casa de Niños Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F2043617361206465204E69C3B16F73204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27614 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F2043617361206465204E69C383C2B16F73204D6F6E746573736F7269';

-- Entry 808: school id 27615, column `address1`, deleted=no
-- School (as reported): "Institucion Educativa Maria Montessori Cucuta"
-- Original: "CÃºcuta - Norte de Santander"
-- Proposed: "Cúcuta - Norte de Santander"
UPDATE `schools` SET `address1` = CONVERT(X'43C3BA63757461202D204E6F7274652064652053616E74616E646572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27615 AND CAST(`address1` AS BINARY) = X'43C383C2BA63757461202D204E6F7274652064652053616E74616E646572';

-- Entry 809: school id 27616, column `address1`, deleted=no
-- School (as reported): "Montessori Siglo XXI Bogota"
-- Original: "Sede BatÃ¡n, Cra. 48 #No 118-96, BogotÃ¡, Colombia"
-- Proposed: "Sede Batán, Cra. 48 #No 118-96, Bogotá, Colombia"
UPDATE `schools` SET `address1` = CONVERT(X'5365646520426174C3A16E2C204372612E20343820234E6F203131382D39362C20426F676F74C3A12C20436F6C6F6D626961' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27616 AND CAST(`address1` AS BINARY) = X'5365646520426174C383C2A16E2C204372612E20343820234E6F203131382D39362C20426F676F74C383C2A12C20436F6C6F6D626961';

-- Entry 810: school id 27622, column `address1`, deleted=no
-- School (as reported): "Montessori Bambini Centro Educaivo"
-- Original: "Calle VÃ­ctor Garrido NÂº2867"
-- Proposed: "Calle Víctor Garrido Nº2867"
UPDATE `schools` SET `address1` = CONVERT(X'43616C6C652056C3AD63746F72204761727269646F204EC2BA32383637' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27622 AND CAST(`address1` AS BINARY) = X'43616C6C652056C383C2AD63746F72204761727269646F204EC382C2BA32383637';

-- Entry 811: school id 27624, column `address1`, deleted=no
-- School (as reported): "Jardin Infantil Pulmahue Montessori "
-- Original: "Siglo XXI nÂº 541"
-- Proposed: "Siglo XXI nº 541"
UPDATE `schools` SET `address1` = CONVERT(X'5369676C6F20585849206EC2BA20353431' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27624 AND CAST(`address1` AS BINARY) = X'5369676C6F20585849206EC382C2BA20353431';

-- Entry 812: school id 27625, column `address1`, deleted=no
-- School (as reported): "Colegio Schulhaus Montessori"
-- Original: "Los MuÃ±oces, Sector C 2629"
-- Proposed: "Los Muñoces, Sector C 2629"
UPDATE `schools` SET `address1` = CONVERT(X'4C6F73204D75C3B16F6365732C20536563746F7220432032363239' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27625 AND CAST(`address1` AS BINARY) = X'4C6F73204D75C383C2B16F6365732C20536563746F7220432032363239';

-- Entry 813: school id 27626, column `address1`, deleted=no
-- School (as reported): "Playtime Montessori"
-- Original: "Pavas, de la esquina Noreste de la Mc DonaldÂ´s Pavas, 50 mts sur, mano izquierta."
-- Proposed: "Pavas, de la esquina Noreste de la Mc Donald´s Pavas, 50 mts sur, mano izquierta."
UPDATE `schools` SET `address1` = CONVERT(X'50617661732C206465206C612065737175696E61204E6F7265737465206465206C61204D6320446F6E616C64C2B4732050617661732C203530206D7473207375722C206D616E6F20697A717569657274612E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27626 AND CAST(`address1` AS BINARY) = X'50617661732C206465206C612065737175696E61204E6F7265737465206465206C61204D6320446F6E616C64C382C2B4732050617661732C203530206D7473207375722C206D616E6F20697A717569657274612E';

-- Entry 814: school id 27653, column `address1`, deleted=yes
-- School (as reported): "Mi Jardin Infantil"
-- Original: "Juan Moya Morales 950, Ã‘uÃ±oa, RegiÃ³n Metropolitana, Chile"
-- Proposed: "Juan Moya Morales 950, Ñuñoa, Región Metropolitana, Chile"
UPDATE `schools` SET `address1` = CONVERT(X'4A75616E204D6F7961204D6F72616C6573203935302C20C39175C3B16F612C2052656769C3B36E204D6574726F706F6C6974616E612C204368696C65' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27653 AND CAST(`address1` AS BINARY) = X'4A75616E204D6F7961204D6F72616C6573203935302C20C383E2809875C383C2B16F612C2052656769C383C2B36E204D6574726F706F6C6974616E612C204368696C65';

-- Entry 815: school id 27655, column `address1`, deleted=no
-- School (as reported): "Colegio Andino Montessori"
-- Original: "SebastiÃ¡n Elcano 1590"
-- Proposed: "Sebastián Elcano 1590"
UPDATE `schools` SET `address1` = CONVERT(X'53656261737469C3A16E20456C63616E6F2031353930' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27655 AND CAST(`address1` AS BINARY) = X'53656261737469C383C2A16E20456C63616E6F2031353930';

-- Entry 816: school id 27660, column `address1`, deleted=yes
-- School (as reported): "Montessori House"
-- Original: "Carrer Font del Realet, 17, 03550 Sant Joan d'Alacant, Alicante, EspaÃ±a"
-- Proposed: "Carrer Font del Realet, 17, 03550 Sant Joan d'Alacant, Alicante, España"
UPDATE `schools` SET `address1` = CONVERT(X'43617272657220466F6E742064656C205265616C65742C2031372C2030333535302053616E74204A6F616E206427416C6163616E742C20416C6963616E74652C2045737061C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27660 AND CAST(`address1` AS BINARY) = X'43617272657220466F6E742064656C205265616C65742C2031372C2030333535302053616E74204A6F616E206427416C6163616E742C20416C6963616E74652C2045737061C383C2B161';

-- Entry 817: school id 27661, column `address1`, deleted=yes
-- School (as reported): "E.I. Maria Montessori"
-- Original: "C/ Avda. del EjÃ©rcito s/n Utrera / C.P.:41710 / (SEVILLA"
-- Proposed: "C/ Avda. del Ejército s/n Utrera / C.P.:41710 / (SEVILLA"
UPDATE `schools` SET `address1` = CONVERT(X'432F20417664612E2064656C20456AC3A9726369746F20732F6E20557472657261202F20432E502E3A3431373130202F2028534556494C4C41' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27661 AND CAST(`address1` AS BINARY) = X'432F20417664612E2064656C20456AC383C2A9726369746F20732F6E20557472657261202F20432E502E3A3431373130202F2028534556494C4C41';

-- Entry 818: school id 27662, column `address1`, deleted=no
-- School (as reported): "British Montessori El Enebral"
-- Original: "Paseo de BelmÃ¡s, 5 "
-- Decoded (before cleanup): "Paseo de Belmás, 5 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Paseo de Belmás, 5"
UPDATE `schools` SET `address1` = CONVERT(X'506173656F2064652042656C6DC3A1732C2035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27662 AND CAST(`address1` AS BINARY) = X'506173656F2064652042656C6DC383C2A1732C203520';

-- Entry 819: school id 27663, column `address1`, deleted=no
-- School (as reported): "Montessori Compostela"
-- Original: "RÃºa de Sar s/n. Colexiata de Sar. CP 15702"
-- Proposed: "Rúa de Sar s/n. Colexiata de Sar. CP 15702"
UPDATE `schools` SET `address1` = CONVERT(X'52C3BA612064652053617220732F6E2E20436F6C657869617461206465205361722E204350203135373032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27663 AND CAST(`address1` AS BINARY) = X'52C383C2BA612064652053617220732F6E2E20436F6C657869617461206465205361722E204350203135373032';

-- Entry 820: school id 27670, column `address1`, deleted=no
-- School (as reported): "Montessori School Peru"
-- Original: "Av. JosÃ© Olaya NÂ° 513, Cerro Colorado"
-- Proposed: "Av. José Olaya N° 513, Cerro Colorado"
UPDATE `schools` SET `address1` = CONVERT(X'41762E204A6F73C3A9204F6C617961204EC2B0203531332C20436572726F20436F6C6F7261646F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27670 AND CAST(`address1` AS BINARY) = X'41762E204A6F73C383C2A9204F6C617961204EC382C2B0203531332C20436572726F20436F6C6F7261646F';

-- Entry 821: school id 27673, column `address1`, deleted=no
-- School (as reported): "Colegio Montessori Mazatlan"
-- Original: "Sierra Rumorosa #567, Lomas de MazatlÃ¡n.  CP. 82110, MazatlÃ¡n, Sinaloa, MÃ©xico."
-- Proposed: "Sierra Rumorosa #567, Lomas de Mazatlán.  CP. 82110, Mazatlán, Sinaloa, México."
UPDATE `schools` SET `address1` = CONVERT(X'5369657272612052756D6F726F736120233536372C204C6F6D6173206465204D617A61746CC3A16E2E202043502E2038323131302C204D617A61746CC3A16E2C2053696E616C6F612C204DC3A97869636F2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27673 AND CAST(`address1` AS BINARY) = X'5369657272612052756D6F726F736120233536372C204C6F6D6173206465204D617A61746CC383C2A16E2E202043502E2038323131302C204D617A61746CC383C2A16E2C2053696E616C6F612C204DC383C2A97869636F2E';

-- Entry 822: school id 27705, column `address1`, deleted=no
-- School (as reported): "Asociacion de Escuelas Montessori de Puebla"
-- Original: "Calzada Zavaleta 5535-3, Col. Concepcion la Cruz. San AndrÃ©s cholula, Pue. MÃ©xico."
-- Proposed: "Calzada Zavaleta 5535-3, Col. Concepcion la Cruz. San Andrés cholula, Pue. México."
UPDATE `schools` SET `address1` = CONVERT(X'43616C7A616461205A6176616C65746120353533352D332C20436F6C2E20436F6E63657063696F6E206C61204372757A2E2053616E20416E6472C3A9732063686F6C756C612C205075652E204DC3A97869636F2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27705 AND CAST(`address1` AS BINARY) = X'43616C7A616461205A6176616C65746120353533352D332C20436F6C2E20436F6E63657063696F6E206C61204372757A2E2053616E20416E6472C383C2A9732063686F6C756C612C205075652E204DC383C2A97869636F2E';

-- Entry 823: school id 27706, column `address1`, deleted=no
-- School (as reported): "Montessori Laurel- Casa de los niÃ±os y Comunidad Infantil"
-- Original: "Ricardo Monges LÃ³pez (Av. Cinco) No.73 Col. EducaciÃ³n, AlcaldÃ­a CoyoacÃ¡n, C.P. 04400,CDMX"
-- Proposed: "Ricardo Monges López (Av. Cinco) No.73 Col. Educación, Alcaldía Coyoacán, C.P. 04400,CDMX"
UPDATE `schools` SET `address1` = CONVERT(X'5269636172646F204D6F6E676573204CC3B370657A202841762E2043696E636F29204E6F2E373320436F6C2E2045647563616369C3B36E2C20416C63616C64C3AD6120436F796F6163C3A16E2C20432E502E2030343430302C43444D58' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27706 AND CAST(`address1` AS BINARY) = X'5269636172646F204D6F6E676573204CC383C2B370657A202841762E2043696E636F29204E6F2E373320436F6C2E2045647563616369C383C2B36E2C20416C63616C64C383C2AD6120436F796F6163C383C2A16E2C20432E502E2030343430302C43444D58';

-- Entry 824: school id 27706, column `schoolname`, deleted=no
-- School (as reported): "Montessori Laurel- Casa de los niÃ±os y Comunidad Infantil"
-- Original: "Montessori Laurel- Casa de los niÃ±os y Comunidad Infantil"
-- Proposed: "Montessori Laurel- Casa de los niños y Comunidad Infantil"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204C617572656C2D2043617361206465206C6F73206E69C3B16F73207920436F6D756E6964616420496E66616E74696C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27706 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204C617572656C2D2043617361206465206C6F73206E69C383C2B16F73207920436F6D756E6964616420496E66616E74696C';

-- Entry 825: school id 27708, column `address1`, deleted=no
-- School (as reported): "Instituto Montessori San Angel"
-- Original: "Calzada UniÃ³n No. 1042  "
-- Decoded (before cleanup): "Calzada Unión No. 1042  "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calzada Unión No. 1042"
UPDATE `schools` SET `address1` = CONVERT(X'43616C7A61646120556E69C3B36E204E6F2E2031303432' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27708 AND CAST(`address1` AS BINARY) = X'43616C7A61646120556E69C383C2B36E204E6F2E20313034322020';

-- Entry 826: school id 27711, column `headofschoolname`, deleted=no
-- School (as reported): "Colegio Montessori Victoria"
-- Original: "Profa. MarÃ­a de la Luz SaldÃ­var RodrÃ­guez."
-- Proposed: "Profa. María de la Luz Saldívar Rodríguez."
UPDATE `schools` SET `headofschoolname` = CONVERT(X'50726F66612E204D6172C3AD61206465206C61204C757A2053616C64C3AD76617220526F6472C3AD6775657A2E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27711 AND CAST(`headofschoolname` AS BINARY) = X'50726F66612E204D6172C383C2AD61206465206C61204C757A2053616C64C383C2AD76617220526F6472C383C2AD6775657A2E';

-- Entry 827: school id 27712, column `address1`, deleted=no
-- School (as reported): "Forester Colegio Montessori"
-- Original: "Ãrbol de La Vida 62"
-- Proposed: "Árbol de La Vida 62"
UPDATE `schools` SET `address1` = CONVERT(X'C38172626F6C206465204C612056696461203632' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27712 AND CAST(`address1` AS BINARY) = X'C383C28172626F6C206465204C612056696461203632';

-- Entry 828: school id 27716, column `address1`, deleted=no
-- School (as reported): "Instituto Montessori Anahuac"
-- Original: "MANUEL L. BARRAGÃN 230 NTE. COL. RESIDENCIAL ANÃHUAC SAN NICOLAS DE LOS GARZA NUEVO LEÃ“N"
-- Proposed: "MANUEL L. BARRAGÁN 230 NTE. COL. RESIDENCIAL ANÁHUAC SAN NICOLAS DE LOS GARZA NUEVO LEÓN"
UPDATE `schools` SET `address1` = CONVERT(X'4D414E55454C204C2E20424152524147C3814E20323330204E54452E20434F4C2E205245534944454E4349414C20414EC381485541432053414E204E49434F4C4153204445204C4F53204741525A41204E5545564F204C45C3934E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27716 AND CAST(`address1` AS BINARY) = X'4D414E55454C204C2E20424152524147C383C2814E20323330204E54452E20434F4C2E205245534944454E4349414C20414EC383C281485541432053414E204E49434F4C4153204445204C4F53204741525A41204E5545564F204C45C383E2809C4E';

-- Entry 829: school id 27717, column `address1`, deleted=no
-- School (as reported): "Montessori Xaltepec"
-- Original: "Camino Real a San AndrÃ©s y/o Radial a Zapata 3014-A"
-- Proposed: "Camino Real a San Andrés y/o Radial a Zapata 3014-A"
UPDATE `schools` SET `address1` = CONVERT(X'43616D696E6F205265616C20612053616E20416E6472C3A97320792F6F2052616469616C2061205A617061746120333031342D41' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27717 AND CAST(`address1` AS BINARY) = X'43616D696E6F205265616C20612053616E20416E6472C383C2A97320792F6F2052616469616C2061205A617061746120333031342D41';

-- Entry 830: school id 27717, column `address2`, deleted=no
-- School (as reported): "Montessori Xaltepec"
-- Original: "San AndrÃ©s Cholula"
-- Proposed: "San Andrés Cholula"
UPDATE `schools` SET `address2` = CONVERT(X'53616E20416E6472C3A9732043686F6C756C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27717 AND CAST(`address2` AS BINARY) = X'53616E20416E6472C383C2A9732043686F6C756C61';

-- Entry 831: school id 27906, column `address1`, deleted=no
-- School (as reported): "Przedszkole Ala ma kota House of Montessori- Altowa- Ochota"
-- Original: "KoÅ›cieszÃ³w 4"
-- Proposed: "Kościeszów 4"
UPDATE `schools` SET `address1` = CONVERT(X'4B6FC59B636965737AC3B3772034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27906 AND CAST(`address1` AS BINARY) = X'4B6FC385E280BA636965737AC383C2B3772034';

-- Entry 832: school id 27914, column `address1`, deleted=no
-- School (as reported): "Przedszkole Montessori House"
-- Original: "Niepubliczne Przedszkole Montessori House ul. Jana PawÅ‚a II 214"
-- Proposed: "Niepubliczne Przedszkole Montessori House ul. Jana Pawła II 214"
UPDATE `schools` SET `address1` = CONVERT(X'4E69657075626C69637A6E652050727A6564737A6B6F6C65204D6F6E746573736F726920486F75736520756C2E204A616E6120506177C5826120494920323134' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27914 AND CAST(`address1` AS BINARY) = X'4E69657075626C69637A6E652050727A6564737A6B6F6C65204D6F6E746573736F726920486F75736520756C2E204A616E6120506177C385E2809A6120494920323134';

-- Entry 833: school id 27929, column `address1`, deleted=no
-- School (as reported): "Montessori Haus TimiÈ™oara"
-- Original: "Bulevardul Constantin BrÃ¢ncoveanu 73-77, "
-- Decoded (before cleanup): "Bulevardul Constantin Brâncoveanu 73-77, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Bulevardul Constantin Brâncoveanu 73-77,"
UPDATE `schools` SET `address1` = CONVERT(X'42756C6576617264756C20436F6E7374616E74696E204272C3A26E636F7665616E752037332D37372C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 27929 AND CAST(`address1` AS BINARY) = X'42756C6576617264756C20436F6E7374616E74696E204272C383C2A26E636F7665616E752037332D37372C20';

-- Entry 834: school id 28013, column `address1`, deleted=no
-- School (as reported): "Cleto L. Rodriguez Montessori Elementary School"
-- Original: "3626 W CÃ©sar E ChÃ¡vez Blvd"
-- Proposed: "3626 W César E Chávez Blvd"
UPDATE `schools` SET `address1` = CONVERT(X'3336323620572043C3A97361722045204368C3A176657A20426C7664' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28013 AND CAST(`address1` AS BINARY) = X'3336323620572043C383C2A97361722045204368C383C2A176657A20426C7664';

-- Entry 835: school id 28080, column `address1`, deleted=no
-- School (as reported): "Morning Star Montessori Center- Leefield Campus"
-- Original: "7910 â€“ 36 Ave., NW"
-- Proposed: "7910 – 36 Ave., NW"
UPDATE `schools` SET `address1` = CONVERT(X'3739313020E28093203336204176652E2C204E57' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28080 AND CAST(`address1` AS BINARY) = X'3739313020C3A2E282ACE2809C203336204176652E2C204E57';

-- Entry 836: school id 28191, column `headofschoolname`, deleted=no
-- School (as reported): "Le Soleil Montessori Infant Community"
-- Original: "EloÃ¯se Aguilar-Saurina"
-- Proposed: "Eloïse Aguilar-Saurina"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'456C6FC3AF736520416775696C61722D53617572696E61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28191 AND CAST(`headofschoolname` AS BINARY) = X'456C6FC383C2AF736520416775696C61722D53617572696E61';

-- Entry 837: school id 28221, column `address1`, deleted=no
-- School (as reported): "La Villa Montessori"
-- Original: "1045 Boulevard RenÃ©-LÃ©vesque O, "
-- Decoded (before cleanup): "1045 Boulevard René-Lévesque O, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "1045 Boulevard René-Lévesque O,"
UPDATE `schools` SET `address1` = CONVERT(X'3130343520426F756C65766172642052656EC3A92D4CC3A9766573717565204F2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28221 AND CAST(`address1` AS BINARY) = X'3130343520426F756C65766172642052656EC383C2A92D4CC383C2A9766573717565204F2C20';

-- Entry 838: school id 28221, column `city`, deleted=no
-- School (as reported): "La Villa Montessori"
-- Original: "QuÃ©bec"
-- Proposed: "Québec"
UPDATE `schools` SET `city` = CONVERT(X'5175C3A9626563' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28221 AND CAST(`city` AS BINARY) = X'5175C383C2A9626563';

-- Entry 839: school id 28222, column `address1`, deleted=no
-- School (as reported): "Les Explorateurs Montessori"
-- Original: "4640 Wilfrid-Hamel Blvd, QuÃ©bec City, "
-- Decoded (before cleanup): "4640 Wilfrid-Hamel Blvd, Québec City, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "4640 Wilfrid-Hamel Blvd, Québec City,"
UPDATE `schools` SET `address1` = CONVERT(X'343634302057696C667269642D48616D656C20426C76642C205175C3A962656320436974792C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28222 AND CAST(`address1` AS BINARY) = X'343634302057696C667269642D48616D656C20426C76642C205175C383C2A962656320436974792C20';

-- Entry 840: school id 28685, column `schoolname`, deleted=no
-- School (as reported): "WÃ´panÃ¢ak Language Reclamation Project"
-- Original: "WÃ´panÃ¢ak Language Reclamation Project"
-- Proposed: "Wôpanâak Language Reclamation Project"
UPDATE `schools` SET `schoolname` = CONVERT(X'57C3B470616EC3A2616B204C616E6775616765205265636C616D6174696F6E2050726F6A656374' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28685 AND CAST(`schoolname` AS BINARY) = X'57C383C2B470616EC383C2A2616B204C616E6775616765205265636C616D6174696F6E2050726F6A656374';

-- Entry 841: school id 28771, column `address1`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-VÄƒn phÃ²ng "
-- Original: "50 TÃ¢y SÆ¡n"
-- Proposed: "50 Tây Sơn"
UPDATE `schools` SET `address1` = CONVERT(X'35302054C3A2792053C6A16E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28771 AND CAST(`address1` AS BINARY) = X'35302054C383C2A2792053C386C2A16E';

-- Entry 842: school id 28771, column `schoolname`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-VÄƒn phÃ²ng "
-- Original: "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-VÄƒn phÃ²ng "
-- Decoded (before cleanup): "American Montessori School - Hê Thồng Mấm non AMSS-Văn phòng "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "American Montessori School - Hê Thồng Mấm non AMSS-Văn phòng"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C3AA205468E1BB936E67204DE1BAA56D206E6F6E20414D53532D56C4836E207068C3B26E67' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28771 AND CAST(`schoolname` AS BINARY) = X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C383C2AA205468C3A1C2BBE2809C6E67204DC3A1C2BAC2A56D206E6F6E20414D53532D56C384C6926E207068C383C2B26E6720';

-- Entry 843: school id 28772, column `address1`, deleted=no
-- School (as reported): "American Montessori School - AMSS XUÃ‚N THá»¦Y"
-- Original: "Biá»‡t thá»± NV1-02, 173 XuÃ¢n Thá»§y, Cáº§u Giáº¥y, "
-- Decoded (before cleanup): "Biệt thự NV1-02, 173 Xuân Thủy, Cầu Giấy, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Biệt thự NV1-02, 173 Xuân Thủy, Cầu Giấy,"
UPDATE `schools` SET `address1` = CONVERT(X'4269E1BB8774207468E1BBB1204E56312D30322C20313733205875C3A26E205468E1BBA7792C2043E1BAA775204769E1BAA5792C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28772 AND CAST(`address1` AS BINARY) = X'4269C3A1C2BBE280A174207468C3A1C2BBC2B1204E56312D30322C20313733205875C383C2A26E205468C3A1C2BBC2A7792C2043C3A1C2BAC2A775204769C3A1C2BAC2A5792C20';

-- Entry 844: school id 28772, column `city`, deleted=no
-- School (as reported): "American Montessori School - AMSS XUÃ‚N THá»¦Y"
-- Original: "HÃ  Ná»™i"
-- Proposed: "Hà Nội"
UPDATE `schools` SET `city` = CONVERT(X'48C3A0204EE1BB9969' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28772 AND CAST(`city` AS BINARY) = X'48C383C2A0204EC3A1C2BBE284A269';

-- Entry 845: school id 28772, column `schoolname`, deleted=no
-- School (as reported): "American Montessori School - AMSS XUÃ‚N THá»¦Y"
-- Original: "American Montessori School - AMSS XUÃ‚N THá»¦Y"
-- Proposed: "American Montessori School - AMSS XUÂN THỦY"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D20414D5353205855C3824E205448E1BBA659' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28772 AND CAST(`schoolname` AS BINARY) = X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D20414D5353205855C383E2809A4E205448C3A1C2BBC2A659';

-- Entry 846: school id 28773, column `address1`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 2"
-- Original: "NV2-08, 173 XuÃ¢n Thá»§y"
-- Proposed: "NV2-08, 173 Xuân Thủy"
UPDATE `schools` SET `address1` = CONVERT(X'4E56322D30382C20313733205875C3A26E205468E1BBA779' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28773 AND CAST(`address1` AS BINARY) = X'4E56322D30382C20313733205875C383C2A26E205468C3A1C2BBC2A779';

-- Entry 847: school id 28773, column `city`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 2"
-- Original: "HÃ  Ná»™i"
-- Proposed: "Hà Nội"
UPDATE `schools` SET `city` = CONVERT(X'48C3A0204EE1BB9969' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28773 AND CAST(`city` AS BINARY) = X'48C383C2A0204EC3A1C2BBE284A269';

-- Entry 848: school id 28773, column `schoolname`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 2"
-- Original: "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 2"
-- Proposed: "American Montessori School - Hê Thồng Mấm non AMSS-Cơ sở 2"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C3AA205468E1BB936E67204DE1BAA56D206E6F6E20414D53532D43C6A12073E1BB9F2032' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28773 AND CAST(`schoolname` AS BINARY) = X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C383C2AA205468C3A1C2BBE2809C6E67204DC3A1C2BAC2A56D206E6F6E20414D53532D43C386C2A12073C3A1C2BBC5B82032';

-- Entry 849: school id 28774, column `city`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 3"
-- Original: "HÃ m Nghi, Má»¹ ÄÃ¬nh, Nam Tá»« LiÃªm"
-- Proposed: "Hàm Nghi, Mỹ Đình, Nam Từ Liêm"
UPDATE `schools` SET `city` = CONVERT(X'48C3A06D204E6768692C204DE1BBB920C490C3AC6E682C204E616D2054E1BBAB204C69C3AA6D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28774 AND CAST(`city` AS BINARY) = X'48C383C2A06D204E6768692C204DC3A1C2BBC2B920C384C290C383C2AC6E682C204E616D2054C3A1C2BBC2AB204C69C383C2AA6D';

-- Entry 850: school id 28774, column `schoolname`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 3"
-- Original: "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 3"
-- Proposed: "American Montessori School - Hê Thồng Mấm non AMSS-Cơ sở 3"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C3AA205468E1BB936E67204DE1BAA56D206E6F6E20414D53532D43C6A12073E1BB9F2033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28774 AND CAST(`schoolname` AS BINARY) = X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C383C2AA205468C3A1C2BBE2809C6E67204DC3A1C2BAC2A56D206E6F6E20414D53532D43C386C2A12073C3A1C2BBC5B82033';

-- Entry 851: school id 28775, column `address1`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 4"
-- Original: "ML6-03, ÄÆ°á»ng LÆ°Æ¡ng Tháº¿ Vinh, KÄT Vinhomes Green Bay, Nam Tá»« LiÃªm, "
-- Decoded (before cleanup): "ML6-03, Đường Lương Thế Vinh, KĐT Vinhomes Green Bay, Nam Từ Liêm, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "ML6-03, Đường Lương Thế Vinh, KĐT Vinhomes Green Bay, Nam Từ Liêm,"
UPDATE `schools` SET `address1` = CONVERT(X'4D4C362D30332C20C490C6B0E1BB9D6E67204CC6B0C6A16E67205468E1BABF2056696E682C204BC490542056696E686F6D657320477265656E204261792C204E616D2054E1BBAB204C69C3AA6D2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28775 AND CAST(`address1` AS BINARY) = X'4D4C362D30332C20C384C290C386C2B0C3A1C2BBC29D6E67204CC386C2B0C386C2A16E67205468C3A1C2BAC2BF2056696E682C204BC384C290542056696E686F6D657320477265656E204261792C204E616D2054C3A1C2BBC2AB204C69C383C2AA6D2C20';

-- Entry 852: school id 28775, column `city`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 4"
-- Original: "HÃ  Ná»™i"
-- Proposed: "Hà Nội"
UPDATE `schools` SET `city` = CONVERT(X'48C3A0204EE1BB9969' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28775 AND CAST(`city` AS BINARY) = X'48C383C2A0204EC3A1C2BBE284A269';

-- Entry 853: school id 28775, column `schoolname`, deleted=no
-- School (as reported): "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 4"
-- Original: "American Montessori School - HÃª Thá»“ng Máº¥m non AMSS-CÆ¡ sá»Ÿ 4"
-- Proposed: "American Montessori School - Hê Thồng Mấm non AMSS-Cơ sở 4"
UPDATE `schools` SET `schoolname` = CONVERT(X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C3AA205468E1BB936E67204DE1BAA56D206E6F6E20414D53532D43C6A12073E1BB9F2034' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28775 AND CAST(`schoolname` AS BINARY) = X'416D65726963616E204D6F6E746573736F7269205363686F6F6C202D2048C383C2AA205468C3A1C2BBE2809C6E67204DC3A1C2BAC2A56D206E6F6E20414D53532D43C386C2A12073C3A1C2BBC5B82034';

-- Entry 854: school id 28776, column `address1`, deleted=no
-- School (as reported): "American Montessori School - Greenstars"
-- Original: "BT74, ÄÆ°á»ng 23, ThÃ nh phá»‘ Giao LÆ°u An BÃ¬nh City, Green Star 234 Pháº¡m VÄƒn Äá»“ng, Báº¯c Tá»« LiÃªm, HÃ  Ná»™i"
-- Proposed: "BT74, Đường 23, Thành phố Giao Lưu An Bình City, Green Star 234 Phạm Văn Đồng, Bắc Từ Liêm, Hà Nội"
UPDATE `schools` SET `address1` = CONVERT(X'425437342C20C490C6B0E1BB9D6E672032332C205468C3A06E68207068E1BB91204769616F204CC6B07520416E2042C3AC6E6820436974792C20477265656E205374617220323334205068E1BAA16D2056C4836E20C490E1BB936E672C2042E1BAAF632054E1BBAB204C69C3AA6D2C2048C3A0204EE1BB9969' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28776 AND CAST(`address1` AS BINARY) = X'425437342C20C384C290C386C2B0C3A1C2BBC29D6E672032332C205468C383C2A06E68207068C3A1C2BBE28098204769616F204CC386C2B07520416E2042C383C2AC6E6820436974792C20477265656E205374617220323334205068C3A1C2BAC2A16D2056C384C6926E20C384C290C3A1C2BBE2809C6E672C2042C3A1C2BAC2AF632054C3A1C2BBC2AB204C69C383C2AA6D2C2048C383C2A0204EC3A1C2BBE284A269';

-- Entry 855: school id 28776, column `city`, deleted=no
-- School (as reported): "American Montessori School - Greenstars"
-- Original: "HÃ  Ná»™i"
-- Proposed: "Hà Nội"
UPDATE `schools` SET `city` = CONVERT(X'48C3A0204EE1BB9969' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28776 AND CAST(`city` AS BINARY) = X'48C383C2A0204EC3A1C2BBE284A269';

-- Entry 856: school id 28828, column `headofschoolname`, deleted=no
-- School (as reported): "Colegio Montessori- Niveles Primario y Secundario"
-- Original: "MarÃ­a Guadalupe Cuevas "
-- Decoded (before cleanup): "María Guadalupe Cuevas "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "María Guadalupe Cuevas"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'4D6172C3AD612047756164616C75706520437565766173' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28828 AND CAST(`headofschoolname` AS BINARY) = X'4D6172C383C2AD612047756164616C7570652043756576617320';

-- Entry 857: school id 28859, column `address1`, deleted=no
-- School (as reported): "Olivos Montessori School"
-- Original: "Salta 2821 (y calle R. Saenz  PeÃ±a)"
-- Proposed: "Salta 2821 (y calle R. Saenz  Peña)"
UPDATE `schools` SET `address1` = CONVERT(X'53616C746120323832312028792063616C6C6520522E205361656E7A20205065C3B16129' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28859 AND CAST(`address1` AS BINARY) = X'53616C746120323832312028792063616C6C6520522E205361656E7A20205065C383C2B16129';

-- Entry 858: school id 28862, column `schoolname`, deleted=no
-- School (as reported): "Martha Montessori School (BubblyKids Childrenâ€™s House)"
-- Original: "Martha Montessori School (BubblyKids Childrenâ€™s House)"
-- Proposed: "Martha Montessori School (BubblyKids Children’s House)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6172746861204D6F6E746573736F7269205363686F6F6C2028427562626C794B696473204368696C6472656EE280997320486F75736529' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28862 AND CAST(`schoolname` AS BINARY) = X'4D6172746861204D6F6E746573736F7269205363686F6F6C2028427562626C794B696473204368696C6472656EC3A2E282ACE284A27320486F75736529';

-- Entry 859: school id 28892, column `address1`, deleted=no
-- School (as reported): "Gardenya Montessori School"
-- Original: "BÃ¼yÃ¼kesat, Koza Sk. No:109,"
-- Proposed: "Büyükesat, Koza Sk. No:109,"
UPDATE `schools` SET `address1` = CONVERT(X'42C3BC79C3BC6B657361742C204B6F7A6120536B2E204E6F3A3130392C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28892 AND CAST(`address1` AS BINARY) = X'42C383C2BC79C383C2BC6B657361742C204B6F7A6120536B2E204E6F3A3130392C';

-- Entry 860: school id 28895, column `address1`, deleted=no
-- School (as reported): "Ajyal Model Kindergarten-Branch 3- BahÃ§eÅŸehir"
-- Original: "BahÃ§eÅŸehir 1.kÄ±sÄ±m AkÃ§am Sokak Badem 03 villa 05"
-- Proposed: "Bahçeşehir 1.kısım Akçam Sokak Badem 03 villa 05"
UPDATE `schools` SET `address1` = CONVERT(X'426168C3A765C59F6568697220312E6BC4B173C4B16D20416BC3A7616D20536F6B616B20426164656D2030332076696C6C61203035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28895 AND CAST(`address1` AS BINARY) = X'426168C383C2A765C385C5B86568697220312E6BC384C2B173C384C2B16D20416BC383C2A7616D20536F6B616B20426164656D2030332076696C6C61203035';

-- Entry 861: school id 28895, column `schoolname`, deleted=no
-- School (as reported): "Ajyal Model Kindergarten-Branch 3- BahÃ§eÅŸehir"
-- Original: "Ajyal Model Kindergarten-Branch 3- BahÃ§eÅŸehir"
-- Proposed: "Ajyal Model Kindergarten-Branch 3- Bahçeşehir"
UPDATE `schools` SET `schoolname` = CONVERT(X'416A79616C204D6F64656C204B696E64657267617274656E2D4272616E636820332D20426168C3A765C59F65686972' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28895 AND CAST(`schoolname` AS BINARY) = X'416A79616C204D6F64656C204B696E64657267617274656E2D4272616E636820332D20426168C383C2A765C385C5B865686972';

-- Entry 862: school id 28896, column `address1`, deleted=no
-- School (as reported): "Ankara Montessori Akademi Anaokulu"
-- Original: "AlacaatlÄ±, YeÅŸil BarÄ±ÅŸ VillalarÄ±, 3346. Cd No: 35 D:172"
-- Proposed: "Alacaatlı, Yeşil Barış Villaları, 3346. Cd No: 35 D:172"
UPDATE `schools` SET `address1` = CONVERT(X'416C61636161746CC4B12C205965C59F696C20426172C4B1C59F2056696C6C616C6172C4B12C20333334362E204364204E6F3A20333520443A313732' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28896 AND CAST(`address1` AS BINARY) = X'416C61636161746CC384C2B12C205965C385C5B8696C20426172C384C2B1C385C5B82056696C6C616C6172C384C2B12C20333334362E204364204E6F3A20333520443A313732';

-- Entry 863: school id 28897, column `address1`, deleted=no
-- School (as reported): "Montessori Coop Istanbul"
-- Original: "5. Gazeteciler Sitesi  AÃ§elya Sokak No 3"
-- Proposed: "5. Gazeteciler Sitesi  Açelya Sokak No 3"
UPDATE `schools` SET `address1` = CONVERT(X'352E2047617A65746563696C657220536974657369202041C3A7656C796120536F6B616B204E6F2033' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28897 AND CAST(`address1` AS BINARY) = X'352E2047617A65746563696C657220536974657369202041C383C2A7656C796120536F6B616B204E6F2033';

-- Entry 864: school id 28898, column `headofschoolname`, deleted=no
-- School (as reported): "KuÄŸulu Montessori School- Oran Mah."
-- Original: "YADIGAR IÅžILDAR"
-- Proposed: "YADIGAR IŞILDAR"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'594144494741522049C59E494C444152' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28898 AND CAST(`headofschoolname` AS BINARY) = X'594144494741522049C385C5BE494C444152';

-- Entry 865: school id 28899, column `headofschoolname`, deleted=no
-- School (as reported): "KuÄŸulu Montessori School- AlacaatlÄ± Mah."
-- Original: "YADIGAR IÅžILDAR"
-- Proposed: "YADIGAR IŞILDAR"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'594144494741522049C59E494C444152' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28899 AND CAST(`headofschoolname` AS BINARY) = X'594144494741522049C385C5BE494C444152';

-- Entry 866: school id 28900, column `address2`, deleted=yes
-- School (as reported): "KuÄŸulu Montessori School- AlacaatlÄ± Mah"
-- Original: "eÅŸil BarÄ±ÅŸ Sitesi No:164"
-- Proposed: "eşil Barış Sitesi No:164"
UPDATE `schools` SET `address2` = CONVERT(X'65C59F696C20426172C4B1C59F20536974657369204E6F3A313634' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28900 AND CAST(`address2` AS BINARY) = X'65C385C5B8696C20426172C384C2B1C385C5B820536974657369204E6F3A313634';

-- Entry 867: school id 28900, column `city`, deleted=yes
-- School (as reported): "KuÄŸulu Montessori School- AlacaatlÄ± Mah"
-- Original: "Ã‡ankaya ANKARA"
-- Proposed: "Çankaya ANKARA"
UPDATE `schools` SET `city` = CONVERT(X'C387616E6B61796120414E4B415241' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28900 AND CAST(`city` AS BINARY) = X'C383E280A1616E6B61796120414E4B415241';

-- Entry 868: school id 28900, column `headofschoolname`, deleted=yes
-- School (as reported): "KuÄŸulu Montessori School- AlacaatlÄ± Mah"
-- Original: "YADIGAR IÅžILDAR"
-- Proposed: "YADIGAR IŞILDAR"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'594144494741522049C59E494C444152' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28900 AND CAST(`headofschoolname` AS BINARY) = X'594144494741522049C385C5BE494C444152';

-- Entry 869: school id 28901, column `address1`, deleted=no
-- School (as reported): "Florya Erken Basari Montessori Okulu"
-- Original: "ÅženlikkÃ¶y, Yunus Emre Sk. No:6"
-- Proposed: "Şenlikköy, Yunus Emre Sk. No:6"
UPDATE `schools` SET `address1` = CONVERT(X'C59E656E6C696B6BC3B6792C2059756E757320456D726520536B2E204E6F3A36' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28901 AND CAST(`address1` AS BINARY) = X'C385C5BE656E6C696B6BC383C2B6792C2059756E757320456D726520536B2E204E6F3A36';

-- Entry 870: school id 28905, column `address1`, deleted=no
-- School (as reported): "EkinkÃ¶y Montessori Anaokulu"
-- Original: "Ã‡atalmeÅŸe mah. Akdeniz st. 164.sok. No:4 AlemdaÄŸ"
-- Proposed: "Çatalmeşe mah. Akdeniz st. 164.sok. No:4 Alemdağ"
UPDATE `schools` SET `address1` = CONVERT(X'C3876174616C6D65C59F65206D61682E20416B64656E697A2073742E203136342E736F6B2E204E6F3A3420416C656D6461C49F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28905 AND CAST(`address1` AS BINARY) = X'C383E280A16174616C6D65C385C5B865206D61682E20416B64656E697A2073742E203136342E736F6B2E204E6F3A3420416C656D6461C384C5B8';

-- Entry 871: school id 28905, column `schoolname`, deleted=no
-- School (as reported): "EkinkÃ¶y Montessori Anaokulu"
-- Original: "EkinkÃ¶y Montessori Anaokulu"
-- Proposed: "Ekinköy Montessori Anaokulu"
UPDATE `schools` SET `schoolname` = CONVERT(X'456B696E6BC3B679204D6F6E746573736F726920416E616F6B756C75' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28905 AND CAST(`schoolname` AS BINARY) = X'456B696E6BC383C2B679204D6F6E746573736F726920416E616F6B756C75';

-- Entry 872: school id 28906, column `address1`, deleted=no
-- School (as reported): "Bir Montessori Anaokulu"
-- Original: "AtakÃ¶y 3-4-11"
-- Proposed: "Ataköy 3-4-11"
UPDATE `schools` SET `address1` = CONVERT(X'4174616BC3B67920332D342D3131' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28906 AND CAST(`address1` AS BINARY) = X'4174616BC383C2B67920332D342D3131';

-- Entry 873: school id 28906, column `address2`, deleted=no
-- School (as reported): "Bir Montessori Anaokulu"
-- Original: "AtakÃ¶y 5. KÄ±sÄ±m KavÅŸaÄŸÄ±"
-- Proposed: "Ataköy 5. Kısım Kavşağı"
UPDATE `schools` SET `address2` = CONVERT(X'4174616BC3B67920352E204BC4B173C4B16D204B6176C59F61C49FC4B1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28906 AND CAST(`address2` AS BINARY) = X'4174616BC383C2B67920352E204BC384C2B173C384C2B16D204B6176C385C5B861C384C5B8C384C2B1';

-- Entry 874: school id 28906, column `city`, deleted=no
-- School (as reported): "Bir Montessori Anaokulu"
-- Original: "BakÄ±rkÃ¶y/Ä°stanbul"
-- Proposed: "Bakırköy/İstanbul"
UPDATE `schools` SET `city` = CONVERT(X'42616BC4B1726BC3B6792FC4B07374616E62756C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28906 AND CAST(`city` AS BINARY) = X'42616BC384C2B1726BC383C2B6792FC384C2B07374616E62756C';

-- Entry 875: school id 28956, column `schoolname`, deleted=no
-- School (as reported): "Les Petites Etoiles Bilingual Montessori â€“ West Hampstead"
-- Original: "Les Petites Etoiles Bilingual Montessori â€“ West Hampstead"
-- Proposed: "Les Petites Etoiles Bilingual Montessori – West Hampstead"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C657320506574697465732045746F696C65732042696C696E6775616C204D6F6E746573736F726920E2809320576573742048616D707374656164' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 28956 AND CAST(`schoolname` AS BINARY) = X'4C657320506574697465732045746F696C65732042696C696E6775616C204D6F6E746573736F726920C3A2E282ACE2809C20576573742048616D707374656164';

-- Entry 876: school id 29029, column `address1`, deleted=no
-- School (as reported): "Colourbox Montessori at St. Christopher's - Red Lodge"
-- Original: "St Christopherâ€™s CEVP School, "
-- Decoded (before cleanup): "St Christopher’s CEVP School, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "St Christopher’s CEVP School,"
UPDATE `schools` SET `address1` = CONVERT(X'5374204368726973746F70686572E28099732043455650205363686F6F6C2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29029 AND CAST(`address1` AS BINARY) = X'5374204368726973746F70686572C3A2E282ACE284A2732043455650205363686F6F6C2C20';

-- Entry 877: school id 29045, column `address1`, deleted=no
-- School (as reported): "Beehive Montessori School"
-- Original: "St Michaelâ€™s Church Hall, Sycamore Rd, "
-- Decoded (before cleanup): "St Michael’s Church Hall, Sycamore Rd, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "St Michael’s Church Hall, Sycamore Rd,"
UPDATE `schools` SET `address1` = CONVERT(X'5374204D69636861656CE2809973204368757263682048616C6C2C20537963616D6F72652052642C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29045 AND CAST(`address1` AS BINARY) = X'5374204D69636861656CC3A2E282ACE284A273204368757263682048616C6C2C20537963616D6F72652052642C20';

-- Entry 878: school id 29060, column `address1`, deleted=no
-- School (as reported): "Montessori Laurel- Taller"
-- Original: "Av. 6, Ricardo Monges LÃ³pez 12, "
-- Decoded (before cleanup): "Av. 6, Ricardo Monges López 12, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Av. 6, Ricardo Monges López 12,"
UPDATE `schools` SET `address1` = CONVERT(X'41762E20362C205269636172646F204D6F6E676573204CC3B370657A2031322C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29060 AND CAST(`address1` AS BINARY) = X'41762E20362C205269636172646F204D6F6E676573204CC383C2B370657A2031322C20';

-- Entry 879: school id 29060, column `city`, deleted=no
-- School (as reported): "Montessori Laurel- Taller"
-- Original: "Petrolera TaxqueÃ±a"
-- Proposed: "Petrolera Taxqueña"
UPDATE `schools` SET `city` = CONVERT(X'506574726F6C65726120546178717565C3B161' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29060 AND CAST(`city` AS BINARY) = X'506574726F6C65726120546178717565C383C2B161';

-- Entry 880: school id 29064, column `city`, deleted=no
-- School (as reported): "Colegio Montessori Atlixco"
-- Original: "San AgustÃ­n Ixtahuixtla"
-- Proposed: "San Agustín Ixtahuixtla"
UPDATE `schools` SET `city` = CONVERT(X'53616E204167757374C3AD6E204978746168756978746C61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29064 AND CAST(`city` AS BINARY) = X'53616E204167757374C383C2AD6E204978746168756978746C61';

-- Entry 881: school id 29078, column `address1`, deleted=no
-- School (as reported): "Colegio Montessori de Tepoztlan- Queretaro Campus"
-- Original: "76229 Santiago de QuerÃ©taro, "
-- Decoded (before cleanup): "76229 Santiago de Querétaro, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "76229 Santiago de Querétaro,"
UPDATE `schools` SET `address1` = CONVERT(X'37363232392053616E746961676F2064652051756572C3A97461726F2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29078 AND CAST(`address1` AS BINARY) = X'37363232392053616E746961676F2064652051756572C383C2A97461726F2C20';

-- Entry 882: school id 29078, column `city`, deleted=no
-- School (as reported): "Colegio Montessori de Tepoztlan- Queretaro Campus"
-- Original: "QuerÃ©taro"
-- Proposed: "Querétaro"
UPDATE `schools` SET `city` = CONVERT(X'51756572C3A97461726F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29078 AND CAST(`city` AS BINARY) = X'51756572C383C2A97461726F';

-- Entry 883: school id 29084, column `address1`, deleted=yes
-- School (as reported): "My School Redmount"
-- Original: "Cda. Parque de AlcÃ¡zar 6, Fracc. JardÃ­nes de la Herradura., Mexico City, Mexico"
-- Proposed: "Cda. Parque de Alcázar 6, Fracc. Jardínes de la Herradura., Mexico City, Mexico"
UPDATE `schools` SET `address1` = CONVERT(X'4364612E2050617271756520646520416C63C3A17A617220362C2046726163632E204A617264C3AD6E6573206465206C61204865727261647572612E2C204D657869636F20436974792C204D657869636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29084 AND CAST(`address1` AS BINARY) = X'4364612E2050617271756520646520416C63C383C2A17A617220362C2046726163632E204A617264C383C2AD6E6573206465206C61204865727261647572612E2C204D657869636F20436974792C204D657869636F';

-- Entry 884: school id 29084, column `city`, deleted=yes
-- School (as reported): "My School Redmount"
-- Original: "Fracc. JardÃ­nes de la Herradura"
-- Proposed: "Fracc. Jardínes de la Herradura"
UPDATE `schools` SET `city` = CONVERT(X'46726163632E204A617264C3AD6E6573206465206C6120486572726164757261' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29084 AND CAST(`city` AS BINARY) = X'46726163632E204A617264C383C2AD6E6573206465206C6120486572726164757261';

-- Entry 885: school id 29090, column `address1`, deleted=no
-- School (as reported): "Montessori FMO"
-- Original: "P.Âº del Bosque 71-Mz 35 Lt 14, "
-- Decoded (before cleanup): "P.º del Bosque 71-Mz 35 Lt 14, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "P.º del Bosque 71-Mz 35 Lt 14,"
UPDATE `schools` SET `address1` = CONVERT(X'502EC2BA2064656C20426F737175652037312D4D7A203335204C742031342C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29090 AND CAST(`address1` AS BINARY) = X'502EC382C2BA2064656C20426F737175652037312D4D7A203335204C742031342C20';

-- Entry 886: school id 29092, column `city`, deleted=no
-- School (as reported): "Montessori Kalpilli"
-- Original: "Benito JuÃ¡rez"
-- Proposed: "Benito Juárez"
UPDATE `schools` SET `city` = CONVERT(X'42656E69746F204A75C3A172657A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29092 AND CAST(`city` AS BINARY) = X'42656E69746F204A75C383C2A172657A';

-- Entry 887: school id 29096, column `address1`, deleted=no
-- School (as reported): "Lantana Montessori International- Campus Arboleda"
-- Original: "Boulevard Sofia 609 Interior A-2-209, 66265 San Pedro Garza GarcÃ­a, N.L., Mexico"
-- Proposed: "Boulevard Sofia 609 Interior A-2-209, 66265 San Pedro Garza García, N.L., Mexico"
UPDATE `schools` SET `address1` = CONVERT(X'426F756C657661726420536F6669612036303920496E746572696F7220412D322D3230392C2036363236352053616E20506564726F204761727A612047617263C3AD612C204E2E4C2E2C204D657869636F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29096 AND CAST(`address1` AS BINARY) = X'426F756C657661726420536F6669612036303920496E746572696F7220412D322D3230392C2036363236352053616E20506564726F204761727A612047617263C383C2AD612C204E2E4C2E2C204D657869636F';

-- Entry 888: school id 29096, column `city`, deleted=no
-- School (as reported): "Lantana Montessori International- Campus Arboleda"
-- Original: "San Pedro Garza GarcÃ­a"
-- Proposed: "San Pedro Garza García"
UPDATE `schools` SET `city` = CONVERT(X'53616E20506564726F204761727A612047617263C3AD61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29096 AND CAST(`city` AS BINARY) = X'53616E20506564726F204761727A612047617263C383C2AD61';

-- Entry 889: school id 29097, column `address1`, deleted=no
-- School (as reported): "MOSED- Montessori Servicios Educativos"
-- Original: "Calz Montessori 201, Ejido la UniÃ³n,TorreÃ³n, "
-- Decoded (before cleanup): "Calz Montessori 201, Ejido la Unión,Torreón, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Calz Montessori 201, Ejido la Unión,Torreón,"
UPDATE `schools` SET `address1` = CONVERT(X'43616C7A204D6F6E746573736F7269203230312C20456A69646F206C6120556E69C3B36E2C546F727265C3B36E2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29097 AND CAST(`address1` AS BINARY) = X'43616C7A204D6F6E746573736F7269203230312C20456A69646F206C6120556E69C383C2B36E2C546F727265C383C2B36E2C20';

-- Entry 890: school id 29104, column `address1`, deleted=no
-- School (as reported): "IPM Montessori Satellite"
-- Original: "Cto HÃ©roes 30, Cd. "
-- Decoded (before cleanup): "Cto Héroes 30, Cd. "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Cto Héroes 30, Cd."
UPDATE `schools` SET `address1` = CONVERT(X'43746F2048C3A9726F65732033302C2043642E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29104 AND CAST(`address1` AS BINARY) = X'43746F2048C383C2A9726F65732033302C2043642E20';

-- Entry 891: school id 29104, column `city`, deleted=no
-- School (as reported): "IPM Montessori Satellite"
-- Original: "SatÃ©lite"
-- Proposed: "Satélite"
UPDATE `schools` SET `city` = CONVERT(X'536174C3A96C697465' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29104 AND CAST(`city` AS BINARY) = X'536174C383C2A96C697465';

-- Entry 892: school id 29113, column `address1`, deleted=no
-- School (as reported): "IPM Montessori Bosques de las Lomas"
-- Original: "Bosques de Alisos 5, Col. Bosques de las Lomas, AlcaldÃ­a. "
-- Decoded (before cleanup): "Bosques de Alisos 5, Col. Bosques de las Lomas, Alcaldía. "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Bosques de Alisos 5, Col. Bosques de las Lomas, Alcaldía."
UPDATE `schools` SET `address1` = CONVERT(X'426F737175657320646520416C69736F7320352C20436F6C2E20426F7371756573206465206C6173204C6F6D61732C20416C63616C64C3AD612E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29113 AND CAST(`address1` AS BINARY) = X'426F737175657320646520416C69736F7320352C20436F6C2E20426F7371756573206465206C6173204C6F6D61732C20416C63616C64C383C2AD612E20';

-- Entry 893: school id 29116, column `address1`, deleted=no
-- School (as reported): "Chiaravalle Montessori School- Leon, Gto."
-- Original: "Av. Los ParaÃ­sos 701, "
-- Decoded (before cleanup): "Av. Los Paraísos 701, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Av. Los Paraísos 701,"
UPDATE `schools` SET `address1` = CONVERT(X'41762E204C6F732050617261C3AD736F73203730312C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29116 AND CAST(`address1` AS BINARY) = X'41762E204C6F732050617261C383C2AD736F73203730312C20';

-- Entry 894: school id 29117, column `city`, deleted=no
-- School (as reported): "Centro Montessori de Leon"
-- Original: "LeÃ³n de los Aldama"
-- Proposed: "León de los Aldama"
UPDATE `schools` SET `city` = CONVERT(X'4C65C3B36E206465206C6F7320416C64616D61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29117 AND CAST(`city` AS BINARY) = X'4C65C383C2B36E206465206C6F7320416C64616D61';

-- Entry 895: school id 29120, column `address1`, deleted=no
-- School (as reported): "Montessori Lomas"
-- Original: "C. Santana 6248, Reserva Territorial AtlixcÃ¡yotl, "
-- Decoded (before cleanup): "C. Santana 6248, Reserva Territorial Atlixcáyotl, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "C. Santana 6248, Reserva Territorial Atlixcáyotl,"
UPDATE `schools` SET `address1` = CONVERT(X'432E2053616E74616E6120363234382C2052657365727661205465727269746F7269616C2041746C697863C3A1796F746C2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29120 AND CAST(`address1` AS BINARY) = X'432E2053616E74616E6120363234382C2052657365727661205465727269746F7269616C2041746C697863C383C2A1796F746C2C20';

-- Entry 896: school id 29135, column `schoolname`, deleted=no
-- School (as reported): "Centro Preescolar ColorÃ­n Colorado"
-- Original: "Centro Preescolar ColorÃ­n Colorado"
-- Proposed: "Centro Preescolar Colorín Colorado"
UPDATE `schools` SET `schoolname` = CONVERT(X'43656E74726F205072656573636F6C617220436F6C6F72C3AD6E20436F6C6F7261646F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29135 AND CAST(`schoolname` AS BINARY) = X'43656E74726F205072656573636F6C617220436F6C6F72C383C2AD6E20436F6C6F7261646F';

-- Entry 897: school id 29161, column `address1`, deleted=no
-- School (as reported): "Colegio Maria de la Altagracia"
-- Original: "J73G+8W6, C. RubÃ­,"
-- Proposed: "J73G+8W6, C. Rubí,"
UPDATE `schools` SET `address1` = CONVERT(X'4A3733472B3857362C20432E20527562C3AD2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29161 AND CAST(`address1` AS BINARY) = X'4A3733472B3857362C20432E20527562C383C2AD2C';

-- Entry 898: school id 29161, column `city`, deleted=no
-- School (as reported): "Colegio Maria de la Altagracia"
-- Original: "HigÃ¼ey "
-- Decoded (before cleanup): "Higüey "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Higüey"
UPDATE `schools` SET `city` = CONVERT(X'486967C3BC6579' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29161 AND CAST(`city` AS BINARY) = X'486967C383C2BC657920';

-- Entry 899: school id 29184, column `city`, deleted=no
-- School (as reported): "MIS- Montessori International School"
-- Original: " SÃ£o Paulo"
-- Decoded (before cleanup): " São Paulo"
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "São Paulo"
UPDATE `schools` SET `city` = CONVERT(X'53C3A36F205061756C6F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29184 AND CAST(`city` AS BINARY) = X'2053C383C2A36F205061756C6F';

-- Entry 900: school id 29186, column `address1`, deleted=no
-- School (as reported): "Colegio Maria Montessori"
-- Original: "Rua JoÃ£o Paulo I, 30"
-- Proposed: "Rua João Paulo I, 30"
UPDATE `schools` SET `address1` = CONVERT(X'527561204A6FC3A36F205061756C6F20492C203330' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29186 AND CAST(`address1` AS BINARY) = X'527561204A6FC383C2A36F205061756C6F20492C203330';

-- Entry 901: school id 29186, column `address2`, deleted=no
-- School (as reported): "Colegio Maria Montessori"
-- Original: "Gruta de Lourdes, MaceiÃ³"
-- Proposed: "Gruta de Lourdes, Maceió"
UPDATE `schools` SET `address2` = CONVERT(X'4772757461206465204C6F75726465732C204D61636569C3B3' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29186 AND CAST(`address2` AS BINARY) = X'4772757461206465204C6F75726465732C204D61636569C383C2B3';

-- Entry 902: school id 29188, column `address1`, deleted=no
-- School (as reported): "Lar Montessoriano Educacao Para a Vida"
-- Original: "Av. Serzedelo CorrÃªa, 332"
-- Proposed: "Av. Serzedelo Corrêa, 332"
UPDATE `schools` SET `address1` = CONVERT(X'41762E205365727A6564656C6F20436F7272C3AA612C20333332' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29188 AND CAST(`address1` AS BINARY) = X'41762E205365727A6564656C6F20436F7272C383C2AA612C20333332';

-- Entry 903: school id 29188, column `city`, deleted=no
-- School (as reported): "Lar Montessoriano Educacao Para a Vida"
-- Original: "BelÃ©m, PA"
-- Proposed: "Belém, PA"
UPDATE `schools` SET `city` = CONVERT(X'42656CC3A96D2C205041' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29188 AND CAST(`city` AS BINARY) = X'42656CC383C2A96D2C205041';

-- Entry 904: school id 29190, column `address2`, deleted=no
-- School (as reported): "Mundo Montessori- Peteleco"
-- Original: "Reduto - BelÃ©m"
-- Proposed: "Reduto - Belém"
UPDATE `schools` SET `address2` = CONVERT(X'52656475746F202D2042656CC3A96D' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29190 AND CAST(`address2` AS BINARY) = X'52656475746F202D2042656CC383C2A96D';

-- Entry 905: school id 29190, column `city`, deleted=no
-- School (as reported): "Mundo Montessori- Peteleco"
-- Original: "ParÃ¡"
-- Proposed: "Pará"
UPDATE `schools` SET `city` = CONVERT(X'506172C3A1' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29190 AND CAST(`city` AS BINARY) = X'506172C383C2A1';

-- Entry 906: school id 29195, column `address1`, deleted=no
-- School (as reported): "Comunidad Montessori- Hummingbird Garden"
-- Original: "Eleuterio RamÃ­rez 1345, ValparaÃ­so, QuilpuÃ©, "
-- Decoded (before cleanup): "Eleuterio Ramírez 1345, Valparaíso, Quilpué, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Eleuterio Ramírez 1345, Valparaíso, Quilpué,"
UPDATE `schools` SET `address1` = CONVERT(X'456C6575746572696F2052616DC3AD72657A20313334352C2056616C70617261C3AD736F2C205175696C7075C3A92C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29195 AND CAST(`address1` AS BINARY) = X'456C6575746572696F2052616DC383C2AD72657A20313334352C2056616C70617261C383C2AD736F2C205175696C7075C383C2A92C20';

-- Entry 907: school id 29195, column `city`, deleted=no
-- School (as reported): "Comunidad Montessori- Hummingbird Garden"
-- Original: "ValparaÃ­so"
-- Proposed: "Valparaíso"
UPDATE `schools` SET `city` = CONVERT(X'56616C70617261C3AD736F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29195 AND CAST(`city` AS BINARY) = X'56616C70617261C383C2AD736F';

-- Entry 908: school id 29196, column `address1`, deleted=no
-- School (as reported): "Comunidad Montessori- Colegio Yerpun"
-- Original: "Eleuterio RamÃ­rez 1323, "
-- Decoded (before cleanup): "Eleuterio Ramírez 1323, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Eleuterio Ramírez 1323,"
UPDATE `schools` SET `address1` = CONVERT(X'456C6575746572696F2052616DC3AD72657A20313332332C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29196 AND CAST(`address1` AS BINARY) = X'456C6575746572696F2052616DC383C2AD72657A20313332332C20';

-- Entry 909: school id 29196, column `city`, deleted=no
-- School (as reported): "Comunidad Montessori- Colegio Yerpun"
-- Original: "ValparaÃ­so"
-- Proposed: "Valparaíso"
UPDATE `schools` SET `city` = CONVERT(X'56616C70617261C3AD736F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29196 AND CAST(`city` AS BINARY) = X'56616C70617261C383C2AD736F';

-- Entry 910: school id 29200, column `city`, deleted=no
-- School (as reported): "Casa Montessori Cerro Alegre"
-- Original: "ValparaÃ­so"
-- Proposed: "Valparaíso"
UPDATE `schools` SET `city` = CONVERT(X'56616C70617261C3AD736F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29200 AND CAST(`city` AS BINARY) = X'56616C70617261C383C2AD736F';

-- Entry 911: school id 29210, column `address1`, deleted=no
-- School (as reported): "Sala Cuna y Jardin Infantil Montessori- Ayudame a Hacerlo Solo"
-- Original: "O'Higgins # 1518 ConcepciÃ³n"
-- Proposed: "O'Higgins # 1518 Concepción"
UPDATE `schools` SET `address1` = CONVERT(X'4F2748696767696E732023203135313820436F6E6365706369C3B36E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29210 AND CAST(`address1` AS BINARY) = X'4F2748696767696E732023203135313820436F6E6365706369C383C2B36E';

-- Entry 912: school id 29211, column `address1`, deleted=no
-- School (as reported): "El Trebol Centro Educativo"
-- Original: "Panamericana Norte No. 69-195 and JesÃºs del Gran Poder Km. 10 "
-- Decoded (before cleanup): "Panamericana Norte No. 69-195 and Jesús del Gran Poder Km. 10 "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Panamericana Norte No. 69-195 and Jesús del Gran Poder Km. 10"
UPDATE `schools` SET `address1` = CONVERT(X'50616E616D65726963616E61204E6F727465204E6F2E2036392D31393520616E64204A6573C3BA732064656C204772616E20506F646572204B6D2E203130' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29211 AND CAST(`address1` AS BINARY) = X'50616E616D65726963616E61204E6F727465204E6F2E2036392D31393520616E64204A6573C383C2BA732064656C204772616E20506F646572204B6D2E20313020';

-- Entry 913: school id 29212, column `city`, deleted=no
-- School (as reported): "Montessori Little Stars"
-- Original: "LambarÃ©"
-- Proposed: "Lambaré"
UPDATE `schools` SET `city` = CONVERT(X'4C616D626172C3A9' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29212 AND CAST(`city` AS BINARY) = X'4C616D626172C383C2A9';

-- Entry 914: school id 29249, column `address1`, deleted=no
-- School (as reported): "Pangea Escuela Viva"
-- Original: "C. de Santiago ApÃ³stol, 9,"
-- Proposed: "C. de Santiago Apóstol, 9,"
UPDATE `schools` SET `address1` = CONVERT(X'432E2064652053616E746961676F204170C3B373746F6C2C20392C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29249 AND CAST(`address1` AS BINARY) = X'432E2064652053616E746961676F204170C383C2B373746F6C2C20392C';

-- Entry 915: school id 29286, column `schoolname`, deleted=no
-- School (as reported): "Learn and PlayÂ® Montessori School & Child Care Hercules"
-- Original: "Learn and PlayÂ® Montessori School & Child Care Hercules"
-- Proposed: "Learn and Play® Montessori School & Child Care Hercules"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C6561726E20616E6420506C6179C2AE204D6F6E746573736F7269205363686F6F6C2026204368696C6420436172652048657263756C6573' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29286 AND CAST(`schoolname` AS BINARY) = X'4C6561726E20616E6420506C6179C382C2AE204D6F6E746573736F7269205363686F6F6C2026204368696C6420436172652048657263756C6573';

-- Entry 916: school id 29306, column `address1`, deleted=no
-- School (as reported): "Kinder Happy Kids Montessori Sports"
-- Original: "Subway 100 sur, Barrio JosÃ© MarÃ­a ZeledÃ³n, de R, San JosÃ©, "
-- Decoded (before cleanup): "Subway 100 sur, Barrio José María Zeledón, de R, San José, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Subway 100 sur, Barrio José María Zeledón, de R, San José,"
UPDATE `schools` SET `address1` = CONVERT(X'53756277617920313030207375722C2042617272696F204A6F73C3A9204D6172C3AD61205A656C6564C3B36E2C20646520522C2053616E204A6F73C3A92C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29306 AND CAST(`address1` AS BINARY) = X'53756277617920313030207375722C2042617272696F204A6F73C383C2A9204D6172C383C2AD61205A656C6564C383C2B36E2C20646520522C2053616E204A6F73C383C2A92C20';

-- Entry 917: school id 29310, column `address1`, deleted=no
-- School (as reported): "Lumi Casa Montessori"
-- Original: "Del Restaurante ceviche del Rey 300 mts Norte 200 mts este y 50 mts Sur, San JosÃ©, "
-- Decoded (before cleanup): "Del Restaurante ceviche del Rey 300 mts Norte 200 mts este y 50 mts Sur, San José, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Del Restaurante ceviche del Rey 300 mts Norte 200 mts este y 50 mts Sur, San José,"
UPDATE `schools` SET `address1` = CONVERT(X'44656C2052657374617572616E746520636576696368652064656C2052657920333030206D7473204E6F72746520323030206D747320657374652079203530206D7473205375722C2053616E204A6F73C3A92C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29310 AND CAST(`address1` AS BINARY) = X'44656C2052657374617572616E746520636576696368652064656C2052657920333030206D7473204E6F72746520323030206D747320657374652079203530206D7473205375722C2053616E204A6F73C383C2A92C20';

-- Entry 918: school id 29321, column `address1`, deleted=no
-- School (as reported): "Centro Integral Los Olivos"
-- Original: "300 este de la Clinica Carlos DurÃ¡n, sobre radial a Zapote., "
-- Decoded (before cleanup): "300 este de la Clinica Carlos Durán, sobre radial a Zapote., "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "300 este de la Clinica Carlos Durán, sobre radial a Zapote.,"
UPDATE `schools` SET `address1` = CONVERT(X'3330302065737465206465206C6120436C696E696361204361726C6F7320447572C3A16E2C20736F6272652072616469616C2061205A61706F74652E2C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29321 AND CAST(`address1` AS BINARY) = X'3330302065737465206465206C6120436C696E696361204361726C6F7320447572C383C2A16E2C20736F6272652072616469616C2061205A61706F74652E2C20';

-- Entry 919: school id 29323, column `schoolname`, deleted=no
-- School (as reported): "SipÃ² Educativo "
-- Original: "SipÃ² Educativo "
-- Decoded (before cleanup): "Sipò Educativo "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Sipò Educativo"
UPDATE `schools` SET `schoolname` = CONVERT(X'536970C3B22045647563617469766F' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29323 AND CAST(`schoolname` AS BINARY) = X'536970C383C2B22045647563617469766F20';

-- Entry 920: school id 29328, column `schoolname`, deleted=no
-- School (as reported): "Casa de NiÃ±os Playa Hermosa"
-- Original: "Casa de NiÃ±os Playa Hermosa"
-- Proposed: "Casa de Niños Playa Hermosa"
UPDATE `schools` SET `schoolname` = CONVERT(X'43617361206465204E69C3B16F7320506C617961204865726D6F7361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29328 AND CAST(`schoolname` AS BINARY) = X'43617361206465204E69C383C2B16F7320506C617961204865726D6F7361';

-- Entry 921: school id 29329, column `address1`, deleted=no
-- School (as reported): "Mies Montessori Christian School"
-- Original: "Blvd. Central San MartÃ­n, Provincia de Guanacaste, Nicoya, "
-- Decoded (before cleanup): "Blvd. Central San Martín, Provincia de Guanacaste, Nicoya, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Blvd. Central San Martín, Provincia de Guanacaste, Nicoya,"
UPDATE `schools` SET `address1` = CONVERT(X'426C76642E2043656E7472616C2053616E204D617274C3AD6E2C2050726F76696E636961206465204775616E6163617374652C204E69636F79612C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29329 AND CAST(`address1` AS BINARY) = X'426C76642E2043656E7472616C2053616E204D617274C383C2AD6E2C2050726F76696E636961206465204775616E6163617374652C204E69636F79612C20';

-- Entry 922: school id 29329, column `city`, deleted=no
-- School (as reported): "Mies Montessori Christian School"
-- Original: "San MartÃ­n"
-- Proposed: "San Martín"
UPDATE `schools` SET `city` = CONVERT(X'53616E204D617274C3AD6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29329 AND CAST(`city` AS BINARY) = X'53616E204D617274C383C2AD6E';

-- Entry 923: school id 29338, column `address1`, deleted=no
-- School (as reported): "Centro Montessori Ara Macao"
-- Original: "frente al costado de Hospital Los Ãngles, "
-- Decoded (before cleanup): "frente al costado de Hospital Los Ángles, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "frente al costado de Hospital Los Ángles,"
UPDATE `schools` SET `address1` = CONVERT(X'6672656E746520616C20636F737461646F20646520486F73706974616C204C6F7320C3816E676C65732C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29338 AND CAST(`address1` AS BINARY) = X'6672656E746520616C20636F737461646F20646520486F73706974616C204C6F7320C383C2816E676C65732C20';

-- Entry 924: school id 29338, column `address2`, deleted=no
-- School (as reported): "Centro Montessori Ara Macao"
-- Original: "7ma. calle N.E. BÂ° Mercedes, "
-- Decoded (before cleanup): "7ma. calle N.E. B° Mercedes, "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "7ma. calle N.E. B° Mercedes,"
UPDATE `schools` SET `address2` = CONVERT(X'376D612E2063616C6C65204E2E452E2042C2B0204D657263656465732C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29338 AND CAST(`address2` AS BINARY) = X'376D612E2063616C6C65204E2E452E2042C382C2B0204D657263656465732C20';

-- Entry 925: school id 29345, column `schoolname`, deleted=no
-- School (as reported): "Colegio JardÃ­n Montessori de Cojutepeque"
-- Original: "Colegio JardÃ­n Montessori de Cojutepeque"
-- Proposed: "Colegio Jardín Montessori de Cojutepeque"
UPDATE `schools` SET `schoolname` = CONVERT(X'436F6C6567696F204A617264C3AD6E204D6F6E746573736F726920646520436F6A7574657065717565' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29345 AND CAST(`schoolname` AS BINARY) = X'436F6C6567696F204A617264C383C2AD6E204D6F6E746573736F726920646520436F6A7574657065717565';

-- Entry 926: school id 29346, column `schoolname`, deleted=no
-- School (as reported): "Escuela de EducaciÃ³n Parvularia Maria Montessori "
-- Original: "Escuela de EducaciÃ³n Parvularia Maria Montessori "
-- Decoded (before cleanup): "Escuela de Educación Parvularia Maria Montessori "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Escuela de Educación Parvularia Maria Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'45736375656C612064652045647563616369C3B36E2050617276756C61726961204D61726961204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29346 AND CAST(`schoolname` AS BINARY) = X'45736375656C612064652045647563616369C383C2B36E2050617276756C61726961204D61726961204D6F6E746573736F726920';

-- Entry 927: school id 29521, column `contactname`, deleted=no
-- School (as reported): "Cape Farm Montessori Preschool"
-- Original: "Sandra HÃ¶llermann"
-- Proposed: "Sandra Höllermann"
UPDATE `schools` SET `contactname` = CONVERT(X'53616E6472612048C3B66C6C65726D616E6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29521 AND CAST(`contactname` AS BINARY) = X'53616E6472612048C383C2B66C6C65726D616E6E';

-- Entry 928: school id 29640, column `address1`, deleted=no
-- School (as reported): "Ã–zel Montessori Anaokulu KreÅŸ ve Sanat Akademisi "
-- Original: "DÄ±ÅŸ kapÄ±, HafÄ±ziye Mahallesi 2 Nisan Caddesi, BirgÃ¼l 1. Sk. No:2,"
-- Proposed: "Dış kapı, Hafıziye Mahallesi 2 Nisan Caddesi, Birgül 1. Sk. No:2,"
UPDATE `schools` SET `address1` = CONVERT(X'44C4B1C59F206B6170C4B12C20486166C4B17A697965204D6168616C6C6573692032204E6973616E20436164646573692C2042697267C3BC6C20312E20536B2E204E6F3A322C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29640 AND CAST(`address1` AS BINARY) = X'44C384C2B1C385C5B8206B6170C384C2B12C20486166C384C2B17A697965204D6168616C6C6573692032204E6973616E20436164646573692C2042697267C383C2BC6C20312E20536B2E204E6F3A322C';

-- Entry 929: school id 29640, column `schoolname`, deleted=no
-- School (as reported): "Ã–zel Montessori Anaokulu KreÅŸ ve Sanat Akademisi "
-- Original: "Ã–zel Montessori Anaokulu KreÅŸ ve Sanat Akademisi "
-- Decoded (before cleanup): "Özel Montessori Anaokulu Kreş ve Sanat Akademisi "
-- Cleanup: trimmed leading/trailing spaces
-- Proposed: "Özel Montessori Anaokulu Kreş ve Sanat Akademisi"
UPDATE `schools` SET `schoolname` = CONVERT(X'C3967A656C204D6F6E746573736F726920416E616F6B756C75204B7265C59F2076652053616E617420416B6164656D697369' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29640 AND CAST(`schoolname` AS BINARY) = X'C383E280937A656C204D6F6E746573736F726920416E616F6B756C75204B7265C385C5B82076652053616E617420416B6164656D69736920';

-- Entry 930: school id 29769, column `address1`, deleted=no
-- School (as reported): "Douces Maternelles- Fer a Moulin"
-- Original: "28 rue du Fer Ã  moulin"
-- Proposed: "28 rue du Fer à moulin"
UPDATE `schools` SET `address1` = CONVERT(X'3238207275652064752046657220C3A0206D6F756C696E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29769 AND CAST(`address1` AS BINARY) = X'3238207275652064752046657220C383C2A0206D6F756C696E';

-- Entry 931: school id 29784, column `schoolname`, deleted=no
-- School (as reported): "Ã‰cole Montessori Internationale D'epinal: L'art De Grandir"
-- Original: "Ã‰cole Montessori Internationale D'epinal: L'art De Grandir"
-- Proposed: "École Montessori Internationale D'epinal: L'art De Grandir"
UPDATE `schools` SET `schoolname` = CONVERT(X'C389636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C652044276570696E616C3A204C27617274204465204772616E646972' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29784 AND CAST(`schoolname` AS BINARY) = X'C383E280B0636F6C65204D6F6E746573736F726920496E7465726E6174696F6E616C652044276570696E616C3A204C27617274204465204772616E646972';

-- Entry 932: school id 29931, column `headofschoolname`, deleted=no
-- School (as reported): "Bilingual Montessori School- Los Alamos"
-- Original: "SeÃ±ora Rebekah Seitz"
-- Proposed: "Señora Rebekah Seitz"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'5365C3B16F726120526562656B616820536569747A' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29931 AND CAST(`headofschoolname` AS BINARY) = X'5365C383C2B16F726120526562656B616820536569747A';

-- Entry 933: school id 29934, column `schoolname`, deleted=no
-- School (as reported): "Los NiÃ±os Montessori"
-- Original: "Los NiÃ±os Montessori"
-- Proposed: "Los Niños Montessori"
UPDATE `schools` SET `schoolname` = CONVERT(X'4C6F73204E69C3B16F73204D6F6E746573736F7269' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29934 AND CAST(`schoolname` AS BINARY) = X'4C6F73204E69C383C2B16F73204D6F6E746573736F7269';

-- Entry 934: school id 29965, column `address1`, deleted=no
-- School (as reported): "Wi School Courbevoie MoliÃ¨re"
-- Original: "10-12 rue MoliÃ¨re"
-- Proposed: "10-12 rue Molière"
UPDATE `schools` SET `address1` = CONVERT(X'31302D313220727565204D6F6C69C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29965 AND CAST(`address1` AS BINARY) = X'31302D313220727565204D6F6C69C383C2A87265';

-- Entry 935: school id 29965, column `schoolname`, deleted=no
-- School (as reported): "Wi School Courbevoie MoliÃ¨re"
-- Original: "Wi School Courbevoie MoliÃ¨re"
-- Proposed: "Wi School Courbevoie Molière"
UPDATE `schools` SET `schoolname` = CONVERT(X'5769205363686F6F6C20436F75726265766F6965204D6F6C69C3A87265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29965 AND CAST(`schoolname` AS BINARY) = X'5769205363686F6F6C20436F75726265766F6965204D6F6C69C383C2A87265';

-- Entry 936: school id 29966, column `address1`, deleted=no
-- School (as reported): "Wi School Puteaux"
-- Original: "1 Place du ThÃ©Ã¢tre"
-- Proposed: "1 Place du Théâtre"
UPDATE `schools` SET `address1` = CONVERT(X'3120506C616365206475205468C3A9C3A2747265' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29966 AND CAST(`address1` AS BINARY) = X'3120506C616365206475205468C383C2A9C383C2A2747265';

-- Entry 937: school id 29972, column `schoolname`, deleted=no
-- School (as reported): "Montessori Harajuku Childrenâ€™s house Minami-Aoyama"
-- Original: "Montessori Harajuku Childrenâ€™s house Minami-Aoyama"
-- Proposed: "Montessori Harajuku Children’s house Minami-Aoyama"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F726920486172616A756B75204368696C6472656EE280997320686F757365204D696E616D692D416F79616D61' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29972 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F726920486172616A756B75204368696C6472656EC3A2E282ACE284A27320686F757365204D696E616D692D416F79616D61';

-- Entry 938: school id 29973, column `schoolname`, deleted=no
-- School (as reported): "Montessori Sumiregaoka Childrenâ€™s House"
-- Original: "Montessori Sumiregaoka Childrenâ€™s House"
-- Proposed: "Montessori Sumiregaoka Children’s House"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692053756D69726567616F6B61204368696C6472656EE280997320486F757365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 29973 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692053756D69726567616F6B61204368696C6472656EC3A2E282ACE284A27320486F757365';

-- Entry 939: school id 30081, column `city`, deleted=no
-- School (as reported): "Montessori Kita Herz Jesu BÃ¼chenbach"
-- Original: "BÃ¼chenbach"
-- Proposed: "Büchenbach"
UPDATE `schools` SET `city` = CONVERT(X'42C3BC6368656E62616368' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30081 AND CAST(`city` AS BINARY) = X'42C383C2BC6368656E62616368';

-- Entry 940: school id 30081, column `headofschoolname`, deleted=no
-- School (as reported): "Montessori Kita Herz Jesu BÃ¼chenbach"
-- Original: "Birgit GeÃŸler"
-- Proposed: "Birgit Geßler"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'426972676974204765C39F6C6572' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30081 AND CAST(`headofschoolname` AS BINARY) = X'426972676974204765C383C5B86C6572';

-- Entry 941: school id 30081, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kita Herz Jesu BÃ¼chenbach"
-- Original: "Montessori Kita Herz Jesu BÃ¼chenbach"
-- Proposed: "Montessori Kita Herz Jesu Büchenbach"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B697461204865727A204A6573752042C3BC6368656E62616368' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30081 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B697461204865727A204A6573752042C383C2BC6368656E62616368';

-- Entry 942: school id 30137, column `address1`, deleted=no
-- School (as reported): "Grashalm das private Montessori Kleinkinderhaus"
-- Original: "SchÃ¶nbrunner Strasse 46/7"
-- Proposed: "Schönbrunner Strasse 46/7"
UPDATE `schools` SET `address1` = CONVERT(X'536368C3B66E6272756E6E657220537472617373652034362F37' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30137 AND CAST(`address1` AS BINARY) = X'536368C383C2B66E6272756E6E657220537472617373652034362F37';

-- Entry 943: school id 30140, column `address1`, deleted=yes
-- School (as reported): "Montessori-Campus Wien HÃ¼tteldorf"
-- Original: "HÃ¼ttelbergstraÃŸe 5"
-- Proposed: "Hüttelbergstraße 5"
UPDATE `schools` SET `address1` = CONVERT(X'48C3BC7474656C6265726773747261C39F652035' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30140 AND CAST(`address1` AS BINARY) = X'48C383C2BC7474656C6265726773747261C383C5B8652035';

-- Entry 944: school id 30140, column `schoolname`, deleted=yes
-- School (as reported): "Montessori-Campus Wien HÃ¼tteldorf"
-- Original: "Montessori-Campus Wien HÃ¼tteldorf"
-- Proposed: "Montessori-Campus Wien Hütteldorf"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692D43616D707573205769656E2048C3BC7474656C646F7266' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30140 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692D43616D707573205769656E2048C383C2BC7474656C646F7266';

-- Entry 945: school id 30141, column `address1`, deleted=no
-- School (as reported): "AMAVDA Montessori"
-- Original: "Dornbacher StraÃŸe 139"
-- Proposed: "Dornbacher Straße 139"
UPDATE `schools` SET `address1` = CONVERT(X'446F726E6261636865722053747261C39F6520313339' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30141 AND CAST(`address1` AS BINARY) = X'446F726E6261636865722053747261C383C5B86520313339';

-- Entry 946: school id 30143, column `headofschoolname`, deleted=no
-- School (as reported): "Holly Go Lightly Inklusive Montessori-Privatschule"
-- Original: "Petra MÃ¥rtensson"
-- Proposed: "Petra Mårtensson"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'5065747261204DC3A57274656E73736F6E' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30143 AND CAST(`headofschoolname` AS BINARY) = X'5065747261204DC383C2A57274656E73736F6E';

-- Entry 947: school id 30151, column `address1`, deleted=yes
-- School (as reported): "Montessori fÃ¼r alle: Bildungswiese"
-- Original: "IndustriestraÃŸe 43a"
-- Proposed: "Industriestraße 43a"
UPDATE `schools` SET `address1` = CONVERT(X'496E6475737472696573747261C39F6520343361' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30151 AND CAST(`address1` AS BINARY) = X'496E6475737472696573747261C383C5B86520343361';

-- Entry 948: school id 30151, column `schoolname`, deleted=yes
-- School (as reported): "Montessori fÃ¼r alle: Bildungswiese"
-- Original: "Montessori fÃ¼r alle: Bildungswiese"
-- Proposed: "Montessori für alle: Bildungswiese"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F72692066C3BC7220616C6C653A2042696C64756E67737769657365' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30151 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F72692066C383C2BC7220616C6C653A2042696C64756E67737769657365';

-- Entry 949: school id 30171, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (GyllenstormstraÃŸe)"
-- Original: "GyllenstormstraÃŸe 1"
-- Proposed: "Gyllenstormstraße 1"
UPDATE `schools` SET `address1` = CONVERT(X'47796C6C656E73746F726D73747261C39F652031' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30171 AND CAST(`address1` AS BINARY) = X'47796C6C656E73746F726D73747261C383C5B8652031';

-- Entry 950: school id 30171, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (GyllenstormstraÃŸe)"
-- Original: "Montessori Kinderhaus Aigen (GyllenstormstraÃŸe)"
-- Proposed: "Montessori Kinderhaus Aigen (Gyllenstormstraße)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E6465726861757320416967656E202847796C6C656E73746F726D73747261C39F6529' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30171 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E6465726861757320416967656E202847796C6C656E73746F726D73747261C383C5B86529';

-- Entry 951: school id 30172, column `address1`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (TraunstraÃŸe)"
-- Original: "TraunstraÃŸe 22"
-- Proposed: "Traunstraße 22"
UPDATE `schools` SET `address1` = CONVERT(X'547261756E73747261C39F65203232' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30172 AND CAST(`address1` AS BINARY) = X'547261756E73747261C383C5B865203232';

-- Entry 952: school id 30172, column `schoolname`, deleted=no
-- School (as reported): "Montessori Kinderhaus Aigen (TraunstraÃŸe)"
-- Original: "Montessori Kinderhaus Aigen (TraunstraÃŸe)"
-- Proposed: "Montessori Kinderhaus Aigen (Traunstraße)"
UPDATE `schools` SET `schoolname` = CONVERT(X'4D6F6E746573736F7269204B696E6465726861757320416967656E2028547261756E73747261C39F6529' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30172 AND CAST(`schoolname` AS BINARY) = X'4D6F6E746573736F7269204B696E6465726861757320416967656E2028547261756E73747261C383C5B86529';

-- Entry 953: school id 30175, column `address1`, deleted=no
-- School (as reported): "Verein Kindergruppen Mickey Mouse und Kinderland- Standort 1"
-- Original: "Leopoldauer StraÃŸe 115,"
-- Proposed: "Leopoldauer Straße 115,"
UPDATE `schools` SET `address1` = CONVERT(X'4C656F706F6C64617565722053747261C39F65203131352C' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30175 AND CAST(`address1` AS BINARY) = X'4C656F706F6C64617565722053747261C383C5B865203131352C';

-- Entry 954: school id 30176, column `address1`, deleted=no
-- School (as reported): "Verein Kindergruppen Mickey Mouse und Kinderland- Standort 2"
-- Original: "Donaufelder StraÃŸe 73"
-- Proposed: "Donaufelder Straße 73"
UPDATE `schools` SET `address1` = CONVERT(X'446F6E617566656C6465722053747261C39F65203733' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30176 AND CAST(`address1` AS BINARY) = X'446F6E617566656C6465722053747261C383C5B865203733';

-- Entry 955: school id 30177, column `address1`, deleted=no
-- School (as reported): "Kindergruppe Hand in Hand"
-- Original: "Hernalser HauptstraÃŸe 82/4-6"
-- Proposed: "Hernalser Hauptstraße 82/4-6"
UPDATE `schools` SET `address1` = CONVERT(X'4865726E616C73657220486175707473747261C39F652038322F342D36' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30177 AND CAST(`address1` AS BINARY) = X'4865726E616C73657220486175707473747261C383C5B8652038322F342D36';

-- Entry 956: school id 30212, column `contactname`, deleted=no
-- School (as reported): "Hilltop Montessori School"
-- Original: "NoÃ«lle Crowe"
-- Proposed: "Noëlle Crowe"
UPDATE `schools` SET `contactname` = CONVERT(X'4E6FC3AB6C6C652043726F7765' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30212 AND CAST(`contactname` AS BINARY) = X'4E6FC383C2AB6C6C652043726F7765';

-- Entry 957: school id 30212, column `headofschoolname`, deleted=no
-- School (as reported): "Hilltop Montessori School"
-- Original: "Tom and NoÃ«lle Crowe"
-- Proposed: "Tom and Noëlle Crowe"
UPDATE `schools` SET `headofschoolname` = CONVERT(X'546F6D20616E64204E6FC3AB6C6C652043726F7765' USING utf8mb4),
    `lastmodified` = `lastmodified`
WHERE `id` = 30212 AND CAST(`headofschoolname` AS BINARY) = X'546F6D20616E64204E6FC383C2AB6C6C652043726F7765';

-- Summary: 957 reported values; 957 guarded UPDATE statements
-- (899 automatic encoding repairs, 58 manually supplied corrections).
-- 0 entries still lack a correction and 0 failed checks;
-- those entries have no executable UPDATE.
-- 0 manual correction(s) are marked CHECK for a possible typo.
-- Invisible/format characters (e.g. U+200E, U+200B, U+202D) are removed from
-- every proposal; web/email values must also be a plain URL or address.
-- Replace the following ROLLBACK with COMMIT only after reviewing the changes.
ROLLBACK;
