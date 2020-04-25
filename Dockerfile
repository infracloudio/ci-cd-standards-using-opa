# install binaries
FROM alpine AS binary-builder
RUN mkdir -p /binaries
RUN apk add --no-cache curl \
    unzip

RUN curl -L -o /binaries/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64
RUN curl -L -o /binaries/terraform.zip https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
RUN cd /binaries && unzip terraform.zip && rm terraform.zip


# action image
FROM ubuntu:18.04
COPY --from=binary-builder /binaries/opa /usr/local/bin
COPY --from=binary-builder /binaries/terraform /usr/local/bin
RUN chmod 755 /usr/local/bin/opa
RUN opa version
RUN terraform version
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
