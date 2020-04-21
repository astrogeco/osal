#!/bin/sh

# Update submodules
cd $CFS_ROOT
git submodule foreach "git checkout master"
git submodule foreach "git pull"


# Copy current cfS component (assumed to be in current dir)
cp -r /$CFS_COMPONENT $CFS_ROOT

# Get make file and defs from cfe repo
cp $CFS_ROOT/cfe/cmake/Makefile.sample $CFS_ROOT/Makefile

cp -r $CFS_ROOT/cfe/cmake/sample_defs $CFS_ROOT/sample_defs


# Start cFE (pipe output to file), pause, send reset command, check outputs
ls $CFS_ROOT/build/exe/cpu1/

cd $CFS_ROOT/build/exe/cpu1

./core-cpu1 > cFS_startup.txt &

sleep 30

../host/cmdUtil --endian=LE --pktid=0x1806 --cmdcode=2 --half=0x0002

if [[ -n $(grep -i "warn\|err\|fail" cFS_startup.txt) ]]; then
        echo "Must resolve warn|err|fail in cFS startup before submitting a pull request"
        echo ""
        grep -i 'warn\|err\|fail' cFS_startup.txt
        exit -1
fi
