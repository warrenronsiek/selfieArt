SelfieArt
=========

Using tensorflow [image analogies](https://github.com/awentzonline/image-analogies) to turn selfies into Art!

Instructions
--------

1. Think of a new s3 bucket name.
2. Go into the yaml template of your choice and replace \"warren-datasets\" line 113 and 114 with your bucket name.
3. Use launchFormation.sh to create your formation. You need aws cli installed. Eg. `./launchFormation.sh your-unique-bucket-name selfieArtSuperSpotFormation`
4. [Download CUDNN](https://developer.nvidia.com/rdp/cudnn-download) and put it in the bucket you just created.
5. Done! It will take a bit to set up the formation and run the install scripts. (~30 min)

Pro Tips
--------

* Do not use the g2 series instances - the GPUs only work with legacy NVIDIA drivers, and this significantly complicates Tensorflow Installation.
* Use instanceResize.sh if you already have instances and you need more space on their root directory to install TF.
* You may need to ask for increased EC2 limits if you want to use the SuperSpotFormation.
* If something goes wrong with the install scripts, consult the logs located in `/var/log/cloud-init-output.log`
* Run `nvidia-smi` to check and see if your gpus have their drivers installed correctly. You should get a readout describing your gpus and driver version.

Thanks
------

1. [This excellent AWS blog](https://alestic.com/2010/02/ec2-resize-running-ebs-root/) helped me resize instances.
2. [This blog](http://expressionflow.com/2016/10/09/installing-tensorflow-on-an-aws-ec2-p2-gpu-instance/) for a boilerplate on how to set this up.
 