#!/bin/bash
#
echo "Updating from your version of the VM via this script is unfortunately no longer supported."
echo "Please instead do the following:"
echo "     # Recommended first step: clean-out"
echo "    rm -rf ~/devel/buildVM ~/devel/install ~/devel/SyneRBI_VM"
echo "     # Actual update:"
echo "    cd ~/devel/SIRF-SuperBuild"
echo "    git fetch; git reset --hard origin/master"
echo "    VirtualBox/scripts/UPDATE.sh -s"
echo ""
echo "You should then be able to update as usual."
echo "Apologies."
exit 1

