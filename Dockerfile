FROM lachlanevenson/k8s-kubectl:v1.16.3 AS kubectl
FROM python:3.7.4-alpine
LABEL maintainer="Julian Einhaus <julianeinhaus@gmx.de>"

RUN groupadd -r fluxctl && useradd --no-log-init -r -g fluxctl fluxctl.
WORKDIR /home/fluxctl

ENV FLUX_VERSION "1.16.0"
ENV AWS_CLI_VERSION "1.16.296"

RUN pip install --user aws-cli==$AWS_CLI_VERSION
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://github.com/weaveworks/flux/releases/download/${FLUX_VERSION}/fluxctl_linux_amd64 -o /usr/local/bin/fluxctl \
 && chmod +x /usr/local/bin/fluxctl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

ENTRYPOINT ["fluxctl"]
CMD ["help"]