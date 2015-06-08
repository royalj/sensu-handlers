#
# Cookbook: sensu-helpers
# ServerSpec: mailer
#

describe 'sensu-handlers::mailer' do
  describe package('mail') do
    it { should be_installed.by('gem').with_version('2.5.4') }
  end

  describe file('/opt/sensu/handlers/mailer.rb') do
    it { should be_file }
    its(:content) { should match(/class Mailer < BaseHandler/) }
  end

  describe file('/etc/sensu/conf.d/handlers/mailer.json') do
    it { should be_file }
  end
end
