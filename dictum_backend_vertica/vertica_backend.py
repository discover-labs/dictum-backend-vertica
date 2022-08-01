from typing import Optional

from dictum.backends.sql_alchemy import SQLAlchemyBackend, SQLAlchemyCompiler
from sqlalchemy.engine.url import URL


class VerticaCompiler(SQLAlchemyCompiler):
    pass


class VerticaBackend(SQLAlchemyBackend):
    type = "vertica"
    compiler_cls = VerticaCompiler

    def __init__(
        self,
        database: str,
        host: str = "localhost",
        port: int = 5433,
        username: str = "dbadmin",
        password: Optional[str] = None,
        pool_size: Optional[int] = 5,
    ):
        super().__init__(
            database=database,
            host=host,
            port=port,
            username=username,
            password=password,
            pool_size=pool_size,
        )

    @property
    def url(self) -> str:
        url_params = {
            k: v
            for k, v in self.parameters.items()
            if k not in {"pool_size", "default_schema"}
        }
        return URL.create(drivername="vertica+vertica_python", **url_params)
