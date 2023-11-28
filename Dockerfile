FROM debian:12 as base

RUN apt update && apt install -y git dnsmasq bind9-dnsutils

RUN echo "addn-hosts=/srv/hosts" >> /etc/dnsmasq.conf
COPY hosts /srv/

COPY entrypoints/ /
RUN chmod +x /*.sh


FROM base AS production

EXPOSE 53

CMD /entrypoint.sh


FROM base AS test

CMD /test.sh
