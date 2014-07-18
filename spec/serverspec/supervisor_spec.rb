require 'spec_helper'
require 'puppet'

def puppet(code)
  res = backend.run_command "puppet apply -e '#{code}'"
  raise "Error running puppet: #{res.stdout}" unless [0, 2].include? res.exit_status
end

context 'defaults' do
  before(:each) do
    puppet <<-PUPPET
      include supervisor
    PUPPET
  end
  after(:each) do
    puppet <<-PUPPET
      package {supervisor: ensure => purged } ->
      exec {"/bin/rm -rf /etc/supervisor": } 
    PUPPET
  end

  describe package('supervisor') do
    it { should be_installed }
  end
  describe service('supervisor') do
    it { should be_running }
  end
  describe file('/etc/supervisor/supervisord.conf') do
    it { should be_file }
    it "should configure logfile" do
      subject.content.should match %r#logfile.*/var/log/supervisor/supervisord.log#
    end
  end
  context 'issue #71' do

  end
end
