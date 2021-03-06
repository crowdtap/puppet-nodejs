require "spec_helper"

describe "nodejs::v0_10" do
  let(:facts) { default_test_facts }

  it do
    should include_class("nodejs::config")
    should include_class("nodejs::v0_10_5")

    should contain_file("/test/boxen/nodenv/versions/v0.10").with({
      :ensure => "link",
      :target => "/test/boxen/nodenv/versions/v0.10.5"
    })
  end
end
