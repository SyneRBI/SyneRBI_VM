#!/bin/bash

IMG=${1}
MACHSTART=${2}
MACHSTOP=${3}

VMPREFIX="sirf"
RESGROUP="ccppetmr-vm-rg"
STOREACC="ccppetmrvmsa"

#MACHSIZE="Standard_DS3"
MACHSIZE=${4}

for (( c=$MACHSTART; c<=$MACHSTOP; c++ ))
do
    MACHNAME="${VMPREFIX}${c}"
    echo "Building $MACHNAME"
    ARGS="az vm create -g $RESGROUP -n $MACHNAME --image $IMG --admin-username sirfuser --generate-ssh-keys --public-ip-address-dns-name $MACHNAME --size $MACHSIZE"
    echo $ARGS
    $ARGS
    ARGS="az vm open-port --resource-group $RESGROUP --name $MACHNAME --port 9999"
    echo $ARGS
    $ARGS
done