FROM pandoc/core:2.17.1.1 as tester

RUN apk add bats
RUN apk add bash
RUN apk add grep
COPY entrypoint.bats /data/entrypoint.bats
COPY entrypoint.sh /data/entrypoint.sh
RUN chmod +x /data/entrypoint.bats /data/entrypoint.sh
RUN /data/entrypoint.bats


FROM pandoc/core:2.17.1.1
RUN apk add bash
RUN apk add grep

COPY --from=tester /data/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
