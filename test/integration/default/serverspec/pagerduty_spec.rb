#
# Cookbook: sensu-helpers
# ServerSpec: default
#

describe 'sensu-handlers::pagerduty' do
  describe package('redphone') do
    it { should be_installed.by('gem') }
  end

  describe file('/opt/sensu/handlers/pagerduty.rb') do
    it { should be_file }
    its(:content) { should match(/class Pagerduty < BaseHandler/) }
  end

  describe file('/etc/sensu/conf.d/handlers/pagerduty.json') do
    it { should be_file }
  end
end
