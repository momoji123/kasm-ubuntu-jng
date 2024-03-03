FROM kasmweb/core-ubuntu-jammy:1.15.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

### install sude
ARG LAST_MAJOR_UPDATE
RUN echo "Last update: ${LAST_MAJOR_UPDATE}" &&  apt-get update && apt-get -y upgrade && apt-get install -y sudo

### Install Tools
COPY ./src/ubuntu/install/tools $INST_SCRIPTS/tools/
RUN bash $INST_SCRIPTS/tools/install_tools_deluxe.sh  && rm -rf $INST_SCRIPTS/tools/

### Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

### Install Firefox
COPY ./src/ubuntu/install/firefox/ $INST_SCRIPTS/firefox/
COPY ./src/ubuntu/install/firefox/firefox.desktop $HOME/Desktop/
RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/

### Install Brave
COPY ./src/ubuntu/install/brave $INST_SCRIPTS/brave/
RUN rm -rf /etc/opt/chrome/policies/
RUN bash $INST_SCRIPTS/brave/install_brave.sh  && rm -rf $INST_SCRIPTS/brave/

### Install Visual Studio Code
COPY ./src/ubuntu/install/vs_code $INST_SCRIPTS/vs_code/
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh  && rm -rf $INST_SCRIPTS/vs_code/

### Install Only Office
COPY ./src/ubuntu/install/only_office $INST_SCRIPTS/only_office/
RUN bash $INST_SCRIPTS/only_office/install_only_office.sh  && rm -rf $INST_SCRIPTS/only_office/

### Install Java
RUN apt-get update && apt install -y openjdk-17-jdk openjdk-17-jre

### Install Node
COPY ./src/ubuntu/install/nodeJS $INST_SCRIPTS/nodeJS/
RUN bash $INST_SCRIPTS/nodeJS/install_nodeJS.sh  && rm -rf $INST_SCRIPTS/nodeJS/

### Install Putty
COPY ./src/ubuntu/install/putty $INST_SCRIPTS/putty/
RUN bash $INST_SCRIPTS/putty/install_putty.sh  && rm -rf $INST_SCRIPTS/putty/

### Install Zip
COPY ./src/ubuntu/install/zip $INST_SCRIPTS/zip/
RUN bash $INST_SCRIPTS/zip/install_zip.sh  && rm -rf $INST_SCRIPTS/zip/

### keep os update
#LAST_UPDATE variable must be filled in docker-compose file
ARG LAST_UPDATE
RUN echo "Last update: ${LAST_UPDATE}" && sudo apt update && sudo apt upgrade -y

### Install Systemd adapter
COPY ./src/ubuntu/install/systemd $INST_SCRIPTS/systemd/
RUN bash $INST_SCRIPTS/systemd/install_systemd.sh  && rm -rf $INST_SCRIPTS/systemd

### Install Postgresql
COPY ./src/ubuntu/install/postgresql $INST_SCRIPTS/postgresql/
RUN bash $INST_SCRIPTS/postgresql/install_postgresql.sh  && rm -rf $INST_SCRIPTS/postgresql/

### copy service starters scripts
COPY ./src/ubuntu/services $HOME/services/

### Add kasm-user to sudo
RUN echo 'kasm-user ALL=(ALL) !ALL' >> /etc/sudoers && echo 'kasm-user ALL=(root) NOPASSWD: /bin/systemctl' >> /etc/sudoers

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
