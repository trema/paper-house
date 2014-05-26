# encoding: utf-8

require 'paper_house/shared_library_task'

describe Rake::Task do
  context 'when SharedLibraryTask (name = :libtest) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

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

describe PaperHouse::SharedLibraryTask do
  context 'when no tasks are defined' do
    Given { Rake::Task.clear }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::SharedLibraryTask.find_by_name('libtest') }
        Then { result.nil? }
      end
    end
  end

  context 'when SharedLibraryTask (name = :libtest) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::SharedLibraryTask.find_by_name('libtest') }
        Then { result.is_a? PaperHouse::SharedLibraryTask }
      end
    end
  end

  context "when SharedLibraryTask (name = 'libtest') is defined" do
    Given { Rake::Task.clear }
    Given { PaperHouse::SharedLibraryTask.new 'libtest', '0.1.0' }

    describe '.find_by_name' do
      context "with 'libtest'" do
        When(:result) { PaperHouse::SharedLibraryTask.find_by_name('libtest') }
        Then { result.is_a? PaperHouse::SharedLibraryTask }
      end
    end
  end
end

describe PaperHouse::SharedLibraryTask, '.new' do
  context "with :libtest and '0.1.0'" do
    When(:task) { PaperHouse::SharedLibraryTask.new(:libtest, '0.1.0') }
    Then { task.name == 'libtest' }
    Then { task.library_name == 'libtest' }
    Then { task.cc == 'gcc' }
    Then { task.cflags.empty? }
    Then { task.includes.empty? }
    Then { task.sources == '*.c'  }
    Then { task.target_directory == '.' }
    Then { task.lname == 'test' }
    Then { task.version == '0.1.0' }
    Then { task.linker_name == 'libtest.so' }
    Then { task.soname == 'libtest.so.0' }
    Then { task.target_file_name == 'libtest.so.0.1.0' }
    Then { task.target_path == './libtest.so.0.1.0' }
  end

  context 'with :test and a block setting '\
  ":version = '0.1.0' and :library_name = 'libfoo'" do
    When(:task) do
      PaperHouse::SharedLibraryTask.new(:libtest) do |task|
        task.version = '0.1.0'
        task.library_name = 'libfoo'
      end
    end
    Then { task.version == '0.1.0' }
    Then { task.library_name == 'libfoo' }
  end

  context "with :test, '0.1.0' and a block setting :library_name = :libfoo" do
    When(:task) do
      PaperHouse::SharedLibraryTask.new(:libtest, '0.1.0') do |task|
        task.library_name = 'libfoo'
      end
    end
    Then { task.library_name == 'libfoo' }
  end

  context 'with :test and no optional arguments' do
    When(:result) { PaperHouse::SharedLibraryTask.new(:libtest) }
    Then { result == Failure(RuntimeError, 'version option is a mandatory.') }
  end
end
