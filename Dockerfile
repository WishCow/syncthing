FROM debian:buster-slim
MAINTAINER Norbert Kéri
WORKDIR /home/root
ENV RELEASE linux-amd64
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
    apt-get update && apt-get install -y wget ca-certificates && \
    apt-get clean && \
    useradd -m syncthing
ENV VERSION v1.3.0
RUN wget -O - https://github.com/syncthing/syncthing/releases/download/$VERSION/syncthing-$RELEASE-$VERSION.tar.gz | tar -xzf - -C /usr/local && \
    ln -s /usr/local/syncthing-$RELEASE-$VERSION/syncthing /usr/local/bin
EXPOSE 8080 22000 21025/udp
USER syncthing
ENTRYPOINT [ "syncthing" ]
