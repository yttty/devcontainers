FROM yttty/devcontainer-base:latest

ENV DEBIAN_FRONTEND=noninteractive

USER root

ARG USER_NAME=coder
USER $USER_NAME
WORKDIR /home/$USER_NAME

# Initialize venv
RUN python3 -m venv /home/$USER_NAME/dev.env && \
    /home/$USER_NAME/dev.env/bin/pip install --no-cache-dir --upgrade \
        pip \
        poetry \
        && \
    echo ". $HOME/dev.env/bin/activate" >> ~/.bashrc

WORKDIR /codespace

ENV DEBIAN_FRONTEND=dialog
