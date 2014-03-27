# encoding: utf-8

require 'paper_house/ruby_extension_task'

describe Rake::Task do
  context 'when RubyExtensionTask (name = :test) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::RubyExtensionTask.new :test }

    describe '.[]' do
      context 'with :test' do
        Given(:name) { :test }

        When(:task) { Rake::Task[name] }
        Then { task.is_a? Rake::Task }

        describe '#invoke' do
          When(:result) { task.invoke }
          Then do
            result ==
              Failure(RuntimeError, 'Cannot find sources (*.c).')
          end
        end
      end
    end
  end
end

describe PaperHouse::RubyExtensionTask, '.new' do
  context 'with :test' do
    When(:task) { PaperHouse::RubyExtensionTask.new(:test) }
    Then { task.name == 'test' }
    Then { task.library_name == 'test' }
    Then { task.sources == '*.c' }
    Then { task.target_directory == '.' }
    Then { task.cc == 'gcc' }
    Then { task.library_dependencies == ['ruby'] }
    Then { task.cflags.empty? }
    Then { task.includes.empty? }
    Then { task.ldflags.empty? }
  end

  context "with :test and a block setting :library_name = 'libtest'" do
    When(:task) do
      PaperHouse::RubyExtensionTask.new(:test) do |task|
        task.library_name = 'libtest'
      end
    end
    Then { task.library_name == 'libtest' }
  end

  context 'with :test and a block setting :library_name = :libtest' do
    When(:task) do
      PaperHouse::RubyExtensionTask.new(:test) do |task|
        task.library_name = :libtest
      end
    end
    Then { task.library_name == 'libtest' }
  end
end
