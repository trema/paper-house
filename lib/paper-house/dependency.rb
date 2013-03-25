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


require "pstore"
require "rake"


module PaperHouse
  #
  # Keeps compilation dependencies
  #
  class Dependency
    attr_reader :path


    def initialize name
      @path = File.join( Rake.original_dir, ".#{ name }.depends" )
      @cache = {}
    end


    def read object_file
      db.transaction( true ) do | store |
        store[ object_file ]
      end || []
    end


    def write object_file, dependency
      db.transaction( false ) do | store |
        store[ object_file ] = dependency
      end
    end


    ############################################################################
    private
    ############################################################################


    def db
      @cache[ @name ] ||= PStore.new( @path )
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
