#!/bin/bash

OS=`uname -s`

if [ "$OS" != "Darwin" ] && [ "$OS" != "Linux" ]; then
    echo "error: unsupported OS $OS"
    exit 1
fi

OBJ_DIR=/home/alios

echo ""
echo -n "install dependent software packages ..."
if [ "$OS" = "Darwin" ]; then
    if [ "`which brew`" = "" ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    if [ "`which pip`" = "" ];then
         easy_install pip > /dev/null
    fi
    if [ "`which gcc`" = "" ];then
        brew install gcc > /dev/null
    fi
    if [ "`which wget`" = "" ];then
        brew install wget > /dev/null
    fi
    if [ "`which git`" = "" ];then
        brew install git > /dev/null
    fi
    if [ "`which python`" = "" ];then
        brew install python > /dev/null
    fi
    TOOLCHAINS_URL="https://code.aliyun.com/vivid8710/aos-toolchain-osx.git"
    PIP_CMD=pip
else #Some Linux version
    if [ "`uname -m`" = "x86_64" ]; then
        if [ "`which apt-get`" != "" ]; then
             apt-get update > /dev/null
             apt-get -y install git wget make flex bison gperf unzip python-pip > /dev/null
             apt-get -y install gcc-multilib > /dev/null
             apt-get -y install libssl-dev libssl-dev:i386 > /dev/null
             apt-get -y install libncurses-dev libncurses-dev:i386 > /dev/null
             apt-get -y install libreadline-dev libreadline-dev:i386 > /dev/null
        elif [ "`which yum`" != "" ]; then
             yum -y install git wget make flex bison gperf unzip python-pip > /dev/null
             yum -y install gcc gcc-c++ glibc-devel glibc-devel.i686 libgcc libgcc.i686 > /dev/null
             yum -y install libstdc++-devel libstdc++-devel.i686 > /dev/null
             yum -y install openssl-devel openssl-devel.i686 > /dev/null
             yum -y install ncurses-devel ncurses-devel.i686 > /dev/null
             yum -y install readline-devel readline-devel.i686 > /dev/null
        elif [ "`which pacman`" != "" ]; then
             pacman -Sy
             pacman -S --needed gcc git wget make ncurses flex bison gperf unzip python2-pip > /dev/null
            PIP_CMD=pip2
        else
            echo "error: unknown package manerger"
            exit 1
        fi
        TOOLCHAINS_URL="https://code.aliyun.com/vivid8710/aos-toolchain-linux64.git"
    else
        if [ "`which apt-get`" != "" ]; then
             apt-get -y install git wget make flex bison gperf unzip python-pip > /dev/null
             apt-get -y install libssl-dev libncurses-dev libreadline-dev > /dev/null
        elif [ "`which yum`" != "" ]; then
             yum -y install git wget make flex bison gperf unzip python-pip > /dev/null
             yum -y install gcc gcc-c++ glibc-devel libgcc libstdc++-devel > /dev/null
             yum -y install openssl-devel ncurses-devel readline-devel > /dev/null
        elif [ "`which pacman`" != "" ]; then
             pacman -Sy
             pacman -S --needed gcc git wget make ncurses flex bison gperf unzip python2-pip > /dev/null
            PIP_CMD=pip2
        else
            echo -e "\error: unknown package manerger\n"
            exit 1
        fi
        TOOLCHAINS_URL="https://code.aliyun.com/vivid8710/aos-toolchain-linux32.git"
    fi
    PIP_CMD=pip
fi
 ${PIP_CMD} install pyserial aos-cube > /dev/null 2>&1
 ${PIP_CMD} install --upgrade pyserial aos-cube > /dev/null 2>&1
echo "done"

cd ${OBJ_DIR}/../
rm -rf ${OBJ_DIR}
#echo -n "cloning AliOS Things code..."
ALIOS_THINGS_URL="https://code.aliyun.com/vivid8710/AliOS-Things.git"
#git clone -q ${ALIOS_THINGS_URL} ${OBJ_DIR}
if [ $? -ne 0 ]; then
    echo -e "\error: clone code failed\n"
    exit 1
fi
#echo "done"

echo -n "installing toolchains ..."
git clone -q ${TOOLCHAINS_URL} toolchain
if [ $? -ne 0 ]; then
    echo -e "\error: download toolchain failed\n"
    exit 1
fi

mkdir -p ${OBJ_DIR}/build/
mv toolchain/compiler ${OBJ_DIR}/build/
rm -rf toolchain
echo "done"

echo -n "installing OpenOCD ..."
OPENOCD_URL="https://code.aliyun.com/vivid8710/aos-openocd.git"
git clone -q ${OPENOCD_URL} openocd
if [ $? -ne 0 ]; then
    echo -e "\error: download OpenOCD failed\n"
    exit 1
fi
mv openocd/OpenOCD ${OBJ_DIR}/build/
rm -rf openocd
echo "done"

mkdir -p ${OBJ_DIR}/platform/mcu/esp8266/
mkdir -p ${OBJ_DIR}/platform/mcu/esp32/
echo -n "installing esptool ..."
OPENOCD_URL="https://code.aliyun.com/vivid8710/aos-esptool.git"
git clone -q ${OPENOCD_URL} esptool
if [ $? -ne 0 ]; then
    echo -e "\error: download esptool failed\n"
    exit 1
fi
cp -rf esptool/esptool_py ${OBJ_DIR}/platform/mcu/esp32/
mv esptool/esptool_py ${OBJ_DIR}/platform/mcu/esp8266/
rm -rf esptool
echo "done"

echo "install finished!"
