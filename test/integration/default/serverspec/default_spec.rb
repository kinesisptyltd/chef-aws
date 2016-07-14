require "serverspec"

set :backend, :exec

describe "aws::default" do
  describe file("/tmp/kitchen/ohai/plugins/ec2_tags.rb") do
    it { is_expected.to exist }
  end

  describe file("/etc/chef/ohai/hints") do
    it { is_expected.to exist }
    it { is_expected.to be_a_directory }
  end

  describe file("/etc/chef/ohai/hints/ec2.json") do
    it { is_expected.to exist }
    it { is_expected.to be_a_file }
    its(:content) { is_expected.to be_empty }
  end
end
