# encoding: utf-8

require 'rake'
require 'rspec'

RSpec.configure do | config |
  config.before(:all) do
    Rake::Task.clear
  end
end

require 'coveralls'
Coveralls.wear_merged!
