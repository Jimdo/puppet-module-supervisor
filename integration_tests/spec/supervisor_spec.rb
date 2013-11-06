require 'spec_helper'

describe 'supervisor' do
  context 'with default configuration' do
    before(:each) do
      output = @ssh.exec! <<-SHELL
      puppet apply -e 'include supervisor'
      SHELL
    end

    describe service('supervisor') do
      it { should be_running   }
    end
  end
end
