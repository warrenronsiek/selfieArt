#!/usr/bin/env bash

instance_id=
size=20
region=us-west-2

root_device=$(aws ec2 describe-instances \
  --region "$region" \
  --instance-ids $instance_id \
  --output text \
  --query 'Reservations[*].Instances[*].RootDeviceName')
old_volume_id=$(aws ec2 describe-instances \
  --region "$region" \
  --instance-ids $instance_id \
  --output text \
  --query 'Reservations[*].Instances[*].BlockDeviceMappings[?DeviceName==`'$root_device'`].[Ebs.VolumeId]')
zone=$(aws ec2 describe-instances \
  --region "$region" \
  --instance-ids $instance_id \
  --output text \
  --query 'Reservations[*].Instances[*].Placement.AvailabilityZone')
echo "instance $instance_id in $zone with original volume $old_volume_id"

aws ec2 stop-instances \
  --region "$region" \
  --instance-ids $instance_id
aws ec2 wait instance-stopped \
  --region "$region" \
  --instance-ids $instance_id

aws ec2 detach-volume \
  --region "$region" \
  --volume-id "$old_volume_id"

snapshot_id=$(aws ec2 create-snapshot \
  --region "$region" \
  --volume-id "$old_volume_id" \
  --output text \
  --query 'SnapshotId')
aws ec2 wait snapshot-completed \
  --region "$region" \
  --snapshot-ids "$snapshot_id"
echo "snapshot: $snapshot_id"

new_volume_id=$(aws ec2 create-volume \
  --region "$region" \
  --availability-zone "$zone" \
  --size "$size" \
  --snapshot "$snapshot_id" \
  --output text \
  --query 'VolumeId')
echo "new volume: $new_volume_id"

aws ec2 attach-volume \
  --region "$region" \
  --instance "$instance_id" \
  --device "$root_device" \
  --volume-id "$new_volume_id"
aws ec2 wait volume-in-use \
  --region "$region" \
  --volume-ids "$new_volume_id"

aws ec2 start-instances \
  --region "$region" \
  --instance-ids "$instance_id"
aws ec2 wait instance-running \
  --region "$region" \
  --instance-ids "$instance_id"
aws ec2 describe-instances \
  --region "$region" \
  --instance-ids "$instance_id"

aws ec2 delete-volume \
  --region "$region" \
  --volume-id "$old_volume_id"
aws ec2 delete-snapshot \
  --region "$region" \
  --snapshot-id "$snapshot_id"