FROM ubuntu

RUN apt update
RUN apt install wget -y
#install runai cli
RUN wget --content-disposition https://<CLUSTER-URL>/cli/linux
# RUN wget --content-disposition https://epfllab-10-90-36-20.webredirect.org/cli/linux
RUN chmod +x runai
RUN sudo mv runai /usr/local/bin

#inject credentials
COPY config /root/.kube/config
RUN chmod 400 /root/.kube/config

#add runai cli bash completion
RUN apt install bash-completion -y
COPY bashrc /root/.bashrc