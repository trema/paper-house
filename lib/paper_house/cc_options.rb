# encoding: utf-8

module PaperHouse
  # CC option utilities.
  module CcOptions
    # @!attribute sources
    #   Glob pattern to match source files.
    attr_writer :sources

    def sources
      @sources ||= '*.c'
    end

    # @!attribute cflags
    #   Compile options pass to C compiler.
    attr_writer :cflags

    def cflags
      @cflags ||= []
    end

    # @!attribute includes
    #   Glob pattern to match include directories.
    attr_writer :includes

    def includes
      @includes ||= []
      FileList[[@includes]]
    end

    private

    def i_options
      include_directories.pathmap '-I%p'
    end

    def include_directories
      (includes + auto_includes).uniq
    end

    def auto_includes
      FileList[sources_list.pathmap('%d').uniq]
    end

    def sources_list
      FileList[sources]
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
