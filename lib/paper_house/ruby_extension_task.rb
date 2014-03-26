# -*- coding: utf-8 -*-
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

require 'paper_house/library_task'
require 'paper_house/linker_options'
require 'paper_house/platform'

#
# Rake for C projects.
#
module PaperHouse
  #
  # Compiles *.c files into a Ruby extension library.
  #
  class RubyExtensionTask < LibraryTask
    include LinkerOptions
    include Platform

    # Name of target library.
    attr_writer :library_name

    # Name of target library file.
    def target_file_name
      library_name.to_s + SHARED_EXT
    end

    # List of libraries to link.
    def library_dependencies
      MAC ? ([@library_dependencies] << 'ruby').flatten.compact : super
    end

    private

    def cc_options
      [LDSHARED, o_option, objects, ldflags, libdir_option, l_options].flatten
    end

    def o_option
      "-o #{target_path}"
    end

    def libdir_option
      "-L#{RUBY_LIBDIR}"
    end

    def include_directories
      (includes + auto_includes + RUBY_INCLUDES).uniq
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
