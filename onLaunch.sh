#!/usr/bin/env bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y build-essential git python-pip libfreetype6-dev libxft-dev libncurses-dev libopenblas-dev gfortran python-matplotlib libblas-dev liblapack-dev libatlas-base-dev python-dev python-pydot linux-headers-generic linux-image-extra-virtual unzip python-numpy swig python-pandas python-sklearn unzip wget pkg-config zip g++ zlib1g-dev
sudo pip install -U pip
sudo apt-get install awscli -y

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda
echo "PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}" > .bash_profile
echo "LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> .bash_profile

# https://developer.nvidia.com/rdp/cudnn-download
aws s3 cp s3://warren-datasets/cudnn-8.0-linux-x64-v5.1.tgz .
tar xvzf cudnn-8.0-linux-x64-v5.1.tgz
sudo cp -r cuda/include/cudnn.h /usr/local/cuda/include
sudo cp -r cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
echo "CUDA_HOME=/usr/local/cuda" >> .bash_profile
echo "CUDA_ROOT=/usr/local/cuda" >> .bash_profile
echo "PATH=$PATH:$CUDA_ROOT/bin" >> .bash_profile
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64" >> .bash_profile

export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export  PATH=$PATH:$CUDA_ROOT/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

sudo pip install tensorflow-gpu
wget https://github.com/awentzonline/image-analogies/releases/download/v0.0.5/vgg16_weights.h5
sudo pip install neural-image-analogies
wget https://raw.githubusercontent.com/awentzonline/image-analogies/master/scripts/make_image_analogy.py
sudo reboot
##The following should only be used if you want to build tensorflow yourself
#sudo add-apt-repository -y ppa:webupd8team/java
#sudo apt-get update -y
#echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
#echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
#sudo apt-get install -y oracle-java8-installer
#echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
#curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
#sudo apt-get update && sudo apt-get install -y bazel
#sudo apt-get upgrade -y bazel
#
#git clone https://github.com/tensorflow/tensorflow
#cd tensorflow
#./configure
## all default except:
## 1. Do you wish to build TensorFlow with CUDA support? [y/N] y
## 2. Please specify the CUDA SDK version you want to use, e.g. 7.0. [Leave empty to use system default]: 8.0
## 3. Please specify the Cudnn version you want to use. [Leave empty to use system default]: 5.1.5
#bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
#bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
#sudo pip install /tmp/tensorflow_pkg/tensorflow-0.10.0-py2-none-any.whl