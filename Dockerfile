FROM pandoc/core:2.14.0.3 as tester

RUN apk add bats
RUN apk add bash
COPY entrypoint.bats /data/entrypoint.bats
COPY entrypoint.sh /data/entrypoint.sh
RUN chmod +x /data/entrypoint.bats /data/entrypoint.sh
RUN /data/entrypoint.bats


FROM pandoc/core:2.14.0.3
RUN apk add bash

COPY --from=tester /data/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
