require 'puppetlabs_spec_helper/module_spec_helper'
require 'serverspec'
require 'pathname'
require 'net/ssh'
include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS
RSpec.configure do |c|
  c.sudo_password = ''
  c.before :all do
    c.host  = 'default'
    options = Net::SSH::Config.for(c.host)
    user = 'vagrant'
    vagrant_up = `vagrant up`
    config = `vagrant ssh-config`
    hostname = nil
    if config != ''
      config.each_line do |line|
        if match = /\s*HostName (.*)/.match(line)
          hostname = match[1]
        elsif match = /\s*IdentityFile (.*)/.match(line)
          options[:keys] =  [match[1].gsub(/\"/,'')]
        elsif match = /\s*Port (.*)/.match(line)
          options[:port] = match[1]
        end
      end
    end
    c.ssh = Net::SSH.start(hostname, user, options)
  end
end
