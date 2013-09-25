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


module PaperHouse
  # CC option utilities.
  module CcOptions
    # @!attribute sources
    #   Glob pattern to match source files.
    attr_writer :sources

    def sources
      @sources ||= "*.c"
    end


    # @!attribute cflags
    #   Compile options pass to C compiler.
    attr_writer :cflags

    def cflags
      @cflags ||= []
    end


    # @!attribute includes
    #   Glob pattern to match include directories.
    attr_writer :includes

    def includes
      @includes ||= []
      FileList[ [ @includes ] ]
    end


    ############################################################################
    private
    ############################################################################


    def i_options
      include_directories.pathmap "-I%p"
    end


    def include_directories
      ( includes + auto_includes ).uniq
    end


    def auto_includes
      FileList[ sources_list.pathmap( "%d" ).uniq ]
    end


    def sources_list
      FileList[ sources ]
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
