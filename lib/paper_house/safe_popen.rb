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


require "popen4"


module PaperHouse
  #
  # Thin POpen4 wrapper that avoids POpen4's segraults in 1.8.6.
  # See also https://github.com/engineyard/engineyard/issues/115
  #
  class SafePopen
    #
    # Starts a new process and pass the subprocess IOs and pid to the
    # block supplied.
    #
    def self.popen command, &block
      status = nil
      begin
        GC.disable
        status = POpen4.popen4( command, &block )
      ensure
        GC.enable
      end
      status
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
