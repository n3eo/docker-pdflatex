FROM debian:bullseye-20230109-slim
LABEL maintainer="cristian@regolo.cc"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-cache depends texlive-full \
  | grep "Depends:" \
  | grep -v "doc$" \
  | cut -d ' ' -f 4 \
  | xargs apt-get install --no-install-recommends -y

# enable latex formatter
RUN apt-get install make gcc -y
RUN cpan Log::Dispatch::File
RUN cpan YAML::Tiny
RUN cpan File::HomeDir

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN apt-get autoclean
RUN apt-get autoremove

VOLUME ["/sources"]
WORKDIR /sources
