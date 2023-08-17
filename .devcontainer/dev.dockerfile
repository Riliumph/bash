FROM ubuntu:latest

RUN apt-get update &&\
    apt-get install --no-install-recommends -y\
    peco

# New user
RUN groupadd -g 1000 docker &&\
    useradd -l -u 1000 -g 1000 -m docker -s /bin/bash
USER docker
RUN echo "PS1='\u@\h(\$(hostname -i)):\w \\$ '" >> ~/.bashrc
WORKDIR /workspace/bash
COPY INSTALL.bash /workspace/bash
RUN ./INSTALL.bash
ENTRYPOINT [ "/bin/bash" ]
