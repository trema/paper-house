# encoding: utf-8

require 'paper_house/executable_task'

describe Rake::Task do
  context 'when no tasks are defined' do
    Given { Rake::Task.clear }

    describe '.[]' do
      context 'with :test' do
        Given(:name) { :test }

        When(:result) { Rake::Task[name] }
        Then do
          result ==
            Failure(RuntimeError, "Don't know how to build task 'test'")
        end
      end
    end
  end

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
  Given(:task) { PaperHouse::ExecutableTask.new(name, &block) }

  context 'with :test' do
    When(:name)  { :test }
    When(:block) {}
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
    When(:name) { :test }
    When(:block) do
      proc { |task| task.executable_name = 'executable' }
    end
    Then { task.executable_name == 'executable' }
  end

  context 'with :test and a block setting :executable_name = :executable' do
    When(:name) { :test }
    When(:block) do
      proc { |task| task.executable_name = :executable }
    end
    Then { task.executable_name == 'executable' }
  end
end
