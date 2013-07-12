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


require "rbconfig"


module PaperHouse
  #
  # Platform-dependent stuff.
  #
  module Platform
    include RbConfig


    MAC = ( /darwin|mac os/=~ CONFIG[ "host_os" ] )


    if MAC
      SHARED_EXT = ".bundle"
      LDSHARED = "-dynamic -bundle"
      SONAME_OPTION = "-install_name"
    else
      SHARED_EXT = ".so"
      LDSHARED = "-shared"
      SONAME_OPTION = "-soname"
    end


    RUBY_INCLUDES = if RUBY_VERSION >= "1.9.0"
                      [
                        File.join( CONFIG[ "rubyhdrdir" ], CONFIG[ "arch" ] ),
                        File.join( CONFIG[ "rubyhdrdir" ], "ruby/backward" ),
                        CONFIG[ "rubyhdrdir" ]
                      ]
                    else
                      [ CONFIG[ "archdir" ] ]
                    end

    RUBY_LIBDIR = CONFIG[ "libdir" ]
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
