# encoding: utf-8

require 'pstore'
require 'rake'

module PaperHouse
  # Keeps compilation dependencies
  class Dependency
    attr_reader :path

    def initialize(name)
      @name = name
      @path = File.join(Rake.original_dir, ".#{name}.depends")
      @cache = {}
    end

    # Reads the dependency information of +object_file+.
    def read(object_file)
      db.transaction(true) do |store|
        store[object_file]
      end || []
    end

    # Saves the dependency information (+object_file+ =>
    # +dependent_files+).
    def write(object_file, dependent_files)
      db.transaction(false) do |store|
        store[object_file] = dependent_files
      end
    end

    private

    def db
      @cache[@name] ||= PStore.new(@path)
    end
  end
end
