#!/bin/sh
if [ ! $CELL_SDK ] 
then
 echo "CELL_SDK is not set, please read README.md and sce_profile.sh to see variables and directories needed"
 exit 1
fi

if [ ! -d $CELL_SDK/work/sdk ] 
then
 echo "/usr/local/cell/work/sdk does not exist, please read and sce_profile.sh to see files and directories needed"
 exit 1
fi

if [ ! -f $CELL_SDK/work/sdk/toolchain-src-3.6.0-GCC411.zip ]
then
 echo "toolchain-src-3.6.0-GCC411.zip is not available, please read README.md"
 exit 1
fi
if [ ! -f $CELL_SDK/work/sdk/[78]-PS3_SDK-360_001.zip ]
then
 echo "[78]-PS3_SDK-360_001.zip is not available, please read README.md"
 exit 1
fi
if [ ! -f $CELL_SDK/work/sdk/[159]-PS3_SDK-360_002.zip ]
then
 echo "[159]-PS3_SDK-360_002.zip is not available, please read README.md"
 exit 1
fi
if [ ! -f $CELL_SDK/work/sdk/[166]-PS3_SDK_Samples-360_001.zip ]
then
 echo "[166]-PS3_SDK_Samples-360_001.zip is not available, please read README.md"
 exit 1
fi
echo "Decompressing Sony's SDK 3.60..."
unzip -qq $CELL_SDK/work/sdk/[78]-PS3_SDK-360_001.zip -d  /usr/local
unzip -qq $CELL_SDK/work/sdk/[159]-PS3_SDK-360_002.zip -d  /usr/local
echo "Decompressing Sony's SDK 3.60 Samples..."
unzip -qq $CELL_SDK/work/sdk/[166]-PS3_SDK_Samples-360_001.zip -d /usr/local
echo "Decompressing Sony's SDK 3.60 Doc if it is available..."
if [ -f $CELL_SDK/work/sdk/[28]-PS3_SDKDoc-360_01-CHM-English.zip ]
then
 unzip -qq $CELL_SDK/work/sdk/[28]-PS3_SDKDoc-360_01-CHM-English.zip -d  /usr/local
fi
if [ -f $CELL_SDK/work/sdk/[29]-PS3_SDKDoc-360_01-Help2-English.zip ]
then
 unzip -qq $CELL_SDK/work/sdk/[29]-PS3_SDKDoc-360_01-Help2-English.zip -d /usr/local
fi
if [ -f $CELL_SDK/work/sdk/[30]-PS3_SDKDoc-360_01-HTML-English.zip ]
then
 unzip -qq $CELL_SDK/work/sdk/[30]-PS3_SDKDoc-360_01-HTML-English.zip -d /usr/local
fi
if [ -f $CELL_SDK/work/sdk/[31]-PS3_SDKDoc-360_01-Latest-English.zip ]
then
 unzip -qq $CELL_SDK/work/sdk/[31]-PS3_SDKDoc-360_01-Latest-English.zip -d /usr/local
fi

echo "Decompressing Sony's Toolchain sources...\n"
unzip -qq $CELL_SDK/work/sdk/toolchain-src-3.6.0-GCC411.zip -d  src
echo "Patching sources to compile under osx"
mkdir build
cd src
patch -p1 < ../patches/patch.txt
echo "Add exec permission to customs build scripts for osx"
chmod 755 *.sh
cd ../build
echo "Start configuring and compiling toolchain..."
../src/build-osx.sh
OUTPUT=$?
if [ $OUTPUT -eq 0 ]
then
 echo "Toolchain and SDK installed. Have a lot of fun..."
else
 echo "Error found $OUTPUT, please check logs. Toochain is not installed correctly"
 exit 1
fi
echo "Making backup of mk directory"
cd $CELL_SDK/samples
tar cvf mk.tar ./mk
cd $CELL_SDK/samples/mk
echo "Patching sdk makefiles to use gcc linker instead of snsys and using new host-osx directory for compiler and tools"
patch -p1 < $CELL_SDK/work/patches/patch_mk.txt
echo "Creating $CELL_SDK/host-osx/bin directory with custom wine command for tools not availables on toolchain sources"
mkdir $CELL_SDK/host-osx/bin
cp $CELL_SDK/work/scripts/host-osx/* $CELL_SDK/host-osx/bin
chmod +x $CELL_SDK/host-osx/bin/*
