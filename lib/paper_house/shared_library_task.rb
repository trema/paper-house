# encoding: utf-8

require 'paper_house/library_task'
require 'paper_house/linker_options'
require 'paper_house/platform'

module PaperHouse
  # Compiles *.c files into a shared library.
  class SharedLibraryTask < LibraryTask
    include LinkerOptions
    include Platform

    # Library version string.
    attr_accessor :version

    def initialize(name, version = nil, &block)
      @version = version
      super name, &block
    end

    # Real name of target library.
    def target_file_name
      fail 'version option is a mandatory.' unless @version
      [linker_name, @version].join '.'
    end
    alias_method :real_name, :target_file_name

    # Name of library used by linkers.
    def linker_name
      library_name + '.so'
    end

    # Soname of target library.
    def soname
      File.basename(target_file_name).sub(/\.\d+\.\d+\Z/, '')
    end

    private

    def cc_options
      ['-shared', wl_option, o_option, objects, ldflags, l_options].flatten
    end

    def wl_option
      "-Wl,#{SONAME_OPTION},#{soname}"
    end

    def o_option
      "-o #{target_path}"
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
