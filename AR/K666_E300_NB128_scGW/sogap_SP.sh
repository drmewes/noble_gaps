#!/bin/bash

homo=`awk '/NELECT/ {print $3/1}' $1`
lumo=`awk '/NELECT/ {print $3/1+1}' $1`
nkpt=`awk '/NKPTS/ {print $4}' $1`

e1=`egrep "^      $homo     " $1 | tail -n $nkpt | sort -n -k 3 | head -1 | awk '{print $2}'`
e2=`egrep "^      $lumo     " $1 | tail -n $nkpt | sort -n -k 3 | head -1 | awk '{print $2}'`
gap=$(echo "$e2-($e1)" | bc)

echo "HOMO: $e1 eV (band# $homo)"
echo "LUMO: $e2 eV (band# $lumo)"
echo " Gap: $gap eV"

