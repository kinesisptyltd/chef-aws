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

module Kinesis
  module Aws
    include Chef::Mixin::ShellOut

    def aws_client(client, region)
      @@client =
        begin
          require "aws-sdk"
          klass = Object.const_get("Aws::#{client}::Client")
          klass.new(region: region)
        rescue LoadError
          Chef::Log.error("Missing the aws-sdk gem. Include recipe[aws::default] to install the SDK.")
        rescue NameError
          Chef::Log.error("No such AWS client #{client}")
        end
    end

    def aws_resource(resource, region)
      @@resource =
        begin
          require "aws-sdk"
          klass = Object.const_get("Aws::#{resource}::Resource")
          klass.new(region: region)
        rescue LoadError
          Chef::Log.error("Missing the aws-sdk gem. Include recipe[aws::default] to install the SDK.")
        rescue NameError
          Chef::Log.error("No such AWS resource #{resource}")
        end
    end
  end
end
