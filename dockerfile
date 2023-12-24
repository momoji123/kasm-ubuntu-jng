FROM kasmweb/core-ubuntu-focal:1.14.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

### install sude
RUN apt-get update && apt-get -y upgrade && apt-get install -y sudo

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

### Install Eclipse
COPY ./src/ubuntu/install/eclipse $INST_SCRIPTS/eclipse/
RUN bash $INST_SCRIPTS/eclipse/install_postgresql.sh  && rm -rf $INST_SCRIPTS/eclipse/

### Install Only Office
COPY ./src/ubuntu/install/only_office $INST_SCRIPTS/only_office/
RUN bash $INST_SCRIPTS/only_office/install_only_office.sh  && rm -rf $INST_SCRIPTS/only_office/

### Install Java
RUN apt-get update && apt install -y openjdk-17-jdk openjdk-17-jre

### Install Node
COPY ./src/ubuntu/install/nodeJS $INST_SCRIPTS/nodeJS/
RUN bash $INST_SCRIPTS/nodeJS/install_nodeJS.sh  && rm -rf $INST_SCRIPTS/nodeJS/

### Install Github Desktop
COPY ./src/ubuntu/install/github-desktop $INST_SCRIPTS/github-desktop/
RUN bash $INST_SCRIPTS/github-desktop/install_github_desktop.sh  && rm -rf $INST_SCRIPTS/github-desktop

### Install Systemd adapter
COPY ./src/ubuntu/install/systemd $INST_SCRIPTS/systemd/
RUN bash $INST_SCRIPTS/systemd/install_systemd.sh  && rm -rf $INST_SCRIPTS/systemd

### Install Postgresql
COPY ./src/ubuntu/install/postgresql $INST_SCRIPTS/postgresql/
RUN bash $INST_SCRIPTS/postgresql/install_postgresql.sh  && rm -rf $INST_SCRIPTS/postgresql/

### add custom user
ARG CUST_USER="oji"
#should be overwritten on build
ARG CUST_USER_PW="password"
RUN useradd -p $(openssl passwd -1 "$CUST_USER_PW") "$CUST_USER" && usermod -aG sudo ${CUST_USER}

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000