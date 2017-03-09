SelfieArt
=========

Using tensorflow [image analogies](https://github.com/awentzonline/image-analogies) to turn selfies into Art!

Instructions
--------

1. Use either of the cloudformation templates to launch your instance (you will have to change your security group, VPC, etc.)
2. Run the script onLaunch once you have logged into the instance. Note that you need to download and scp CUDNN into the instance.

Pro Tips
--------

Do not use the g2 series instances - the GPUs only work with legacy NVIDIA drivers, and this significantly complicates Tensorflow Installation.

Thanks
------
1. [This excellent AWS blog](https://alestic.com/2010/02/ec2-resize-running-ebs-root/) helped me resize instances.
2. [This blog](http://expressionflow.com/2016/10/09/installing-tensorflow-on-an-aws-ec2-p2-gpu-instance/) for a boilerplate on how to set this up.
 