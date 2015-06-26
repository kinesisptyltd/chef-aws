#
# Cookbook Name:: aws
#
# Copyright (C) 2015 Kinesis Pty Ltd
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

Ohai.plugin(:EC2Tags) do
  provides "ec2/tags"

  depends "ec2"

  collect_data do
    begin
      require "aws-sdk"
    rescue LoadError
      Ohai::Log.error("EC2Tags: Failed to load aws-sdk.")
      raise
    end

    ec2["region"] = ec2["placement_availability_zone"].chop

    client = Aws::EC2::Resource.new(region: ec2["region"])
    instance = client.instance(ec2["instance_id"])

    # Store all tags, snake casing attribute keys
    ec2[:tags] = instance.tags.each_with_object({}) do |t, h|
      key = t.key.include?(":") ? t.key.split(":").last : t.key
      key = key.gsub(/::/, "/")
         .gsub(/([A-Z]+)([A-Z][a-z])/,"\1_\2")
         .gsub(/([a-z\d])([A-Z])/,"\1_\2")
         .tr("-", "_")
         .downcase

      h[key] = t.value
    end

    ec2[:vpc_id] = instance.vpc_id
    ec2[:subnet_id] = instance.subnet_id
    ec2[:stack_id] = ec2[:tags][:stack_id]
    ec2[:stack_name] = ec2[:tags][:stack_name]
    ec2[:logical_id] = ec2[:tags][:logical_id]
    ec2[:autoscaling_group_name] = ec2[:tags][:group_name]
  end
end
