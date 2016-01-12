[![Build Status](https://travis-ci.org/kinesisptyltd/cookbook-aws.svg)](https://travis-ci.org/kinesisptyltd/cookbook-aws)

# cookbook-aws

Cookbook to install the Ruby AWS SDK and setup Ohai hints. Also provides library
access to the Ruby AWS SDK for use in recipes.

A EC2Tags Ohai plugin is included. This adds a new node attribute `tags` available for use in recipes
that contains all tags on the EC2 instance. Eg:

```
node["ec2"]["tags"]["environment"]
=> "staging"
```

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions.

An IAM Role is expected to be set on the instance as no support is built in for manually
specifying credentials. At a minimum for the EC2Tags Ohai plugin to work you will need
the following:

```
{
  "Statement": [
    {
      "Resource": ["*"],
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeTags",
        "ec2:CreateTags"
      ],
      "Effect": "Allow"
    }
  ]
}
```

## Attributes

### aws::default

Installs the Ruby AWS SDK gem and sets up the default EC2 Ohai hint. Additionally the EC2Tags Ohai
plugin is installed. Ohai plugins fail silently, so If above IAM Role isn't set on the instance
tags won't be available as node attributes.

Key                             | Type   | Description
:-------------------------------|--------|----------------------------------------------------------
`["aws"]["ruby_sdk"]["version"]`| String | Version of Ruby aws-sdk to install. Defaults to `2.1.2`

## Usage

Include `aws` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[aws]"
  ]
}
```

## Libraries

To use the included library include the module:

```ruby
Chef::Recipe.send(:include, Kinesis::Aws)
```

There are two methods now available, one for creating `Aws::Client` objects and one for the newer `Aws::Resource` API.
The region is required by the Ruby AWS SDK.

```ruby
# Resource API
ec2 = aws_resource("EC2", "ap-southeast-2")
ec2.instance(node["ec2"]["instance_id"]).tags


# Older Client API
ec2_client = aws_client("EC2", "ap-southeast-2")
ec2_client.describe_tags(filters: [{
  name: "resource-id",
  values: [node["ec2"]["instance_id"]]
})
```
