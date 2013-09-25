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


require "paper_house/shared_library_task"


module PaperHouse
  describe SharedLibraryTask do
    it "should find registered tasks by name" do
      task = SharedLibraryTask.new( :libtest, "0.1.0" )

      SharedLibraryTask.find_by( :libtest ).should eq task
      SharedLibraryTask.find_by( "libtest" ).should eq task
      SharedLibraryTask.find_by( :no_such_task ).should be_nil
    end
  end


  describe SharedLibraryTask, %{.new( :libtest, "0.1.0" )} do
    subject { SharedLibraryTask.new :libtest, "0.1.0" }

    its( :cc ) { should eq "gcc" }
    its( :cflags ) { should be_empty }
    its( :includes ) { should be_empty }
    its( :name ) { should eq "libtest" }
    its( :sources ) { should eq "*.c"  }
    its( :target_directory ) { should eq "." }
    its( :version ) { should eq "0.1.0" }
    its( :linker_name ) { should eq "libtest.so" }
    its( :soname ) { should eq "libtest.so.0" }
    its( :target_file_name ) { should eq "libtest.so.0.1.0" }
    its( :library_name ) { should eq "libtest" }
    its( :lname ) { should eq "test" }

    it {
      expect {
        Rake::Task[ subject.name ].invoke
      }.to raise_error( "Cannot find sources (*.c)." )
    }
  end


  describe SharedLibraryTask, %{(:library_name = "libtest")} do
    subject {
      SharedLibraryTask.new( :libtest, "0.1.0" ) do | task |
        task.library_name = "libtest"
      end
    }

    its( :library_name ) { should eq "libtest" }
  end


  describe SharedLibraryTask, %{(:library_name = "test")} do
    subject {
      SharedLibraryTask.new( :libtest, "0.1.0" ) do | task |
        task.library_name = "test"
      end
    }

    its( :library_name ) { should eq "libtest" }
  end


  describe SharedLibraryTask, %{.new( :libtest )} do
    subject { SharedLibraryTask.new "libtest" }

    it {
      expect { subject }.to raise_error( ":version option is a mandatory." )
    }
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
