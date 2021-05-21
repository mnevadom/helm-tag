FROM ibmcom/pipeline-base-image:2.12

RUN apt update

RUN wget https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64 -O /usr/bin/yq &&    chmod +x /usr/bin/yq

RUN wget https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz

RUN tar zxf helm-v3.2.1-linux-amd64.tar.gz

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

