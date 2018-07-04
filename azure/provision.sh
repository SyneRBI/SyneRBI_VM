#!/bin/bash

apt-get update
apt-get install -y build-essential git g++ wget curl python-pip

python -m pip install --upgrade pip
python -m pip install setuptools
python -m pip install jupyter

# Download data
mkdir -p ~/data
cd ~/data

wget https://zenodo.org/record/1304454/files/NEMA_IQ.zip
mv NEMA_IQ.zip NEMA.zip

mkdir -p /home/sirfuser/.local/bin
export PATH=${PATH}:/home/sirfuser/.local/bin
echo 'export PATH=${PATH}:/home/sirfuser/.local/bin' >> /home/sirfuser/.bashrc
#source /home/sirfuser/.bashrc

mkdir -p ~/devel

# Build SIRF via VM scripts
cd ~/devel
git clone https://github.com/CCPPETMR/CCPPETMR_VM.git
cd CCPPETMR_VM

bash scripts/INSTALL_prerequisites_with_apt-get.sh -j 4

# Update cmake
cd ~/devel
apt-get purge -n cmake
curl -0 https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.tar.gz -o cmake.tar.gz
tar xzf cmake.tar.gz
cd cmake-3.7.2-Linux-x86_64
sudo cp -r bin /usr/
sudo cp -r share /usr/
sudo cp -r doc /usr/share/
sudo cp -r man /usr/share/
cd ..
rm cmake.tar.gz

cd ~/devel/CCPPETMR_VM
bash scripts/UPDATE.sh -j 4

source /home/sirfuser/.sirfrc

# Get any extra data
cd /home/sirfuser/devel/SIRF-Exercises/scripts
bash download_MR_data.sh
bash download_PET_data.sh

# Configure Jupyter
cd /tmp
mv /tmp/jupyter.service /etc/systemd/system/jupyter.service

mkdir -p /srv/jupyter
mv /tmp/launch.sh /srv/jupyter
chmod +x /srv/jupyter/launch.sh

#curl -O https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
#bash Anaconda3-4.4.0-Linux-x86_64.sh -b
#rm Anaconda3-4.4.0-Linux-x86_64.sh
#export PATH=${PATH}:/home/sirfuser/anaconda3/bin
#echo 'export PATH=${PATH}:/home/sirfuser/anaconda3/bin' >> /home/sirfuser/.bashrc

mkdir /home/sirfuser/.jupyter
#conda install nb_conda -y
jupyter-notebook --generate-config --allow-root
cd /home/sirfuser/.jupyter
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj "/C=UK/ST=London/L=London/O=University College London/OU=Institute of Nuclear Medicine/CN=." \
-keyout mycert.pem -out mycert.pem \

echo "c= get_config()" >> jupyter_notebook_config.py
echo "c.NotebookApp.certfile = u'/home/sirfuser/.jupyter/mycert.pem'" >> jupyter_notebook_config.py
echo "c.NotebookApp.password = u'sha1:e37551d8aead:2d117c5cb4b60b9f9e01c60c7cdf44e7a7a3681b'" >> jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> jupyter_notebook_config.py
echo "c.NotebookApp.port = 9999" >> jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> jupyter_notebook_config.py

chown -R sirfuser:sirfuser /home/sirfuser
