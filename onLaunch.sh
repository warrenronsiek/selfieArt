#!/usr/bin/env bash

ssh -i 'selfie-art.pem' ubuntu@54.191.109.187
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential git python-pip libfreetype6-dev libxft-dev libncurses-dev libopenblas-dev gfortran python-matplotlib libblas-dev liblapack-dev libatlas-base-dev python-dev python-pydot linux-headers-generic linux-image-extra-virtual unzip python-numpy swig python-pandas python-sklearn unzip wget pkg-config zip g++ zlib1g-dev
sudo pip install -U pip
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
rm cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda

# scp -i "~/Keys/selfie-art.pem" cudnn-8.0-linux-x64-v5.0-ga.tgz ubuntu@54.218.14.139:/home/ubuntu
# https://developer.nvidia.com/rdp/cudnn-download
tar -xvf cudnn-8.0-linux-x64-v5.0-ga.tgz
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo reboot
export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer

echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install bazel
sudo apt-get upgrade bazel

git clone --recurse-submodules https://github.com/tensorflow/tensorflow
cd tensorflow
TF_UNOFFICIAL_SETTING=1 ./configure

bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
sudo pip install --upgrade /tmp/tensorflow_pkg/tensorflow-1.0.0-cp27-cp27mu-linux_x86_64.whl