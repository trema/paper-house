# encoding: utf-8

require 'paper_house/version'

describe PaperHouse, '::VERSION' do
  Then { /\A\d+\.\d+\.\d+\Z/=~ PaperHouse::VERSION }
end
