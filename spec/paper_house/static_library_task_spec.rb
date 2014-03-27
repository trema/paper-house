# encoding: utf-8

require 'paper_house/static_library_task'

describe Rake::Task do
  context 'when StaticLibraryTask (name = :libtest) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::StaticLibraryTask.new :libtest }

    describe '.[]' do
      context 'with :libtest' do
        Given(:name) { :libtest }

        When(:task) { Rake::Task[name] }
        Then { task.is_a? Rake::Task }

        describe '#invoke' do
          When(:result) { task.invoke }
          Then do
            result == Failure(RuntimeError, 'Cannot find sources (*.c).')
          end
        end
      end
    end
  end
end

describe PaperHouse::StaticLibraryTask do
  context 'when no tasks are defined' do
    Given { Rake::Task.clear }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
        Then { result.nil? }
      end
    end
  end

  context 'when StaticLibraryTask (name = :libtest) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::StaticLibraryTask.new :libtest }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
        Then { result.is_a? PaperHouse::StaticLibraryTask }
      end
    end
  end

  context "when StaticLibraryTask (name = 'libtest') is defined" do
    Given { Rake::Task.clear }
    Given { PaperHouse::StaticLibraryTask.new 'libtest' }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::StaticLibraryTask.find_by_name('libtest') }
        Then { result.is_a? PaperHouse::StaticLibraryTask }
      end
    end
  end
end

describe PaperHouse::StaticLibraryTask, '.new' do
  context 'with :libtest' do
    When(:task) { PaperHouse::StaticLibraryTask.new(:libtest) }
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

  context "with :test and a block setting :library_name = 'libfoo'" do
    When(:task) do
      PaperHouse::StaticLibraryTask.new(:test) do |task|
        task.library_name = 'libfoo'
      end
    end
    Then { task.library_name == 'libfoo' }
  end

  context 'with :test and a block setting :library_name = :libfoo' do
    When(:task) do
      PaperHouse::StaticLibraryTask.new(:test) do |task|
        task.library_name = :libfoo
      end
    end
    Then { task.library_name == 'libfoo' }
  end
end
