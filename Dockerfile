FROM ubuntu:24.04

# Core system utilities
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # Trusted root certificates for HTTPS
    ca-certificates=20240203 \
    # Enables apt to use HTTPS repos
    apt-transport-https=2.8.3 \
    # Non-interactive network downloader
    wget=1.21.4-1ubuntu4.1 \
    # Versatile URL transfer tool
    curl=8.5.0-2ubuntu10.6 \
    # Extract .zip archives
    unzip=6.0-28ubuntu4.1 \
    # Simple command-line text editor
    nano=7.2-2ubuntu0.1 \
    # Distributed version control
    git=1:2.43.0-1ubuntu7.2 \
    # File type identification
    file=1:5.45-3build1 \
    # File compression/decompression
    xz-utils=5.6.1+really5.4.5-1ubuntu0.2 \
    && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /usr/share/info /usr/share/locale

# Development libraries
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # C extension support for Python, Ruby
    libffi-dev=3.4.6-1build1 \
    # TLS/SSL development libraries
    libssl-dev=3.0.13-0ubuntu3.5 \
    # Headers for building Python modules
    python3-dev=3.12.3-0ubuntu2 \
    # GLib-based D-BUS IPC dev headers
    libdbus-glib-1-dev=0.112-3build2 \
    # D-BUS IPC core development headers
    libdbus-1-dev=1.14.10-4ubuntu4.1 \
    # Manage compile/link flags for libs
    pkg-config=1.8.1-2build1 \
    # Kernel module utilities (depmod, etc)
    kmod=31+20240202-2ubuntu7.1 \
    # USB library at runtime
    libusb-1.0-0=2:1.0.27-1 \
    # USB library headers for development
    libusb-1.0-0-dev=2:1.0.27-1 \
    && rm -rf /var/lib/apt/lists/*

# Build systems & compilers
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # Standard Unix build tool
    make=4.3-4.1build2 \
    # Cross-platform build system
    cmake=3.28.3-1build7 \
    # High-speed build system
    ninja-build=1.11.1-2 \
    # Software construction tool (Python)
    scons=4.5.2+dfsg-1 \
    # GNU C compiler
    gcc=4:13.2.0-7ubuntu1 \
    # GNU C++ compiler
    g++=4:13.2.0-7ubuntu1 \
    # Perfect hash function generator
    gperf=3.1-1build1 \
    # Fast lexical analyzer generator
    flex=2.6.4-8.2build1 \
    # Parser generator
    bison=2:3.8.2+dfsg-1build2 \
    # Compiler output caching for speedup
    ccache=4.9.1-1 \
    # Code coverage report generator
    lcov=2.0-4ubuntu2 \
    && rm -rf /var/lib/apt/lists/*

# Static analysis, dynamic analysis, formatting
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # Static C/C++ code analysis tool
    cppcheck=2.13.0-2ubuntu3 \
    # Static C/C++ code analysis tool
    flawfinder=2.0.19-1.1 \
    # Opinionated C++ linter
    vera++=1.2.1-2build10 \
    # Clang-based C++ "linter"
    clang-tidy=1:18.0-59~exp2 \
    # Clang-based code formatter
    clang-format=1:18.0-59~exp2 \
    # Memory leak detector
    valgrind=1:3.22.0-0ubuntu3 \
    && rm -rf /var/lib/apt/lists/*

# Python environment & packages
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # Python 3 interpreter
    python3=3.12.3-0ubuntu2 \
    # Python package installer
    python3-pip=24.0+dfsg-1ubuntu1.1 \
    # Python virtual environment support
    python3-venv=3.12.3-0ubuntu2 \
    && rm -rf /var/lib/apt/lists/* &&\
    python3 -m pip install --break-system-packages --no-cache-dir \
    # Python wrapper for gcov coverage
    gcovr==8.3 \
    # Cryptographic primitives
    pycryptodome==3.23.0 \
    # Alternate PyCryptodome namespace
    pycryptodomex==3.23.0 \
    # Elliptic Curve Digital Signature
    ecdsa==0.19.1 \
    # ELF and DWARF parsing in Python
    pyelftools==0.32 \
    # Generate SVG badges (e.g., code-coverage)
    anybadge==1.16.0 \
    # Isolated Python environments
    virtualenv==20.31.2 \
    # Serial-port communication library
    pyserial==3.5 \
    # Python package for debugging
    pyocd==0.36.0

# AVR (Atmel) toolchain
RUN apt-get update && apt-get install --yes --no-install-recommends \
    # AVR linker, assembler
    binutils-avr=2.26.20160125+Atmel3.7.0-2 \
    # AVR C compiler
    gcc-avr=1:7.3.0+Atmel3.7.0-1 \
    # C library for AVR microcontrollers
    avr-libc=1:2.0.0+Atmel3.7.0-1 \
    # AVR programmer/dongle interface
    avrdude=7.1+dfsg-3build2 \
    && rm -rf /var/lib/apt/lists/*

# ARM GNU Toolchain 14.2.1
ARG VERSION_ARM_GNU_TOOLCHAIN=14.2.rel1
ARG DOWNLOAD_URL_VERSION=14.2.rel1
RUN mkdir -p /opt/arm && cd /opt/arm && \
    wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu/${DOWNLOAD_URL_VERSION}/binrel/arm-gnu-toolchain-${DOWNLOAD_URL_VERSION}-x86_64-arm-none-eabi.tar.xz && \
    tar -xf arm-gnu-toolchain-${DOWNLOAD_URL_VERSION}-x86_64-arm-none-eabi.tar.xz --strip-components=1 && \
    rm arm-gnu-toolchain-${DOWNLOAD_URL_VERSION}-x86_64-arm-none-eabi.tar.xz && \
    find . -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.pdf' -o -name '*.html' -o -name '*.md' -o -name '*.txt' -o -name '*.rst' \) -delete
ENV ARM_PATH=/opt/arm \
    ARM_LIB=/opt/arm/lib/gcc/arm-none-eabi/14.2.1 \
    PATH="${PATH}:/opt/arm/bin:/opt/arm/arm-none-eabi/bin"

# Xtensa ESP toolchain & ESP-IDF
ENV IDF_PATH=/opt/esp/esp-idf-v5.4.1
RUN mkdir -p /opt/esp && cd /opt/esp && \
    wget https://github.com/espressif/crosstool-NG/releases/download/esp-14.2.0_20241119/xtensa-esp-elf-14.2.0_20241119-x86_64-linux-gnu.tar.xz && \
    tar -xf xtensa-esp-elf-14.2.0_20241119-x86_64-linux-gnu.tar.xz && \
    rm xtensa-esp-elf-14.2.0_20241119-x86_64-linux-gnu.tar.xz && \
    git clone --depth 1 --branch v5.4.1 https://github.com/espressif/esp-idf.git $IDF_PATH && \
    curl -L https://dl.espressif.com/dl/esp-idf/espidf.constraints.v5.4.txt -o /tmp/espidf.constraints.txt && \
    python3 -m pip install --break-system-packages --no-cache-dir \
        --ignore-installed six PyYAML \
        -r $IDF_PATH/tools/requirements/requirements.core.txt \
        -r $IDF_PATH/tools/requirements/requirements.gdbgui.txt \
        -r $IDF_PATH/tools/requirements/requirements.pytest.txt \
        -r $IDF_PATH/tools/requirements/requirements.test-specific.txt \
        -r $IDF_PATH/tools/requirements/requirements.docs.txt \
        -r $IDF_PATH/tools/requirements/requirements.ci.txt \
        -c /tmp/espidf.constraints.txt \
    && rm /tmp/espidf.constraints.txt && \
    find . -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.pdf' -o -name '*.html' -o -name '*.md' -o -name '*.txt' -o -name '*.rst' \) -delete
ENV PATH="${PATH}:/opt/esp/xtensa-esp-elf/bin:${IDF_PATH}/tools"

# xPack OpenOCD (on-chip debugging)
RUN mkdir -p /opt/openocd && cd /opt/openocd && \
    wget https://github.com/xpack-dev-tools/openocd-xpack/releases/download/v0.12.0-6/xpack-openocd-0.12.0-6-linux-x64.tar.gz && \
    tar -xf xpack-openocd-0.12.0-6-linux-x64.tar.gz && \
    rm xpack-openocd-0.12.0-6-linux-x64.tar.gz && \
    find . -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.pdf' -o -name '*.html' -o -name '*.md' -o -name '*.txt' -o -name '*.rst' \) -delete
ENV PATH="${PATH}:/opt/openocd/xpack-openocd-0.12.0-6/bin"

# ST-Link tools (v1.8.0)
RUN mkdir -p /opt/stlink && cd /opt/stlink && \
    wget https://github.com/stlink-org/stlink/releases/download/v1.8.0/stlink_1.8.0-1_amd64.deb && \
    # Ensure modules folder exists for depmod
    mkdir -p /lib/modules/$(uname -r) && \
    apt-get update && apt-get install --yes ./stlink_1.8.0-1_amd64.deb && \
    rm stlink_1.8.0-1_amd64.deb && \
    apt-get autoremove --yes && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd /opt && rm -rf /opt/stlink

# Set default working directory
WORKDIR /project

# Default command
CMD ["bash"]
