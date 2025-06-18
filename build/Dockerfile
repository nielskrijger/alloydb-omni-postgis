ARG OMNI_VERSION

FROM google/alloydbomni:${OMNI_VERSION}

RUN apt-get update && \
      apt-get install -y --no-install-recommends \
      postgresql-16-postgis-3 && \
      apt-get purge -y --auto-remove && \
      rm -rf /var/lib/apt/lists/*