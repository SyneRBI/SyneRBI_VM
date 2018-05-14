#! /bin/bash
# script to install in the VM the packages needed for training.
# Originally introduced for the PSMR2018 training event.

echo "installing ipython notebook and browser"
$SUDO apt-get install -y firefox python-pip
