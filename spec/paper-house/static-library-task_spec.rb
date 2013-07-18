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


require "paper-house/static-library-task"


module PaperHouse
  describe StaticLibraryTask do
    it "should find registered tasks by name" do
      task = StaticLibraryTask.new( :libtest )

      StaticLibraryTask.find_by( :libtest ).should eq task
      StaticLibraryTask.find_by( "libtest" ).should eq task
      StaticLibraryTask.find_by( :no_such_task ).should be_nil
    end
  end


  describe StaticLibraryTask, ".new( :libtest )" do
    subject { StaticLibraryTask.new :libtest }

    its( :cc ) { should eq "gcc" }
    its( :cflags ) { should be_empty }
    its( :includes ) { should be_empty }
    its( :name ) { should eq "libtest" }
    its( :sources ) { should eq "*.c"  }
    its( :target_directory ) { should eq "." }
    its( :library_name ) { should eq "libtest" }
    its( :lname ) { should eq "test" }
    its( :target_file_name ) { should eq "libtest.a" }
    its( :target_path ) { should eq "./libtest.a" }

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
