#!/bin/bash

# Before we can start using TigerBeetle, we need to download or compile it!

# Uncomment one of the following lines to download the precompiled binary for your platform:

# macOS
# curl -Lo tigerbeetle.zip https://mac.tigerbeetle.com && unzip tigerbeetle.zip

# Linux
#curl -Lo tigerbeetle.zip https://linux.tigerbeetle.com && unzip tigerbeetle.zip

# Windows
#powershell -command "curl.exe -Lo tigerbeetle.zip https://windows.tigerbeetle.com; Expand-Archive tigerbeetle.zip .; .\tigerbeetle version"

# Or build it from source:
git clone https://github.com/tigerbeetle/tigerbeetle ../workspace/tigerbeetle
pushd ../workspace/tigerbeetle
./zig/download.sh # or .bat if you're on Windows.
zig/zig build
popd
cp ../workspace/tigerbeetle/tigerbeetle ./tigerbeetle

./tigerbeetle version
