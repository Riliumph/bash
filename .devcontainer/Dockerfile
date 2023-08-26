FROM ubuntu:latest

RUN apt-get update\
    && apt-get install --no-install-recommends -y\
    shellcheck\
    peco\
    && apt-get clean\
    && rm -rf /var/lib/apt/lists/*

# New user
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN groupadd -g 1000 docker\
    && useradd -l -u 1000 -g docker -G sudo -m -s /bin/bash docker\
    && echo 'docker:docker' | chpasswd\
    && echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker
RUN printf "PS1='\u@\h(\$(hostname -i)):\w \n\\$ '" >> ~/.bashrc

ENTRYPOINT [ "/bin/bash" ]
