FROM pandoc/core:2.14.0.1 as tester

RUN apk add bats
COPY entrypoint.bats /data/entrypoint.bats
COPY entrypoint.sh /data/entrypoint.sh
RUN chmod +x /data/entrypoint.bats /data/entrypoint.sh
RUN /data/entrypoint.bats


FROM pandoc/core:2.14.0.1

COPY --from=tester /data/entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
