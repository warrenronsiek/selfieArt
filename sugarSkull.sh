#!/usr/bin/env bash


IMAGE_B=/home/ubuntu/selfie4.jpg
PREFIX=deanRussoSelfie
VGG_WEIGHTS=${3-vgg16_weights.h5}
PATCH_SIZE=3  # try 1 for less interesting, but faster-rendering effects
SKULL_IMAGE_A=/home/ubuntu/deanRussoBlur.jpg
SKULL_IMAGE_AP=/home/ubuntu/deanRusso.jpg

make_image_analogy.py \
  $SKULL_IMAGE_A $SKULL_IMAGE_AP \
  $IMAGE_B \
  out/$PREFIX-sugarskull/$PREFIX-Bp  \
  --mrf-w=1.5 \
  --a-scale-mode=match \
  --patch-size=$PATCH_SIZE \
  --contrast=1 \
  --vgg-weights=$VGG_WEIGHTS --output-full


nohup make_image_analogy.py /home/ubuntu/sugarskull-A.jpg /home/ubuntu/sugarskull-Ap.jpg /home/ubuntu/selfie4.jpg /home/ubuntu/selfieskull \
  --mrf-w=1.5 \
  --a-scale-mode=match \
  --patch-size=3 \
  --contrast=1 \
  --vgg-weights=${3-vgg16_weights.h5} --output-full &

nohup make_image_analogy.py /home/ubuntu/deanRussoBlur.jpg /home/ubuntu/deanRusso.jpg /home/ubuntu/selfie4.jpg /home/ubuntu/selfieskull \
  --mrf-w=1.5 \
  --a-scale-mode=match \
  --patch-size=3 \
  --contrast=1 \
  --vgg-weights=${3-vgg16_weights.h5} --output-full &