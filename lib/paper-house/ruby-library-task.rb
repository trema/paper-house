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


require "paper-house/cc"
require "paper-house/library-task"
require "paper-house/linker-options"
require "paper-house/os"
require "rbconfig"


module PaperHouse
  #
  # Compile *.c files into a Ruby extension library.
  #
  class RubyLibraryTask < LibraryTask
    include CC
    include LinkerOptions
    include RbConfig


    if OS.mac?
      SHARED_EXT = ".bundle"
      LDSHARED = "-dynamic -bundle"
    else
      SHARED_EXT = ".so"
      LDSHARED = "-shared"
    end
    RUBY_INCLUDES = if RUBY_VERSION >= "1.9.0"
                      [
                        File.join( CONFIG[ "rubyhdrdir" ], CONFIG[ "arch" ] ),
                        File.join( CONFIG[ "rubyhdrdir" ], "ruby/backward" ),
                        CONFIG[ "rubyhdrdir" ]
                      ]
                    else
                      [ RbConfig::CONFIG[ "archdir" ] ]
                    end


    attr_writer :library_name


    def target_file_name
      library_name + SHARED_EXT
    end


    def library_dependencies
      if OS.mac?
        ( [ @library_dependencies ] << "ruby" ).flatten.compact
      else
        super
      end
    end


    ############################################################################
    private
    ############################################################################


    def generate_target
      sh "#{ cc } #{ LDSHARED } -o #{ target_path } #{ objects.to_s } #{ cc_linker_options }"
    end


    def cc_linker_options
      [
        ldflags,
        cc_ldflags,
        cc_l_options,
      ].flatten.join " "
    end


    def cc_ldflags
      "-L#{ RbConfig::CONFIG[ "libdir" ] }"
    end


    def include_directories
      ( includes + auto_includes + RUBY_INCLUDES ).uniq
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
