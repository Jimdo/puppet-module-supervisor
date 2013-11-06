require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.ssh.close if c.ssh
    host = ENV['SERVERSPEC_HOST'] || 'localhost'
    c.ssh = Net::SSH.start(host, 'root')
    @ssh = c.ssh
  end
end
