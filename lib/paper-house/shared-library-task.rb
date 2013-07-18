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


require "paper-house/library-task"
require "paper-house/linker-options"
require "paper-house/platform"


module PaperHouse
  # Compiles *.c files into a shared library.
  class SharedLibraryTask < LibraryTask
    include LinkerOptions
    include Platform


    # Library version string.
    attr_accessor :version


    def initialize name, version = nil, &block
      @version = version
      super name, &block
    end


    # Real name of target library.
    def target_file_name
      fail ":version option is a mandatory." if not @version
      [ linker_name, @version ].join "."
    end
    alias :real_name :target_file_name


    # Name of library used by linkers.
    def linker_name
      library_name + ".so"
    end


    # Soname of target library.
    def soname
      File.basename( target_file_name ).sub( /\.\d+\.\d+\Z/, "" )
    end


    ############################################################################
    private
    ############################################################################


    def generate_target
      sh ( [ cc ] + cc_options ).join( " " )
    end


    def cc_options
      [ "-shared", wl_option, o_option, objects, ldflags, l_options ].flatten
    end


    def wl_option
      "-Wl,#{ SONAME_OPTION },#{ soname }"
    end


    def o_option
      "-o #{ target_path }"
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
