FROM postgres:15

# Install pg_cron and everything required to build it
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        make \
        gcc \
        ca-certificates \
        git \
        postgresql-server-dev-15 \
    && mkdir /build_ext \
    && cd /build_ext \
    && git clone https://github.com/citusdata/pg_cron \
    && cd pg_cron \
    && export PATH=/usr/lib/postgresql/15/bin:$PATH \
    && make \
    && make install \
    && cp /build_ext/pg_cron/pg_cron.so /usr/lib/postgresql/15/bin/pg_cron \
    && apt-get remove -y --purge \
        build-essential \
        make \
        gcc \
        ca-certificates \
        git \
        postgresql-server-dev-15 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /build_ext

# Add pg_cron extension to the database
RUN echo "shared_preload_libraries = 'pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample

# Set listen_addresses to '*' to allow connections from any IP
RUN echo "listen_addresses = '*'" >> /usr/share/postgresql/postgresql.conf.sample

COPY ./init_pg_cron.sql /docker-entrypoint-initdb.d/init_pg_cron.sql
