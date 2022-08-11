import shlex
import subprocess

from dictum_backend_vertica import __version__


def test_version():
    assert __version__ == "0.1.3"


def test_entry_point():
    subprocess.check_call(
        shlex.split(
            "python -c 'from dictum_core.backends.base import Backend; "
            'assert "vertica" in Backend.registry\''
        )
    )
