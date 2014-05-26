# encoding: utf-8

require 'paper_house/library_task'
require 'paper_house/linker_options'
require 'paper_house/platform'

# Rake for C projects.
module PaperHouse
  # Compiles *.c files into a Ruby extension library.
  class RubyExtensionTask < LibraryTask
    include LinkerOptions
    include Platform

    # Name of target library.
    attr_writer :library_name

    # Name of target library file.
    def target_file_name
      library_name.to_s + SHARED_EXT
    end

    # List of libraries to link.
    def library_dependencies
      MAC ? ([@library_dependencies] << 'ruby').flatten.compact : super
    end

    private

    def cc_options
      [LDSHARED, o_option, objects, ldflags, libdir_option, l_options].flatten
    end

    def o_option
      "-o #{target_path}"
    end

    def libdir_option
      "-L#{RUBY_LIBDIR}"
    end

    def include_directories
      (includes + auto_includes + RUBY_INCLUDES).uniq
    end
  end
end
