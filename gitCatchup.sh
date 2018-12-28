#!/bin/bash

for d in */;
do
  echo $d
  cd $d

  if [ $? -eq 0 ];
  then
    git fetch
    git pull

    if [ $? -ne 0 ];
    then
      git stash
      git pull
    fi
    cd ..
  fi
done
