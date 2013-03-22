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


module Rake
  module PaperHouse
    module Dependency
      @@store = {}


      def self.read name, object_file
        dump_of( name ).transaction( true ) do | store |
          store[ object_file ]
        end || []
      end


      def self.write name, object_file, dependency
        dump_of( name ).transaction( false ) do | store |
          store[ object_file ] = dependency
        end
      end


      def self.dump_of name
        @@store[ name ] ||= PStore.new( path( name ) )
      end


      def self.path name
        File.join Rake.original_dir, ".#{ name }.depends"
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
