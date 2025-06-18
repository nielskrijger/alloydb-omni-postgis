FROM google/alloydbomni:16.3.0

# AlloyDB Omni doesn't come with POSTGIS pre-installed, see:
# https://cloud.google.com/alloydb/omni/current/docs/install-postgis?option=debian#linux
RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16-postgis-3 && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
