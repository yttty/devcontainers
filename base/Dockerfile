FROM ubuntu:24.04

# For ubuntu:24.04, there already have a user named `ubuntu` with uid 1000, we need to delete it. see:
# https://askubuntu.com/questions/1513927/ubuntu-24-04-docker-images-now-includes-user-ubuntu-with-uid-gid-1000
RUN touch /var/mail/ubuntu && chown ubuntu /var/mail/ubuntu && userdel -r ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ARG TZ=Asia/Hong_Kong
# User info
# This Dockerfile adds a non-root user `coder` with sudo privileges. However, on Linux,
# this user's GID/UID must match your local user's UID/GID to avoid permission issues during bind mounts.
# If your UID/GID is not 1000, please update USER_UID / USER_GID. For more details,
# refer to https://aka.ms/vscode-remote/containers/non-root-user.
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_NAME=coder

# Install system packages & setup user
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y \
        sudo \
        man-db \
        dialog \
        tzdata \
        tar \
        zip \
        unzip \
        curl \
        wget \
        iproute2 \
        git \
        git-lfs \
        vim \
        nano \
        tree \
        htop \
        procps \
        libssl-dev \
        libicu-dev \
        && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    groupadd --gid $USER_GID $USER_NAME && \
    useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USER_NAME && \
    echo $USER_NAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME

# User config
USER $USER_NAME
WORKDIR /home/$USER_NAME

COPY container.bashrc .gitconfig /home/$USER_NAME/
ARG GIT_COMPLETION_VERSION=v2.51.2
RUN mkdir -p ~/.local/share/git-core/contrib/completion && \
    curl -fsSL "https://raw.githubusercontent.com/git/git/${GIT_COMPLETION_VERSION}/contrib/completion/git-completion.bash" \
         -o ~/.local/share/git-core/contrib/completion/git-completion.bash && \
    curl -fsSL "https://raw.githubusercontent.com/git/git/${GIT_COMPLETION_VERSION}/contrib/completion/git-prompt.sh" \
         -o ~/.local/share/git-core/contrib/completion/git-prompt.sh && \
    mkdir -p ~/.local/share/diff-so-fancy/lib && \
    curl -fsSL "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/refs/heads/next/diff-so-fancy" \
         -o ~/.local/share/diff-so-fancy/diff-so-fancy && \
    curl -fsSL "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/refs/heads/next/lib/DiffHighlight.pm" \
         -o ~/.local/share/diff-so-fancy/lib/DiffHighlight.pm && \
    chmod +x ~/.local/share/diff-so-fancy/diff-so-fancy && \
    echo "" >> ~/.bashrc && \
    cat ~/container.bashrc >> ~/.bashrc && \
    rm ~/container.bashrc && \
    git lfs install

ENV TERM=xterm-256color
ENV DEBIAN_FRONTEND=dialog
