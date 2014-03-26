# encoding: utf-8

require 'paper_house/version'

describe PaperHouse do
  describe '::VERSION' do
    it { expect(PaperHouse::VERSION).to match(/\A\d+\.\d+\.\d+\Z/) }
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
