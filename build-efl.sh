#!/bin/bash
set -e

NOTIFY=notify-send
CTAGS=ctags

command -v $NOTIFY &>/dev/null || NOTIFY=:
command -v $CTAGS &>/dev/null || CTAGS=:

JOBS=50
ROOT="$HOME/projects"
PREFIX="$HOME/root"

PROJECTS="efl evas_generic_loaders elementary"

while getopts ":j:p:r:" opt; do
   case $opt in
      j)
         JOBS=$OPTARG
         ;;
      p)
         PREFIX=$OPTARG
         ;;
      r)
         ROOT=$OPTARG
         ;;
   esac
done

function on_exit {
   if [ $? -gt 0 ]; then
      TITLE=$PROJ
      MSG="FAILED!";
   else
      TITLE=$0
      MSG="That's All Folks!";
   fi

   echo $MSG
   $NOTIFY $TITLE "$MSG"

   unset OPTS
}
trap on_exit EXIT

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"

declare -A OPTS
OPTS[default]="--prefix=$PREFIX"
OPTS[efl]="--enable-valgrind --enable-debug"
OPTS[elementary]="--disable-build-examples --enable-edbus2 --enable-debug"

cd $ROOT

for PROJ in $PROJECTS; do
    cd $PROJ

    # Just for convenience
    echo "[Updating source tree]"
    $NOTIFY $PROJ "Updating source tree"
    git remote update --prune

    $NOTIFY $PROJ "building"
    echo "[Building $PROJ]"
    echo "[   Options: ${OPTS[default]} ${OPTS[$PROJ]} ]"

    make uninstall &>/dev/null || true

    echo "[   Cleaning...    ]"
    make clean distclean &>/dev/null || true

    echo "[   Configuring... ]"
    ./autogen.sh ${OPTS[default]} ${OPTS[$PROJ]} &>/dev/null

    echo "[   Compiling...   ]"
    make -j$JOBS > /dev/null

    echo "[   Installing...  ]"
    make install &>/dev/null
    sudo ldconfig &>/dev/null

    $NOTIFY $PROJ "DONE!"
    echo "[   Done!          ]"
    cd ..
done
