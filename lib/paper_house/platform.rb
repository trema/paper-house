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


require "rbconfig"


module PaperHouse
  #
  # Platform-dependent stuff.
  #
  module Platform
    include RbConfig


    # MACOSX or not.
    MAC = ( /darwin|mac os/=~ CONFIG[ "host_os" ] )


    # File extension of C extensions.
    SHARED_EXT = MAC ? ".bundle" : ".so"

    # CC options for compiling shared libraries.
    LDSHARED = MAC ? "-dynamic -bundle" : "-shared"

    # CC option for setting soname.
    SONAME_OPTION = MAC ? "-install_name" : "-soname"

    # Ruby include directories for compiling C extensions (1.8).
    RUBY_INCLUDES_1_8 = [ CONFIG[ "archdir" ] ]

    # Ruby include directories for compiling C extensions (1.9 or higher).
    RUBY_INCLUDES_1_9 = [
                         File.join( CONFIG[ "rubyhdrdir" ], CONFIG[ "arch" ] ),
                         File.join( CONFIG[ "rubyhdrdir" ], "ruby/backward" ),
                         CONFIG[ "rubyhdrdir" ]
                        ]

    # Ruby include directories for compiling C extensions.
    RUBY_INCLUDES = RUBY_VERSION >= "1.9.0" ? RUBY_INCLUDES_1_9 : RUBY_INCLUDES_1_8

    # Library directories for compiling C extensions.
    RUBY_LIBDIR = CONFIG[ "libdir" ]
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
