#!/usr/bin/env bash

TMPDIR=$(mktemp -d -q)
REPO=$(pwd)

mkdir -p $(pwd)/history

pushd $TMPDIR > /dev/null 2>&1
git clone $REPO 2> /dev/null 1>&2
cd $(basename $REPO)
echo "In $(basename $REPO)"

for F in $(git log --children | grep commit\   | sed "s;commit ;;" | tac | xargs echo); do
   git checkout $F 2> /dev/null 1>&2
   echo $(git show -s --format=%ct $F)
   sltxrc doggo.tex 2> /dev/null 1>&2
   mv "./doggo.pdf" "$REPO/history/doggo $(git show -s --format=%ct $F) $(git show -s --format=%s $F).pdf"
done

popd > /dev/null

rm -rf $TMPDIR