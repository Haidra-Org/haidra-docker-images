ARG PG_MAJOR=18

FROM postgres:${PG_MAJOR} AS builder

ARG PG_MAJOR

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git \
        postgresql-server-dev-${PG_MAJOR} \
    && PG_CRON_TAG="$(git ls-remote --refs --tags https://github.com/citusdata/pg_cron.git \
        | awk -F/ '{print $3}' \
        | sort -V \
        | tail -n 1)" \
    && test -n "${PG_CRON_TAG}" \
    && git clone --depth 1 --branch "${PG_CRON_TAG}" https://github.com/citusdata/pg_cron /build/pg_cron \
    && cd /build/pg_cron \
    && make \
    && make install

FROM postgres:${PG_MAJOR}

ARG PG_MAJOR

COPY --from=builder /usr/lib/postgresql/${PG_MAJOR}/lib/pg_cron.so \
                    /usr/lib/postgresql/${PG_MAJOR}/lib/
COPY --from=builder /usr/share/postgresql/${PG_MAJOR}/extension/pg_cron* \
                    /usr/share/postgresql/${PG_MAJOR}/extension/

RUN echo "shared_preload_libraries = 'pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "listen_addresses = '*'" >> /usr/share/postgresql/postgresql.conf.sample

COPY init_pg_cron.sql /docker-entrypoint-initdb.d/
