# AlloyDB Omni Postgis issue

- AlloyDB Omni version: 16.3.0
- PostGIS version: 3.5.3

## Steps to reproduce

In one terminal, start Docker Compose:

```sh
$ docker compose up
```

This builds the AlloyDB image with PostGIS installed, following the instructions here:
https://cloud.google.com/alloydb/omni/16.3.0/docs/install-postgis?option=debian

In another terminal, run the postgis-test.sql script:

```sh
$ psql -h localhost -p 5432 -U postgres -d postgres -f postgis-test.sql

psql:postgis-test.sql:6: NOTICE:  table "regions" does not exist, skipping
psql:postgis-test.sql:7: NOTICE:  table "locations" does not exist, skipping
psql:postgis-test.sql:16: NOTICE:  PostGIS version: POSTGIS="3.5.3 aab5f55" [EXTENSION] PGSQL="160" GEOS="3.11.1-CAPI-1.17.1" PROJ="9.1.1 NETWORK_ENABLED=OFF URL_ENDPOINT=https://cdn.proj.org USER_WRITABLE_DIRECTORY=/var/lib/postgresql/.local/share/proj DATABASE_PATH=/usr/share/proj/proj.db" (compiled against PROJ 9.1.1) LIBXML="2.9.14" LIBJSON="0.16" LIBPROTOBUF="1.4.1" WAGYU="0.5.0 (Internal)"
psql:postgis-test.sql:50: ERROR:  unrecognized node type: 435
```

When downgrading to AlloyDB Omni version 15.7.1 and PostgreSQL 15, the script runs without errors:

```sh
$ psql -h localhost -p 5432 -U postgres -d postgres -f postgis-test.sql

psql:postgis-test.sql:6: NOTICE:  table "regions" does not exist, skipping
psql:postgis-test.sql:7: NOTICE:  table "locations" does not exist, skipping
psql:postgis-test.sql:16: NOTICE:  PostGIS version: POSTGIS="3.3.2 4975da8" [EXTENSION] PGSQL="150" GEOS="3.11.1-CAPI-1.17.1" PROJ="9.1.1" LIBXML="2.9.14" LIBJSON="0.16" LIBPROTOBUF="1.4.1" WAGYU="0.5.0 (Internal)"
  1 | Inside Point 1
  2 | Inside Point 2
```

When using AlloyDB (non-Omni) in Google Cloud it uses PostGIS 3.4.4 in PostgreSQL 16 which appears to work correctly as well.