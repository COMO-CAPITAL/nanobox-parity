# -*- mode: Dockerfile; tab-width: 4;indent-tabs-mode: nil;-*-
# vim: ts=4 sw=4 ft=Dockerfile et: 1

FROM nanobox/runit

# Create directories
RUN mkdir -p /var/log/gonano

# Install deps
RUN apt-get update -qq && \
    apt-get install -y iputils-arping cron rpcbind nfs-common ntpdate && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

USER gonano

# Install binaries
RUN \
  echo "f3b9d17d17b9c74cfdca3051055c3c7ffba72c32f76ba05ba4d06dea334ba1d6  -" > /tmp/sum.txt && \
  curl -fLs https://parity-downloads-mirror.parity.io/v1.7.12/x86_64-unknown-linux-gnu/parity | \
    tee /data/bin/parity | sha256sum --strict -c /tmp/sum.txt && \
  chmod +x /data/bin/parity && \
  rm -rf /tmp/sum.txt

# Install binaries
RUN rm -rf /data/var/db/pkgin && \
    /data/bin/pkgin -y up && \
    /data/bin/pkgin -y in \
        unfs3 \
        flex && \
    rm -rf /data/var/db/pkgin/cache

USER root

# Install binaries
RUN rm -rf /opt/gonano/var/db/pkgin && \
    /opt/gonano/bin/pkgin -y up && \
    /opt/gonano/bin/pkgin -y in \
      rsync && \
    rm -rf /var/gonano/db/pkgin/cache

RUN /opt/gonano/bin/gem install remote_syslog_logger && \
  mkdir -p /opt/nanobox/hooks && \
  mkdir -p /var/nanobox
  
RUN ln -s /data/var/db/unfs /app

ADD hooks /opt/nanobox/hooks

RUN \
  chmod +x /opt/nanobox/hooks/start && \
  chmod +x /opt/nanobox/hooks/stop && \
  chmod +x /opt/nanobox/hooks/plan && \
  chmod +x /opt/nanobox/hooks/import-clean && \
  chmod +x /opt/nanobox/hooks/import-prep && \
  chmod +x /opt/nanobox/hooks/export-live && \
  chmod +x /opt/nanobox/hooks/export-final && \
  chmod +x /opt/nanobox/hooks/configure

# Cleanup disk
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

EXPOSE 30303/tcp 30303/udp

WORKDIR /data

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]