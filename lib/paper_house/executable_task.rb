# encoding: utf-8

require 'paper_house/build_task'
require 'paper_house/linker_options'
require 'paper_house/shared_library_task'
require 'paper_house/static_library_task'

module PaperHouse
  #
  # Compiles *.c files into an executable file.
  #
  class ExecutableTask < BuildTask
    include LinkerOptions

    def initialize(name, &block)
      super name, &block
      Rake::Task[name].prerequisites.each do |each|
        find_prerequisites each, [StaticLibraryTask, SharedLibraryTask]
      end
    end

    # @!attribute executable_name
    #   Name of target executable file.
    attr_writer :executable_name

    def executable_name
      @executable_name ||= @name
    end
    alias_method :target_file_name, :executable_name

    private

    def cc_options
      [o_option, objects, ldflags, l_options].flatten
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
