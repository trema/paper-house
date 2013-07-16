#
# Copyright (C) 2013 NEC Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 2, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#


require "rubygems"
require "rspec"
require "spork"
#uncomment the following line to use spork with the debugger
#require "spork/ext/ruby-debug"


RSpec.configure do | config |
  config.before( :all ) do
    Rake::Task.clear
  end
end


Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  if not ENV[ "DRB" ]
    require "coveralls"
    Coveralls.wear_merged!
  end

  require "rspec"
end


Spork.each_run do
  # This code will be run each time you run your specs.

  if ENV[ "DRB" ]
    require "coveralls"
    Coveralls.wear_merged!
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
