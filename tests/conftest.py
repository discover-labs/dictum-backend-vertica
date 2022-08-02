import shlex
import subprocess
import time
from pathlib import Path

import pytest
from dictum_core.tests.conftest import chinook, engine, project  # noqa: F401
import vertica_python

from dictum_backend_vertica.vertica_backend import VerticaBackend

container_name = "dictum-vertica-backend-test"

basepath = Path(__file__).parent


def stop(fail=False):
    cmd = shlex.split(f"docker stop {container_name}")
    try:
        subprocess.check_call(cmd)
    except subprocess.SubprocessError:
        if fail:
            raise


@pytest.fixture(scope="session")
def backend():
    data = basepath / "data"
    entrypoint = basepath / "docker-entrypoint.sh"
    cmd = shlex.split(
        f"docker run -d --rm --name {container_name} -p 5433:5433 "
        "-e VERTICA_DB_NAME=chinook -e APP_DB_USER=chinook -e APP_DB_PASSWORD=chinook "
        f"-v {entrypoint}:/home/dbadmin/docker-entrypoint.sh "  # don't load sample data
        f"-v {data}:/home/dbadmin/data "
        "vertica/vertica-ce"
    )
    subprocess.check_call(cmd)
    params = dict(
        host="localhost", database="chinook", user="chinook", password="chinook"
    )
    for _ in range(30):
        try:
            vertica_python.connect(**params)
            break
        except vertica_python.errors.ConnectionError:
            print("Waiting for database to start...")
            time.sleep(3)

    restore_cmd = shlex.split(
        f"docker container exec {container_name} "
        "/opt/vertica/bin/vsql -f /home/dbadmin/data/chinook.sql"
    )
    subprocess.check_call(restore_cmd)
    try:
        yield VerticaBackend(
            database=params["database"],
            host=params["host"],
            username=params["user"],
            password=params["password"],
        )
    finally:
        stop()
