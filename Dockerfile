FROM python:3.7.4-alpine
LABEL maintainer="Julian Einhaus <julianeinhaus@gmx.de>"

ENV FLUX_VERSION "1.16.0"
ENV AWS_CLI_VERSION "1.16.296"
ENV KUBE_VERSION="v1.16.3"

WORKDIR /root
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && curl -L https://github.com/weaveworks/flux/releases/download/${FLUX_VERSION}/fluxctl_linux_amd64 -o /usr/local/bin/fluxctl \
 && chmod +x /usr/local/bin/fluxctl \
 && apk del --purge deps \
 && rm /var/cache/apk/*

RUN pip install --prefix /usr/local awscli==$AWS_CLI_VERSION
