#!/bin/bash

# Exit on any failure
set -e

# Update package lists
echo "# Updating package lists"
sudo apt-get update

# Ensure that CA certificates are installed
sudo apt-get -y install apt-transport-https ca-certificates zip unzip software-properties-common

# JDK
sudo add-apt-repository --yes ppa:webupd8team/java
sudo apt-get update && sudo apt-get install -y oracle-java8-installer oracle-java8-set-default

# Add Docker repository key to APT keychain
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Update where APT will search for Docker Packages
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list

# Update package lists
sudo apt-get update

# Verifies APT is pulling from the correct Repository
sudo apt-cache policy docker-ce

# Install Docker
echo "# Installing Docker"
sudo apt-get -y install docker-ce

# Add user account to the docker group
sudo usermod -aG docker $(whoami)

# Install docker compose
echo "# Installing Docker-Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.13.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Android
export ANDROID_SDK_PATH=/home/$(whoami)/android_sdk
export ANDROID_NDK_PATH=/home/$(whoami)/android_ndk

if [ -z "$ANDROID_SDK" ]; then
	export ANDROID_SDK=r25.2.2
fi

if [ -z "$ANDROID_NDK" ]; then
	export ANDROID_NDK=android-ndk-r12b
fi

export ANDROID_NDK_HOME=${ANDROID_NDK_PATH}/${ANDROID_NDK}
export ANDROID_HOME=$ANDROID_SDK_PATH

: "${ANDROID_HOME:="$ANDROID_HOME"}"
: "${ANDROID_SDK_ROOT:="$ANDROID_HOME"}"
: "${ANDROID_NDK_HOME:="$ANDROID_NDK_HOME"}"

echo "ANDROID_HOME     : $ANDROID_HOME"
echo "ANDROID_NDK_HOME : $ANDROID_NDK_HOME"
echo "ANDROID_SDK_ROOT : $ANDROID_SDK_ROOT"
echo "ERASE_ANDROID_SDK : $ERASE_ANDROID_SDK"
echo "ERASE_ANDROID_NDK : $ERASE_ANDROID_NDK"

export PATH=$PATH:$ANDROID_NDK_HOME:$ANDROID_HOME/tools

if [ "$ERASE_ANDROID_NDK" == 1 ]; then
	echo "Removing ndk directory content..."
	rm -rf ${ANDROID_NDK_PATH}/*
fi

# check if NDK is present
if hash ndk-build 2>/dev/null; then
    echo "Android NDK already exists"
else
	mkdir -p ${ANDROID_NDK_PATH}
	echo "Downloading NDK..."
	wget --no-verbose https://dl.google.com/android/repository/${ANDROID_NDK}-linux-x86_64.zip -O ${ANDROID_NDK_PATH}/ndk.zip
	unzip ${ANDROID_NDK_PATH}/ndk.zip -d ${ANDROID_NDK_PATH} && rm ${ANDROID_NDK_PATH}/ndk.zip
	echo "Android NDK has been installed to ${ANDROID_NDK_PATH}"
fi

if [ "$ERASE_ANDROID_SDK" == 1 ]; then
	echo "Removing sdk directory content..."
	rm -rf ${ANDROID_SDK_PATH}/*
fi

# check if SDK is present
if hash android 2>/dev/null; then
    echo "Android SDK already exists"
else
	mkdir -p ${ANDROID_SDK_PATH}
	echo "Downloading SDK..."
	wget --no-verbose https://dl.google.com/android/repository/tools_${ANDROID_SDK}-linux.zip -O ${ANDROID_SDK_PATH}/sdk.zip
	unzip ${ANDROID_SDK_PATH}/sdk.zip -d ${ANDROID_SDK_PATH} && rm ${ANDROID_SDK_PATH}/sdk.zip
	echo "Android SDK has been installed to ${ANDROID_SDK_PATH}"
fi

mkdir -p "$ANDROID_SDK_PATH/licenses" || true
echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_SDK_PATH/licenses/android-sdk-license"
echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "$ANDROID_SDK_PATH/licenses/android-sdk-preview-license"

echo y | android update sdk --no-ui

if [ ! -z "$ANDROID_BUILD_TOOLS_FILTER" ]; then

	IFS=',' read -ra ADDR <<< "$ANDROID_BUILD_TOOLS_FILTER"
	for i in "${ADDR[@]}"; do
		if [ ! -e "$ANDROID_HOME/build-tools/$i" ]; then
			PACKAGES=$PACKAGES,build-tools-$i
		fi
	done

	if [ ! -z "$PACKAGES" ]; then
		echo "Installing $PACKAGES"
		echo y | android update sdk -a --filter $PACKAGES --no-ui
	else
		echo "No build-tools packages to update"
	fi
fi

# Jenkins
export JENKINS_HOME=/home/$(whoami)/jenkins_home
mkdir -p $JENKINS_HOME
# sudo chown -R 1000 $JENKINS_HOME

# Print reminder of need to logout in order for these changes to take effect!
echo ''
echo "Please logout then login before continuing."