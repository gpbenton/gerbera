FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y uuid-dev libexpat1-dev libsqlite3-dev libmysqlclient-dev \
libmagic-dev libexif-dev libcurl4-openssl-dev \
libavutil-dev libavcodec-dev libavformat-dev libavdevice-dev \
libavfilter-dev libavresample-dev libswscale-dev libswresample-dev libpostproc-dev \
cmake git g++ wget autoconf build-essential libtool libffmpegthumbnailer-dev

ARG VERSION
ENV VERSION ${VERSION:-1.3.0}

WORKDIR /tmp

RUN apt-get install -y sudo
RUN useradd gerbera -G sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


RUN wget https://github.com/gerbera/gerbera/archive/v${VERSION}.tar.gz && tar -xzvf v${VERSION}.tar.gz

RUN sh gerbera-${VERSION}/scripts/install-pupnp18.sh
RUN sh gerbera-${VERSION}/scripts/install-taglib111.sh
RUN sh gerbera-${VERSION}/scripts/install-duktape.sh
USER gerbera

RUN mkdir build && cd build && cmake ../gerbera-${VERSION} -DWITH_MAGIC=1 -DWITH_CURL=1 -DWITH_JS=1 \
-DWITH_TAGLIB=1 -DWITH_AVCODEC=1 -DWITH_FFMPEGTHUMBNAILER=1 -DWITH_EXIF=1 -DWITH_SYSTEMD=0 && make -j4 && sudo make install

USER root

RUN rm -rf /tmp/* && \
    mkdir -p /media/pictures /media/videos /media/music /home/gerbera && \
    chown gerbera:gerbera /home/gerbera 

USER gerbera

RUN mkdir -p /home/gerbera/.config/gerbera 

VOLUME [ "/media/pictures", "/media/videos", "/media/music", "/home/gerbera/.config/gerbera" ]

ENTRYPOINT [ "/usr/local/bin/gerbera" ]
