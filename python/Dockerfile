FROM yttty/devcontainer-cpp:latest

ENV DEBIAN_FRONTEND=noninteractive

ARG USER_NAME=coder
USER $USER_NAME
WORKDIR /home/$USER_NAME

ARG PY_ENV=dev.env
ARG PY_VERSION=3.13
RUN eval "$($HOME/.miniconda/bin/conda shell.bash hook)" && \
    conda create -n ${PY_ENV} python=${PY_VERSION} -y && \
    conda activate ${PY_ENV} && \
    pip install --no-cache-dir --upgrade \
        pip \
        poetry \
        isort \
        black \
        ipykernel \
        && \
    echo "conda activate $PY_ENV" >> ~/.bashrc

WORKDIR /codespace

ENV DEBIAN_FRONTEND=dialog
