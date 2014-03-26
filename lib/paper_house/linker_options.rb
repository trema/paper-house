# encoding: utf-8

module PaperHouse
  #
  # Linker option utilities.
  #
  module LinkerOptions
    # @!attribute ldflags
    #   Linker options pass to C compiler.
    attr_writer :ldflags

    def ldflags
      @ldflags ||= []
      [@ldflags].flatten.compact
    end

    #
    # List of libraries to link.
    #
    def library_dependencies=(name)
      @library_dependencies = [name].flatten.compact
    end

    #
    # List of libraries to link.
    #
    def library_dependencies
      @library_dependencies ||= []
      [@library_dependencies].flatten.compact
    end

    private

    def find_prerequisites(task, klass_list)
      klass_list.each do |klass|
        maybe_enhance task, klass
      end
    end

    def maybe_enhance(name, klass)
      task = klass.find_named(name)
      enhance task if task
    end

    def enhance(library_task)
      @library_dependencies ||= []
      @library_dependencies |= [library_task.lname]
      Rake::Task[target_path].enhance [library_task.target_path]
    end

    def l_options
      library_dependencies.map do |each|
        "-l#{each}"
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
