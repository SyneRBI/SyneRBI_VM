# ChangeLog

## 2.0rc1
- upgraded to Ubuntu 18.04
- add port forwarding (8888 -> 8888 for jupyter)
- install jupyter notebook
- does not install a browser
- add cython for CIL


## 1.1.1
- added nbstripout (https://github.com/kynan/nbstripout) to handle conflicts in SIRF-Exercises

## 1.1.0
- added pip, firefox 
- added spyder and jupyer via pip
- Virtual Machine is built with Virtual Box 5.2.12

## v1.0.0
- Creation of VM is automated by a vagrant script, and a `first_run.sh` script to execute after the VM is up for the first time
- `update_VM.sh` will now by default update to the latest release (of the SuperBuild). Options have been added to modify this.
- updated base box to ubuntu-xenial64
- Virtual Machine is built with Virtual Box 5.2.8

## v0.9.2
- fixes to update script

## v0.9.1
-  Use SuperBuild as update mechanism
