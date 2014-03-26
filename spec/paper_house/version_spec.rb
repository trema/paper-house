# encoding: utf-8

require 'paper_house/version'

describe PaperHouse do
  describe '::VERSION' do
    it { expect(PaperHouse::VERSION).to match(/\A\d+\.\d+\.\d+\Z/) }
  end
end
