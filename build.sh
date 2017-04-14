#!/bin/bash


# Reset
COLOR_OFF='\033[0m'       # Text Reset

# Regular Colors
COLOR_BLACK='\033[0;30m'        # Black
COLOR_RED='\033[0;31m'          # Red
COLOR_GREEN='\033[0;32m'        # Green
COLOR_YELLOW='\033[0;33m'       # Yellow
COLOR_BLUE='\033[0;34m'         # Blue
COLOR_PURPLE='\033[0;35m'       # Purple
COLOR_CYAN='\033[0;36m'         # Cyan
COLOR_WHITE='\033[0;37m'        # White


THIS_SCRIPT_DIR=$(readlink -f $(dirname $0))

P_GREEN()
{
    echo -e -n $COLOR_GREEN
    echo $@
    echo -e -n $COLOR_OFF
}

MAIN()
{
    local PROJECT_FILE=""
    local ARCH=$(uname -p)
    local TOOLCHAIN_PATH=""
    local TOOLCHAIN_PREFIX=""
    local TARGET_SYSROOT_PATH="/"
    local INSTALL_PREFIX="bin"

    while [[ $# -gt 1 ]]; do
    key="$1"
    case $key in
        --project)
        PROJECT_FILE="$2"
        shift # past argument
        ;;
        --arch)
        ARCH="$2"
        shift # past argument
        ;;
        --crosspath)
        TOOLCHAIN_PATH="$2"
        shift # past argument
        ;;
        --crossprefix)
        TOOLCHAIN_PREFIX="$2"
        shift # past argument
        ;;
         --sysroot)
        SYSROOT_PATH="$2"
        shift # past argument
        ;;
         --install)
        INSTALL_PREFIX="$2"
        shift # past argument
        ;;
        --default)
        DEFAULT=YES
        ;;
        *)
                # unknown option
        ;;
    esac
    shift # past argument or value
    done


    KIT_NAME="build-${ARCH}"


    P_GREEN "################################################################################"
    P_GREEN "# "
    P_GREEN "################################################################################"
    P_GREEN "Project          : ${PROJECT_FILE}"
    P_GREEN "Architecture     : ${ARCH}"
    P_GREEN "Toolchain path   : ${TOOLCHAIN_PATH}"
    P_GREEN "Toolchain prefix : ${TOOLCHAIN_PREFIX}"
    P_GREEN "Sysroot          : ${SYSROOT_PATH}"
    P_GREEN "Install prefix   : ${INSTALL_PREFIX}"
    P_GREEN "################################################################################"

    rm -rf build-*

    # Setup new kit
    qbs-config --unset "profiles.${KIT_NAME}"

    qbs-config profiles.${KIT_NAME}.cpp.compilerName g++
    qbs-config profiles.${KIT_NAME}.cpp.linkerName g++
    qbs-config profiles.${KIT_NAME}.cpp.toolchainInstallPath ${TOOLCHAIN_PATH}
    qbs-config profiles.${KIT_NAME}.cpp.toolchainPrefix ${TOOLCHAIN_PREFIX}
    qbs-config profiles.${KIT_NAME}.cpp.sysroot ${SYSROOT_PATH}

    qbs-config profiles.${KIT_NAME}.qbs.architecture ${ARCH}
    qbs-config profiles.${KIT_NAME}.qbs.targetOS linux
    qbs-config profiles.${KIT_NAME}.qbs.toolchain gcc
    qbs-config profiles.${KIT_NAME}.qbs.buildVariant release

    qbs clean --clean-install-root --file ${PROJECT_FILE} profile:${KIT_NAME} build-${ARCH}-release

    qbs install --file ${PROJECT_FILE} --install-root ${INSTALL_PREFIX} profile:${KIT_NAME} build-${ARCH}-release


    echo "Done"
}


MAIN $@

echo $?
exit $?
