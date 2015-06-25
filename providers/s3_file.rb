include Kinesis::Aws

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create do
  do_s3_file(:create)
end

action :create_if_missing do
  do_s3_file(:create_if_missing)
end

action :delete do
  do_s3_file(:delete)
end

action :touch do
  do_s3_file(:touch)
end

def do_s3_file(resource_action)
  client = aws_client("S3", new_resource.region)

  remote_path = new_resource.remote_path
  remote_path.sub!(/^\/*/, "")

  obj = Aws::S3::Object.new(bucket_name: new_resource.bucket, key: remote_path, client: client)
  s3url = obj.presigned_url(:get, expires_in: 300)

  remote_file new_resource.name do
    path new_resource.path
    source s3url.gsub(/https:\/\/([\w\.\-]*)\.{1}s3.amazonaws.com:443/, 'https://s3.amazonaws.com:443/\1')
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
    checksum new_resource.checksum
    backup new_resource.backup
    action resource_action

    headers new_resource.headers
    use_etag new_resource.use_etag
    use_last_modified new_resource.use_last_modified
    atomic_update new_resource.atomic_update
    force_unlink new_resource.force_unlink
    manage_symlink_source new_resource.manage_symlink_source
  end
end
