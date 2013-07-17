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
  module LinkerOptions
    # @!attribute ldflags
    # Linker options pass to C compiler.
    attr_writer :ldflags

    def ldflags
      @ldflags ||= []
      [ @ldflags ].flatten.compact
    end


    # @!attribute library_dependencies
    #   List of libraries to link.
    attr_writer :library_dependencies

    def library_dependencies
      @library_dependencies ||= []
      [ @library_dependencies ].flatten.compact
    end


    ############################################################################
    private
    ############################################################################


    def cc_l_options
      library_dependencies.collect do | each |
        "-l#{ each }"
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
