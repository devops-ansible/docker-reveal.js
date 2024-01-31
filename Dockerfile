ARG IMAGE=node
ARG VERSION=latest

FROM $IMAGE:$VERSION AS base

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive

ARG WORKINGDIR=/reveal.js
ENV WORKINGDIR="${WORKINGDIR}"

WORKDIR /
COPY install/ /

RUN chmod a+x /buildscript.sh && \
    /buildscript.sh


FROM base

MAINTAINER macwinnie <dev@macwinnie.me>

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV KEEP_DEFAULTS true

EXPOSE 8000

COPY --from=base --chown=node:node ${WORKINGDIR} /
COPY --from=base /entrypoint.sh /usr/local/bin/entrypoint

WORKDIR ${WORKINGDIR}
USER node

ENTRYPOINT ["entrypoint"]
CMD ["start"]
