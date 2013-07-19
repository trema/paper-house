#
# Copyright (C) 2013 NEC Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 3, as
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


require "paper-house/cc-options"


module PaperHouse
  class TestTask
    include CcOptions

    public
    :i_options
  end


  describe CcOptions, "(default properties)" do
    subject { TestTask.new }

    its( :sources ) { should eq "*.c" }
    its( :cflags ) { should be_empty }
    its( :includes ) { should be_empty }
  end


  describe CcOptions, "(sources=./sources/foo.c, includes=./includes)" do
    subject {
      task = TestTask.new
      task.sources = "./sources/foo.c"
      task.includes = "./includes"
      task
    }

    its( "i_options.size" ) { should eq 2 }
    its( :i_options ) { should include "-I./includes" }
    its( :i_options ) { should include "-I./sources" }
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
