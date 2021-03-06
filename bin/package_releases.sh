#!/bin/bash

# ----------------------------------------------------------------------------
#
#  K-Meter
#  =======
#  Implementation of a K-System meter according to Bob Katz' specifications
#
#  Copyright (c) 2010 Martin Zuther (http://www.mzuther.de/)
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  Thank you for using free software!
#
# ----------------------------------------------------------------------------

KMETER_VERSION="1.22"

KMETER_EXECUTABLE_DIR="final"
KMETER_RELEASE_DIR="releases"
KMETER_DOCUMENTATION_DIR="../doc"

function move_new_executable
{
	if [ -f "$1" ]; then
		mv "$1" "$KMETER_EXECUTABLE_DIR"/
	fi
}

function fill_archive
{
	if [ ! -d "$2" ]; then
		mkdir -p "$2"
	fi

	if [ -f "$1" ]; then
		echo "    $1"
		cp "$1" "$2"
	fi
}

function delete_old_archive
{
	if [ -f "$1" ]; then
		echo "  Deleting old archive \"$1\"..."
		rm "$1"
	fi
}

function create_new_archive
{
	echo "  Creating folder \"$1\"..."
	echo "  Copying files to \"$1\"..."
	mkdir -p "$1"
	echo
}

function compress_new_archive
{
	echo
	echo "  Creating archive \"$1\"..."
	echo

	if [ "$3" = "bzip2" ]; then
		tar --create --bzip2 --verbose --file "$1" "$2"/* | gawk ' { print "    adding: " $1 } '
	elif [ "$3" = "zip" ]; then
		zip --recurse-paths "$1" "$2"/* | gawk ' { print "  " $0 } '
	fi

	echo
	echo "  Removing folder \"$2\"..."

	rm -r "$2"/

	echo "  Done."
	echo
}

echo


# ----- GNU/Linux Standalone (32 bit) -----

echo "  === GNU/Linux Standalone v$KMETER_VERSION (32 bit) ==="
echo

move_new_executable "kmeter_stereo"
move_new_executable "kmeter_surround"

delete_old_archive "$KMETER_RELEASE_DIR/linux32/kmeter-standalone.tar.bz2"

KMETER_ARCHIVE_DIR="kmeter-standalone_$KMETER_VERSION"

create_new_archive "$KMETER_ARCHIVE_DIR"

fill_archive "$KMETER_EXECUTABLE_DIR/kmeter_stereo" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_EXECUTABLE_DIR/kmeter_surround" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/LICENSE" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/kmeter.pdf" "$KMETER_ARCHIVE_DIR"

compress_new_archive "$KMETER_RELEASE_DIR/linux32/$KMETER_ARCHIVE_DIR.tar.bz2" "$KMETER_ARCHIVE_DIR" "bzip2"


# ----- GNU/Linux VST (32 bit) -----

echo "  === GNU/Linux VST v$KMETER_VERSION (32 bit) ==="
echo

move_new_executable "kmeter_stereo.so"
move_new_executable "kmeter_surround.so"

delete_old_archive "$KMETER_RELEASE_DIR/linux32/kmeter-vst.tar.bz2"

KMETER_ARCHIVE_DIR="kmeter-vst_$KMETER_VERSION"

create_new_archive "$KMETER_ARCHIVE_DIR"

fill_archive "$KMETER_EXECUTABLE_DIR/kmeter_stereo.so" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_EXECUTABLE_DIR/kmeter_surround.so" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/LICENSE" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/kmeter.pdf" "$KMETER_ARCHIVE_DIR"

compress_new_archive "$KMETER_RELEASE_DIR/linux32/$KMETER_ARCHIVE_DIR.tar.bz2" "$KMETER_ARCHIVE_DIR" "bzip2"


# ----- Windows Standalone (32 bit) -----

echo "  === Windows Standalone v$KMETER_VERSION (32 bit) ==="
echo

move_new_executable "K-Meter (Stereo).exe"
move_new_executable "K-Meter (Surround).exe"

delete_old_archive "$KMETER_RELEASE_DIR/w32/kmeter-standalone.zip"

KMETER_ARCHIVE_DIR="kmeter-standalone_$KMETER_VERSION"

create_new_archive "$KMETER_ARCHIVE_DIR"

fill_archive "$KMETER_EXECUTABLE_DIR/K-Meter (Stereo).exe" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_EXECUTABLE_DIR/K-Meter (Surround).exe" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/LICENSE" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/kmeter.pdf" "$KMETER_ARCHIVE_DIR"

fill_archive "COPYRIGHT_FFTW" "$KMETER_ARCHIVE_DIR"
fill_archive "LICENSE_FFTW" "$KMETER_ARCHIVE_DIR"
fill_archive "libfftw3f-3.dll" "$KMETER_ARCHIVE_DIR"

compress_new_archive "$KMETER_RELEASE_DIR/w32/$KMETER_ARCHIVE_DIR.zip" "$KMETER_ARCHIVE_DIR" "zip"


# ----- Windows VST (32 bit) -----

echo "  === Windows VST v$KMETER_VERSION (32 bit) ==="
echo

move_new_executable "K-Meter (Stereo).dll"
move_new_executable "K-Meter (Surround).dll"

delete_old_archive "$KMETER_RELEASE_DIR/w32/kmeter-vst.zip"

KMETER_ARCHIVE_DIR="kmeter-vst_$KMETER_VERSION"

create_new_archive "$KMETER_ARCHIVE_DIR"

fill_archive "$KMETER_EXECUTABLE_DIR/K-Meter (Stereo).dll" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_EXECUTABLE_DIR/K-Meter (Surround).dll" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/LICENSE" "$KMETER_ARCHIVE_DIR"
fill_archive "$KMETER_DOCUMENTATION_DIR/kmeter.pdf" "$KMETER_ARCHIVE_DIR"

fill_archive "COPYRIGHT_FFTW" "$KMETER_ARCHIVE_DIR"
fill_archive "LICENSE_FFTW" "$KMETER_ARCHIVE_DIR"
fill_archive "libfftw3f-3.dll" "$KMETER_ARCHIVE_DIR"

compress_new_archive "$KMETER_RELEASE_DIR/w32/$KMETER_ARCHIVE_DIR.zip" "$KMETER_ARCHIVE_DIR" "zip"
