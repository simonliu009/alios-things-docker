FROM ubuntu
MAINTAINER SimonLiu <sliu009@gmail.com>
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get -y install vim && apt-get -y install sudo
COPY setup_linux_osx.sh /setup_linux_osx.sh
RUN chmod +x /setup_linux_osx.sh
RUN /setup_linux_osx.sh -y
RUN useradd -d /home/alios -m -s /bin/bash alios
RUN echo "linuxidc ALL=NOPASSWD:ALL" >  /etc/sudoers
RUN chmod 0440 /etc/sudoers 
RUN mkdir -p /home/alios/AliOS-Things
WORKDIR /home/alios/AliOS-Things
USER alios
ENV PATH $PATH:/root/.local/bin
CMD ["/bin/bash"]