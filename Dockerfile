ARG IMAGE=node
ARG VERSION=latest

FROM $IMAGE:$VERSION

MAINTAINER macwinnie <dev@macwinnie.me>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV WORKINGUSER node
# ENV NODE_ENV production

EXPOSE 8000

COPY install/ /

RUN chmod a+x /buildscript.sh && \
    /buildscript.sh

WORKDIR /reveal.js

ENTRYPOINT ["entrypoint"]
CMD ["start"]
