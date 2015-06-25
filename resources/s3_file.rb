actions :create, :create_if_missing, :touch, :delete
default_action :create

state_attrs :backup,
            :bucket,
            :checksum,
            :group,
            :mode,
            :owner,
            :path,
            :remote_path

attribute :path, kind_of: String, name_attribute: true
attribute :remote_path, kind_of: String
attribute :bucket, kind_of: String
attribute :region, kind_of: String
attribute :owner, regex: Chef::Config[:user_valid_regex]
attribute :group, regex: Chef::Config[:group_valid_regex]
attribute :mode, kind_of: [String, NilClass], default: nil
attribute :checksum, kind_of: [String, NilClass], default: nil
attribute :backup, kind_of: [Integer, FalseClass], default: 5

attribute :headers, kind_of: Hash, default: nil
attribute :use_etag, kind_of: [TrueClass, FalseClass], default: true
attribute :use_last_modified, kind_of: [TrueClass, FalseClass], default: true
attribute :atomic_update, kind_of: [TrueClass, FalseClass], default: true
attribute :force_unlink, kind_of: [TrueClass, FalseClass], default: false
attribute :manage_symlink_source, kind_of: [TrueClass, FalseClass], default: nil
