require 'spec_helper'
describe 'fedora_repository' do

  context 'with defaults for all parameters' do
    it { should contain_class('fedora_repository') }
  end
end
