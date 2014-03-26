# encoding: utf-8

require 'rake'
require 'rspec'
require 'rspec/given'

RSpec.configure do | config |
  config.before(:all) do
    Rake::Task.clear
  end
end

require 'coveralls'
Coveralls.wear_merged!
