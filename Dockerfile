FROM isaackuang/centos-base:7

ENV PGDATA=/data/postgresql

RUN yum update -y && \
    yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm && \
    yum install -y  postgresql96-server postgresql96-contrib postgresql96-devel && \
    mkdir -p $PGDATA && \
    chown -R postgres.postgres $PGDATA && \
    yum install -y epel-release make gcc && \
    cd /tmp && \
    wget https://rpms.southbridge.ru/rhel7/stable/x86_64/hiredis-last-0.13.3-1.el7.remi.x86_64.rpm && \
    wget https://rpms.southbridge.ru/rhel7/stable/x86_64/hiredis-last-devel-0.13.3-1.el7.remi.x86_64.rpm && \
    yum install -y hiredis-last-devel-0.13.3-1.el7.remi.x86_64.rpm hiredis-last-0.13.3-1.el7.remi.x86_64.rpm && \
    wget https://github.com/brettlaforge/pg_redis_pubsub/archive/master.zip && \
    unzip master.zip && \
    cd pg_redis_pubsub-master && \
    ln -s /usr/pgsql-9.6/bin/pg_config /usr/bin/pg_config && \
    make clean install
    
COPY config /
