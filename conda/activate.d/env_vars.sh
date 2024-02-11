#!/bin/sh

# Can change this
# Our HomeDir and TMP are on an NFS
# MPI does not like that. 
# So here we set it to shared memory
export OLD_TMP=$TMP
export TMP=/dev/shm/$USER
export TMPDIR=$TMP
mkdir -p $TMP
