#
# Cookbook: sensu-helpers
# ServerSpec: default
#

describe 'sensu-handlers::default' do
  describe file('/opt/sensu/handlers') do
    it { should be_directory }
  end

  describe file('/opt/sensu/handlers/base.rb') do
    it { should be_file }
    its(:content) { should match(/class BaseHandler < Sensu::Handler/) }
  end

  describe file('/etc/sensu/conf.d/handlers/default.json') do
    it { should be_file }
  end
end
