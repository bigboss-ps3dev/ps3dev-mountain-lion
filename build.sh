#!/bin/sh
case "$1" in
sony)
echo "Build Sony's toolchain and SDK 3.60..."
. ./sce_profile.sh
./build_sony.sh
;;
ps3dev)
echo "Build homebrew toolchain and libs..."
. ./ps3dev_profile.sh
./build_ps3dev.sh
;;
*)
echo "Usage $0 {sony|ps3dev}"
exit 1
esac

exit 0
