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

directory "/etc/chef/ohai/hints" do
  recursive true
  action :create
end.run_action(:create)

file "/etc/chef/ohai/hints/ec2.json" do
  content {}
  action :create
end.run_action(:create)

template "#{node["ohai"]["plugin_path"]}/ec2_tags.rb" do
  source "ohai/ec2_tags.erb.rb"
  owner "root"
  group "root"
  mode 00755
end

ohai "reload" do
  action :reload
end.run_action(:reload)

include_recipe "ohai"