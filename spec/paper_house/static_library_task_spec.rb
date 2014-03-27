# encoding: utf-8

require 'paper_house/static_library_task'

describe Rake::Task, '.[]' do
  Given { Rake::Task.clear }

  context 'with :libtest' do
    When(:result) { Rake::Task[:libtest] }
    Then do
      result == Failure(RuntimeError, "Don't know how to build task 'libtest'")
    end
  end

  context 'when StaticLibraryTask.new(:libtest)' do
    Given { PaperHouse::StaticLibraryTask.new :libtest }

    context 'with :libtest' do
      Given(:task) { Rake::Task[:libtest] }

      describe '#invoke' do
        When(:result) { task.invoke }
        Then { result == Failure(RuntimeError, 'Cannot find sources (*.c).') }
      end
    end
  end
end

describe PaperHouse::StaticLibraryTask do
  Given { Rake::Task.clear }

  describe '.find_by_name' do
    When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
    Then { result.nil? }
  end

  context 'PaperHouse::StaticLibraryTask.new(:libtest)' do
    Given { PaperHouse::StaticLibraryTask.new :libtest }

    describe '.find_by_name' do
      When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
      Then { result.is_a? PaperHouse::StaticLibraryTask }
    end
  end

  context "PaperHouse::StaticLibraryTask.new('libtest')" do
    Given { PaperHouse::StaticLibraryTask.new 'libtest' }

    describe '.find_by_name' do
      When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
      Then { result.is_a? PaperHouse::StaticLibraryTask }
    end
  end

  describe '.new' do
    Given(:task) { PaperHouse::StaticLibraryTask.new(name) }

    context 'with :libtest' do
      When(:name) { :libtest }
      Then { task.name == 'libtest' }
      Then { task.library_name == 'libtest' }
      Then { task.cc == 'gcc' }
      Then { task.cflags.empty? }
      Then { task.includes.empty? }
      Then { task.sources == '*.c'  }
      Then { task.target_directory == '.' }
      Then { task.lname == 'test' }
      Then { task.target_file_name == 'libtest.a' }
      Then { task.target_path == './libtest.a' }
    end
  end
end
