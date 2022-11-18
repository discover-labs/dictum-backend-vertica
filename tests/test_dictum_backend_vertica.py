import inspect
import shlex
import subprocess

from dictum_core.backends.secret import Secret

from dictum_backend_vertica import __version__
from dictum_backend_vertica.vertica_backend import VerticaBackend


def test_version():
    assert __version__ == "0.1.4"


def test_entry_point():
    subprocess.check_call(
        shlex.split(
            "python -c 'from dictum_core.backends.base import Backend; "
            'assert "vertica" in Backend.registry\''
        )
    )


def test_password_is_secret():
    assert (
        inspect.signature(VerticaBackend.__init__).parameters["password"].annotation
        is Secret
    )
