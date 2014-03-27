# encoding: utf-8

require 'paper_house/executable_task'

describe Rake::Task, '.[]' do
  Given { Rake::Task.clear }

  context 'with :test' do
    When(:result) { Rake::Task[:test] }
    Then do
      result == Failure(RuntimeError, "Don't know how to build task 'test'")
    end
  end

  context 'when ExecutableTask.new(:test)' do
    Given { PaperHouse::ExecutableTask.new :test }

    context 'with :test' do
      Given(:task) { Rake::Task[:test] }

      describe '#invoke' do
        When(:result) { task.invoke }
        Then { result == Failure(RuntimeError, 'Cannot find sources (*.c).') }
      end
    end
  end
end

describe PaperHouse::ExecutableTask, '.new' do
  Given { Rake::Task.clear }

  context 'with :test' do
    When(:task) { PaperHouse::ExecutableTask.new :test }
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

  context 'with :test and a block setting :executable_name in String' do
    When(:task) do
      PaperHouse::ExecutableTask.new(:test) do |task|
        task.executable_name = 'executable'
      end
    end
    Then { task.executable_name == 'executable' }
  end

  context 'with :test and a block setting :executable_name in Symbol' do
    When(:task) do
      PaperHouse::ExecutableTask.new(:test) do |task|
        task.executable_name = :executable
      end
    end
    Then { task.executable_name == :executable }
  end
end
