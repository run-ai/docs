FROM ubuntu

RUN apt update

#install helm
RUN apt install curl -y
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

#install runai cli
RUN curl -fsSL -o runai-cli-v2.2.40-linux-amd64.tar.gz https://github.com/run-ai/runai-cli/releases/download/v2.2.40/runai-cli-v2.2.40-linux-amd64.tar.gz
RUN tar -zxvf runai-cli-v2.2.40-linux-amd64.tar.gz
RUN ./install-runai.sh
RUN runai update

#inject credentials
COPY config /root/.kube/config
RUN chmod 400 /root/.kube/config

#add runai cli bash completion
RUN apt install bash-completion -y
COPY bashrc /root/.bashrc