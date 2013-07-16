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


require "paper-house/auto-depends"
require "paper-house/cc"
require "paper-house/dependency"
require "rake/clean"
require "rake/tasklib"


module PaperHouse
  #
  # Common base class for *.c compilation tasks.
  #
  class BuildTask < Rake::TaskLib
    include CC


    # Compile options pass to C compiler.
    attr_accessor :cflags

    # Name of task.
    attr_accessor :name

    # Directory where *.o files are created.
    attr_accessor :target_directory


    def initialize name, &block
      init name.to_s
      set_defaults
      block.call self if block
      define
    end


    # @!attribute includes
    #   Glob pattern to match include directories.
    attr_writer :includes

    def includes
      FileList[ [ @includes ] ]
    end


    # Glob pattern to match source files.
    attr_accessor :sources


    ############################################################################
    private
    ############################################################################


    def define
      define_main_task
      define_all_c_compile_tasks
      define_maybe_generate_target_task
      define_clean_task
      define_clobber_task
    end


    def define_main_task
      path = target_path
      main_task = task( name => [ @target_directory, path ] )
      main_task.comment = "Build #{ path }" if not main_task.comment
      directory @target_directory
    end


    def define_all_c_compile_tasks
      sources_list.zip( objects ) do | source, object |
        define_c_compile_task source, object
      end
    end


    def define_c_compile_task source, object
      task object => source do | task |
        compile task.name, task.prerequisites[ 0 ]
      end
    end


    def define_maybe_generate_target_task
      file target_path => objects do | task |
        next if uptodate?( task.name, task.prerequisites )
        build
      end
    end


    def build
      check_sources_list
      generate_target
    end


    def check_sources_list
      if sources_list.empty?
        fail "Cannot find sources (#{ @sources })."
      end
    end


    def define_clean_task
      objects.each do | each |
        next if not FileTest.exist?( each )
        CLEAN.include each
      end
    end


    def define_clobber_task
      clobber_targets.each do | each |
        next if not FileTest.exist?( each )
        CLOBBER.include each
      end
    end


    def clobber_targets
      [ target_path, dependency.path ]
    end


    def target_path
      File.join @target_directory, target_file_name
    end


    def objects
      sources_list.pathmap File.join( @target_directory, "%n.o" )
    end


    def init name
      @name = name
    end


    def set_defaults
      @sources = "*.c"
      @target_directory = "."
      @cflags = []
      @includes = []
    end


    def compile o_file, c_file
      return if no_need_to_compile?( o_file, c_file )
      auto_depends = AutoDepends.new( c_file, o_file, auto_depends_cc_options )
      auto_depends.run
      dependency.write o_file, auto_depends.data
    end


    def no_need_to_compile?( o_file, c_file )
      uptodate?( o_file, dependency.read( o_file ) << c_file )
    end


    def auto_depends_cc_options
      "#{ @cflags.join " " } -fPIC #{ cc_i_options }"
    end


    def cc_i_options
      include_directories.pathmap "-I%p"
    end


    def include_directories
      ( includes + auto_includes ).uniq
    end


    def sources_list
      FileList.new( @sources )
    end


    def auto_includes
      FileList[ sources_list.pathmap( "%d" ).uniq ]
    end


    def dependency
      @dependency ||= Dependency.new( @name )
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
