SelfieArt
=========

Using tensorflow [image analogies](https://github.com/awentzonline/image-analogies) to turn selfies into Art!

Instructions
--------

1. Use either of the cloudformation templates to launch your instance (you will have to change your security group, VPC, etc.)
2. Download CUDNN and put it in a bucket that your cloudformation has specified access.
3. Follow the instructions at [image analogies](https://github.com/awentzonline/image-analogies) to install the package and network weights.

Pro Tips
--------

* Do not use the g2 series instances - the GPUs only work with legacy NVIDIA drivers, and this significantly complicates Tensorflow Installation.
* Use instanceResize.sh if you already have instances and you need more space on their root directory to install TF.
* Use scp to get images into the instance, for some reason wget

Thanks
------

1. [This excellent AWS blog](https://alestic.com/2010/02/ec2-resize-running-ebs-root/) helped me resize instances.
2. [This blog](http://expressionflow.com/2016/10/09/installing-tensorflow-on-an-aws-ec2-p2-gpu-instance/) for a boilerplate on how to set this up.
 