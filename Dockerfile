# -*- mode: Dockerfile; tab-width: 4;indent-tabs-mode: nil;-*-
# vim: ts=4 sw=4 ft=Dockerfile et: 1

FROM nanobox/runit

# Create directories
RUN mkdir -p /var/log/gonano

# Install arping
RUN apt-get update -qq && \
    apt-get install -y iputils-arping cron && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

USER gonano

# Install binaries
RUN \
  echo "04bdf922f4241d3523e060db378357afacafd62873a1dbd470c7b928e83d9d5a  -" > /tmp/sum.txt && \
  curl -fLs https://parity-downloads-mirror.parity.io/v1.7.10/x86_64-unknown-linux-gnu/parity | \
    tee /data/bin/parity | sha256sum --strict -c /tmp/sum.txt && \
  chmod +x /data/bin/parity && \
  rm -rf /tmp/sum.txt

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

ADD hooks /opt/nanobox/hooks

RUN \
  chmod +x /opt/nanobox/hooks/start && \
  chmod +x /opt/nanobox/hooks/stop && \
  chmod +x /opt/nanobox/hooks/plan && \
  chmod +x /opt/nanobox/hooks/configure && \
  chmod +x /opt/nanobox/hooks/export-final && \
  chmod +x /opt/nanobox/hooks/export-live && \
  chmod +x /opt/nanobox/hooks/import-clean && \
  chmod +x /opt/nanobox/hooks/import-prep

# Cleanup disk
RUN rm -rf \
      /var/lib/apt/lists/* \
      /tmp/* \
      /var/tmp/*

WORKDIR /data

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]