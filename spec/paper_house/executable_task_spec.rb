# encoding: utf-8

require 'paper_house/executable_task'

describe Rake::Task do
  context 'when ExecutableTask (name = :test) is defined' do
    Given { Rake::Task.clear }
    Given { PaperHouse::ExecutableTask.new :test }

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

describe PaperHouse::ExecutableTask, '.new' do
  context 'with :test' do
    When(:task) { PaperHouse::ExecutableTask.new(:test) }
    Then { task.name == 'test' }
    Then { task.executable_name == 'test' }
    Then { task.sources == '*.c' }
    Then { task.target_directory == '.' }
    Then { task.cc == 'gcc' }
    Then { task.cflags.empty? }
    Then { task.includes.empty? }
    Then { task.ldflags.empty? }
    Then { task.library_dependencies.empty? }
  end

  context "with :test and a block setting :executable_name = 'executable'" do
    When(:task) do
      PaperHouse::ExecutableTask.new(:test) do |task|
        task.executable_name = 'executable'
      end
    end
    Then { task.executable_name == 'executable' }
  end

  context 'with :test and a block setting :executable_name = :executable' do
    When(:task) do
      PaperHouse::ExecutableTask.new(:test) do |task|
        task.executable_name = :executable
      end
    end
    Then { task.executable_name == 'executable' }
  end
end
