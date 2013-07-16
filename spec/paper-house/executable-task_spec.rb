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


require "paper-house/executable-task"


module PaperHouse
  describe ExecutableTask, ".new( :test )" do
    subject { ExecutableTask.new :test }

    its( :cc ) { should eq "gcc" }
    its( :cflags ) { should be_empty }
    its( :executable_name ) { should eq "test" }
    its( :includes ) { should be_empty }
    its( :ldflags ) { should be_empty }
    its( :library_dependencies ) { should be_empty }
    its( :name ) { should eq "test" }
    its( :sources ) { should eq "*.c"  }
    its( :target_directory ) { should eq "." }

    it {
      expect {
        Rake::Task[ subject.name ].invoke
      }.to raise_error( "Cannot find sources (*.c)." )
    }
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
