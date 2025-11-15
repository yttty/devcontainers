FROM yttty/devcontainer-base:latest

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install packages
RUN apt-get update -y && \
    apt-get install -y \
        # GCC 14
        gcc-14 g++-14  \
        # Clang 17
        clang-17 clang++-17 lldb-17 libc++-17-dev libc++abi-17-dev \
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
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 100 && \
    # Install Conan in venv
    python3 -m venv /opt/conan-venv && \
    /opt/conan-venv/bin/pip install --no-cache-dir --upgrade pip && \
    /opt/conan-venv/bin/pip install --no-cache-dir conan && \
    ln -s /opt/conan-venv/bin/conan /usr/local/bin/conan

ARG USER_NAME=coder
USER $USER_NAME
WORKDIR /home/$USER_NAME

# Initialize conan
RUN conan profile detect --force && \
    mkdir -p ~/.conan2/profiles && \
    # Generate conan profile for gcc14
    conan profile detect --name gcc14 --force && \
    sed -i 's|compiler.version=.*|compiler.version=14|g' ~/.conan2/profiles/gcc14 && \
    sed -i 's|compiler.cppstd=.*|compiler.cppstd=20|g' ~/.conan2/profiles/gcc14 && \
    # Generate conan profile for clang17
    conan profile detect --name clang17 --force && \
    sed -i 's|compiler=gcc|compiler=clang|g' ~/.conan2/profiles/clang17 && \
    sed -i 's|compiler.version=.*|compiler.version=17|g' ~/.conan2/profiles/clang17 && \
    sed -i 's|compiler.cppstd=.*|compiler.cppstd=20|g' ~/.conan2/profiles/clang17 && \
    sed -i 's|compiler.libcxx=.*|compiler.libcxx=libc++|g' ~/.conan2/profiles/clang17

ENV DEBIAN_FRONTEND=dialog
