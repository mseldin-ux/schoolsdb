#!/usr/bin/env python3
"""Run isolated admin integration/browser tests; stop both test servers on exit."""

import os
from pathlib import Path
import socket
import subprocess
import tempfile
import time
from urllib.request import urlopen

ROOT = Path(__file__).resolve().parents[1]


def free_port():
    with socket.socket() as sock:
        sock.bind(("127.0.0.1", 0))
        return sock.getsockname()[1]


def ready(url, process):
    for _ in range(100):
        if process.poll() is not None:
            raise RuntimeError("Test server exited before becoming ready")
        try:
            with urlopen(url, timeout=1) as response:
                if response.status == 200:
                    return
        except OSError:
            time.sleep(0.05)
    raise RuntimeError(f"Test server not responsive: {url}")


def main():
    processes = []
    with tempfile.TemporaryDirectory(prefix="schools-admin-tests-") as directory:
        config = Path(directory) / "config.php"
        subprocess.run(["php", "tests/admin_fixture.php", str(config)], cwd=ROOT, check=True)
        env = dict(os.environ)
        app_port, stub_port = free_port(), free_port()
        env.update(
            SCHOOLS_CONFIG=str(config),
            ADMIN_TEST_URL=f"http://127.0.0.1:{app_port}",
            NOMINATIM_ENDPOINT=f"http://127.0.0.1:{stub_port}/",
        )
        log = Path(directory) / "servers.log"
        try:
            with log.open("w") as output:
                for command in (
                    ["php", "-d", "display_errors=1", "-d", "error_reporting=32767", "-S",
                     f"127.0.0.1:{stub_port}", "tests/nominatim_stub.php"],
                    ["php", "-d", "display_errors=1", "-d", "short_open_tag=0", "-d",
                     "error_reporting=32767", "-S", f"127.0.0.1:{app_port}", "-t", str(ROOT)],
                ):
                    processes.append(subprocess.Popen(command, cwd=ROOT, env=env, stdout=output, stderr=output))
                ready(f"http://127.0.0.1:{stub_port}/", processes[0])
                ready(env["ADMIN_TEST_URL"] + "/controller.php", processes[1])
                subprocess.run(["php", "vendor/bin/phpunit"], cwd=ROOT, env=env, check=True)
                subprocess.run(["php", "tests/admin_fixture.php", "--reset"], cwd=ROOT, env=env, check=True)
                subprocess.run(["npm", "run", "test:admin"], cwd=ROOT, env=env, check=True)
            text = log.read_text()
            for diagnostic in ("PHP Warning:", "PHP Deprecated:", "PHP Fatal error:", "PHP Parse error:"):
                if diagnostic in text:
                    raise RuntimeError(f"Unexpected server diagnostic: {diagnostic}")
        except Exception:
            print("\n".join(log.read_text().splitlines()[-80:]))
            raise
        finally:
            for process in reversed(processes):
                process.terminate()
                try:
                    process.wait(timeout=5)
                except subprocess.TimeoutExpired:
                    process.kill()
                    process.wait()


if __name__ == "__main__":
    main()
