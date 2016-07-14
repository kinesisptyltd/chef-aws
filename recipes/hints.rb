#
# Cookbook Name:: aws
# Recipe:: hints
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

ohai_hint "ec2"

ohai_plugin "EC2 Tags" do
  name "ec2_tags"
  source_file "ohai/ec2_tags.erb.rb"
  resource :template
end
