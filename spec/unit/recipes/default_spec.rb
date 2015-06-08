#
# Cookbook Name:: sensu-handlers
# Spec:: default
#

require 'spec_helper'

describe 'sensu-handlers::default' do
  context 'with default attributes' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'centos', version: '6.5') do |node|
        node.automatic['domain'] = 'example.com'
      end.converge(described_recipe)
    end
    subject { chef_run }

    it 'Creates Sensu handlers directory' do
      is_expected.to create_directory('/opt/sensu/handlers')
        .with_mode('0755')
        .with_owner('sensu')
        .with_group('sensu')
    end

    it 'Creates/updates base.rb' do
      is_expected.to create_cookbook_file('base.rb')
        .with_path('/opt/sensu/handlers/base.rb')
        .with_owner('sensu')
        .with_group('sensu')
        .with_mode('0755')
    end

    it { is_expected.to include_recipe('sensu-handlers::_sensu') }

    it 'Creates Sensu default handler' do
      is_expected.to create_sensu_handler('default')
        .with_type('set')
        .with_handlers(%w(pagerduty mailer))
        .with_additional(dashboard_link: 'https://sensu.example.com')
    end

    it { is_expected.to include_recipe('sensu-handlers::pagerduty') }
    it { is_expected.to include_recipe('sensu-handlers::mailer') }
  end
end
