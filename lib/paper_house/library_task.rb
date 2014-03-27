# encoding: utf-8

require 'paper_house/build_task'

module PaperHouse
  # Common base class for static, shared, and ruby library tasks.
  class LibraryTask < BuildTask
    # Find a LibraryTask by +name+.
    # @return [LibraryTask]
    def self.find_by_name(name)
      ObjectSpace.each_object(self) do |each|
        obj_name = each.name
        if Rake::Task.task_defined?(obj_name) && obj_name == name.to_s
          return each
        end
      end
      nil
    end

    def initialize(name, &block)
      @library_dependencies = []
      super name, &block
    end

    # Name of library.
    def library_name
      (@library_name ||= @name).to_s
    end

    # Name of library.
    def library_name=(name)
      new_name = name.to_s
      @library_name = /\Alib/ =~ new_name ? new_name : 'lib' + new_name
    end

    # Name of library pass to -l option.
    def lname
      library_name.sub(/^lib/, '')
    end
  end
end
