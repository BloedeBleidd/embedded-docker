# Embedded Systems Docker Image (Ubuntu 24.04 Base)

## Purpose & Audience

This Docker image is designed for **embedded software developers, CI/CD engineers, and firmware integrators** who need a reproducible, up-to-date environment for cross-platform embedded development on Linux.
It provides a comprehensive suite of modern embedded toolchains, MCU utilities, build systems, debugging interfaces, and static analysis tools—all version-locked for consistency and reliability.

**Use cases:**

* Firmware and SDK development for ARM Cortex-M, ESP32/ESP8266, and AVR microcontrollers
* Cross-platform builds and automated CI pipelines
* Static and dynamic code analysis for embedded codebases
* Hardware-in-the-loop testing with MCUs and debuggers

---

## Embedded Systems Toolchains & SDKs

* **ARM GNU Toolchain:** 14.2.1
* **Xtensa ESP Toolchain:** 14.2.0\_20241119
* **ESP-IDF:** v5.4.1
* **AVR Toolchain:** 7.3.0 (GCC), 2.26 (Binutils), 2.0.0 (Libc)
* **avrdude:** 7.1

---

## Native Compilers & Build Systems

* **gcc / g++:** 13.2.0
* **make:** 4.3
* **cmake:** 3.28.3
* **ninja:** 1.11.1
* **scons:** 4.5.2
* **flex:** 2.6.4
* **bison:** 3.8.2
* **gperf:** 3.1
* **ccache:** 4.9.1
* **lcov:** 2.0

---

## MCU Operation & Debugging Tools

* **xPack OpenOCD:** 0.12.0
* **ST-Link Tools:** 1.8.0
* **pyocd:** 0.36.0 (Python)
* **pyserial:** 3.5 (Python)

---

## Static & Dynamic Analysis Tools

* **cppcheck:** 2.13.0
* **flawfinder:** 2.0.19
* **vera++:** 1.2.1
* **clang-tidy:** 18.0
* **clang-format:** 18.0
* **valgrind:** 3.22.0

---

## Additional Development Libraries & Utilities

* **git:** 2.43.0
* **wget:** 1.21.4
* **curl:** 8.5.0
* **unzip:** 6.0
* **nano:** 7.2
* **file:** 5.45
* **pkg-config:** 1.8.1
* **libusb:** 1.0.27
* **kmod:** 31
* **python:** 3.12.3
* **pip:** 24.0
* **virtualenv:** 20.31.2
* **gcovr:** 8.3
* **pycryptodome:** 3.23.0
* **pycryptodomex:** 3.23.0
* **ecdsa:** 0.19.1
* **pyelftools:** 0.32
* **anybadge:** 1.16.0

---

## Usage

* **Working directory:** `/project`
* **Default shell:** `bash`
* **USB and device passthrough** may require extra Docker options for debugging/programming MCUs.

Pull the image:

```bash
docker pull bloedebleidd/embedded:compact-1.1.0
```

Run with your project:

```bash
docker run --rm -it -v "$PWD":/project bloedebleidd/embedded:compact-1.1.0
```

---

**All versions are pinned as of June 2025. Image is stripped of documentation and non-essential files for size and security.**
