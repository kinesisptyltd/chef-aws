# cookbook-aws

Cookbook to install the Ruby aws-sdk and setup ohai hints. Also provides library
access to the aws-sdk for use in recipes.

## Requirements

Only tested on Ubuntu 14.04, but should work on earlier versions.

IAM Role is expected to be set on the instance as no support is built in for manually
specifying credentials. At a minimum for the EC2Tags ohai plugin to work you will need
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

Installs the Ruby aws-sdk gem and sets up the EC2 ohai hint. Additionally an EC2Tags 

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
