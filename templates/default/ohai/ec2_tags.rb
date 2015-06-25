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
    require "aws-sdk"

    client = Aws::EC2::Resource.new(region: ec2["placement_availability_zone"].chop)
    instance = client.instance(ec2["instance_id"])

    ec2[:tags] = instance.tags.each_with_object({}) { |t, h| h[t.key] = t.value }
  end
end
