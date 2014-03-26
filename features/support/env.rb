# encoding: utf-8

require 'aruba/cucumber'
require 'rake'

ENV['LD_LIBRARY_PATH'] = '.'

require 'coveralls'
Coveralls.wear_merged!
