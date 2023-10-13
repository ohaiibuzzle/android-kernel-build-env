FROM debian:12
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y git wget \
    libncurses-dev build-essential bc kmod cpio flex libncurses5-dev \
    libelf-dev libssl-dev dwarves bison python3-minimal python-is-python3

RUN mkdir /toolchain /WORKDIR
WORKDIR /toolchain
# clang
RUN wget "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/main/clang-r498229b.tar.gz" -O clang.tar.gz
RUN mkdir clang && tar xvf clang.tar.gz -C clang 

# gcc 7.2 arm64
RUN wget "https://android-review.linaro.org/plugins/gitiles/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-7.2/+archive/refs/heads/master.tar.gz" -O gcc.arm64.tar.gz
RUN mkdir gcc64 && tar xvf gcc.arm64.tar.gz -C gcc64

# gcc 7.2 arm32
RUN wget "https://android-review.linaro.org/plugins/gitiles/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-7.2/+archive/refs/heads/master.tar.gz" -O gcc.arm.tar.gz
RUN mkdir gcc32 && tar xvf gcc.arm.tar.gz -C gcc32

RUN rm -rf clang.tar.gz gcc.arm64.tar.gz gcc.arm.tar.gz && apt clean
ENV PATH="/toolchain/clang/bin:/toolchain/gcc64/bin:/toolchain/gcc32/bin:$PATH"

WORKDIR /workdir
