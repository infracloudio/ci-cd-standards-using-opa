FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    curl \
    bash 

RUN curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64
RUN chmod +x opa && mv opa /usr/local/bin/

RUN opa version

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]