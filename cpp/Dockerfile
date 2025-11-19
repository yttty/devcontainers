FROM yttty/devcontainer-base:latest

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install packages
RUN apt-get update && \
    apt-get install -y \
        # GCC 14
        gcc-14 g++-14  \
        # Clang 20
        clang-20 clang++-20 lldb-20 libc++-20-dev libc++abi-20-dev clang-format-20 \
        # Formatters
        shfmt cmake-format \
        # Build tools
        build-essential gdb valgrind cmake ninja-build ccache \
        # Package manager
        pkg-config autoconf automake libtool \
        && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    # Set the default compiler
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 100 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 100 && \
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-20 100

ARG USER_NAME=coder
USER $USER_NAME
WORKDIR /home/$USER_NAME

RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/.miniconda && \
    rm ~/miniconda.sh && \
    eval "$($HOME/.miniconda/bin/conda shell.bash hook)" && \
    conda init bash && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    pip install --no-cache-dir --upgrade pip conan && \
    # Initialize conan
    conan profile detect --force && \
    mkdir -p ~/.conan2/profiles && \
    # Generate conan profile for gcc14
    conan profile detect --name gcc14 --force && \
    sed -i 's|compiler.version=.*|compiler.version=14|g' ~/.conan2/profiles/gcc14 && \
    sed -i 's|compiler.cppstd=.*|compiler.cppstd=20|g' ~/.conan2/profiles/gcc14 && \
    # Generate conan profile for clang20
    conan profile detect --name clang20 --force && \
    sed -i 's|compiler=gcc|compiler=clang|g' ~/.conan2/profiles/clang20 && \
    sed -i 's|compiler.version=.*|compiler.version=20|g' ~/.conan2/profiles/clang20 && \
    sed -i 's|compiler.cppstd=.*|compiler.cppstd=20|g' ~/.conan2/profiles/clang20 && \
    sed -i 's|compiler.libcxx=.*|compiler.libcxx=libc++|g' ~/.conan2/profiles/clang20 && \
    echo "" >> ~/.conan2/profiles/clang20 && \
    echo "[conf]" >> ~/.conan2/profiles/clang20 && \
    echo 'tools.build:compiler_executables={"c": "clang-20", "cpp": "clang++-20"}' >> ~/.conan2/profiles/clang20

ENV DEBIAN_FRONTEND=dialog
