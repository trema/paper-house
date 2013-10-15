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


require "paper_house/safe_popen"


module PaperHouse
  #
  # Automatically detects compilation dependencies.
  #
  class AutoDepends
    attr_reader :data


    def initialize c_file, o_file, cc, cc_options
      @cc = cc
      @command = "#{ @cc } -H #{ cc_options } -c #{ c_file } -o #{ o_file }"
      @data = []
    end


    #
    # Runs dependency detection.
    #
    def run
      $stderr.puts @command
      exit_status = popen_command
      raise "#{ @cc } failed" if exit_status != 0
    end


    ############################################################################
    private
    ############################################################################


    def popen_command
      SafePopen.popen( @command ) do | stdout, stderr, stdin, |
        stdin.close
        parse_cc_h_stderr stderr
      end.exitstatus
    end


    def parse_cc_h_stderr stderr
      stderr.each do | each |
        parse_cc_h_stderr_line( each, stderr )
      end
    end


    def parse_cc_h_stderr_line line, stderr
      case line
      when /^\./
        @data << line.sub( /^\.+\s+/, "" ).strip
      when /Multiple include guards/
        filter_out_include_guards_warnings stderr
      else
        puts line
      end
    end


    def filter_out_include_guards_warnings stderr
      stderr.each do | each |
        if /:$/=~ each
          puts each
          return
        end
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
