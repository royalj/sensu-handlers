#
# Cookbook Name:: sensu-handlers
# Spec:: pagerduty
#

require 'spec_helper'

describe 'sensu-handlers::pagerduty' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      platform: 'centos', version: '6.5') do |node|
      node.automatic['domain'] = 'example.com'
      node.force_default['sensu-handlers']['teams'] =
        {
          'test' => {
            'pagerduty_api_key' => '12345'
          }
        }
    end.converge(described_recipe)
  end
  subject { chef_run }

  it { is_expected.to install_sensu_gem('redphone') }

  it 'Creates/updates pagerduty.rb' do
    is_expected.to create_cookbook_file('pagerduty.rb')
      .with_path('/opt/sensu/handlers/pagerduty.rb')
      .with_owner('sensu')
      .with_group('sensu')
      .with_mode('0755')
  end

  it 'Creates pagerduty handler' do
    is_expected.to create_sensu_handler('pagerduty')
      .with_type('pipe')
      .with_command('/opt/sensu/handlers/pagerduty.rb')
      .with_severities(%w(critical unknown))
      .with_additional(teams: { 'test' => { 'pagerduty_api_key' => '12345' } })
  end
end
