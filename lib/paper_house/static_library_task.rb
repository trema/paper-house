# encoding: utf-8

require 'paper_house/library_task'

module PaperHouse
  # Compiles *.c files into a static library.
  class StaticLibraryTask < LibraryTask
    # Name of target library file.
    def target_file_name
      library_name + '.a'
    end

    private

    def generate_target
      maybe_rm_target
      ar
      ranlib
    end

    def maybe_rm_target
      a_file = target_path
      sh "rm #{a_file}" if FileTest.exist?(a_file)
    end

    def ar
      sh "ar -cq #{target_path} #{objects}"
    end

    def ranlib
      sh "ranlib #{target_path}"
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
