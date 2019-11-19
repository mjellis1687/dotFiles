#!/bin/bash

usage()
{
	echo "usage: installPatchedControlOctave.sh -v version | [-h]"
}

version=

while [ "$1" != "" ]; do
	case $1 in
		-v | --version )		shift
								version=$1
								;;
		-h | --help )			usage
								exit
	esac
	shift
done

if [ "$version" = "" ]; then
	echo "Must specify the version"
	usage
	exit
elif [[ "$version" == [0-9]* ]]; then
	version="control-$version"
fi

# Potentially want to discard changes to the Makefile when switching branches
cd octave-control
hg update -r $version -C

# This is the patch applied to slicot
echo "Patching SLICOT for LAPACK ..."
# tar zxvf .tmp/control.tar.gz
# cd control/src
cd src
# tar zxvf slicot.tar.gz
# sed -i'.orig' 's/DGEGS/DGGES/g' slicot/src/SG03AD.f slicot/src/SG03BD.f
# sed -i'.orig' 's/DLATZM/DORMRZ/g' slicot/src/AB08NX.f slicot/src/AG08BY.f slicot/src/SB01BY.f slicot/src/SB01FY.f
sed -i'.orig' '/tar -xzf slicot.tar.gz/d' Makefile
# mv slicot.tar.gz slicot.tar.gz.orig
# tar -czvf slicot.tar.gz slicot
cd ..

mkdir -p target/$version
cp COPYING DESCRIPTION INDEX Makefile NEWS target/$version
cp -r doc target/$version
cp -r inst target/$version
cp -r src target/$version
cd target/$version/src
./bootstrap
rm -r autom4te.cache
cd ../../..
chmod -R a+rX,u+w,go-w target/$version
tar -c -f - --posix -C "target" $version | gzip -9n > "target/$version.tar.gz"

# Install
echo "Installing package locally ..."
octave --no-window-system --silent --eval "pkg ('install', 'target/$version.tar.gz')"
