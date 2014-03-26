# encoding: utf-8

require 'paper_house/executable_task'

describe Rake::Task do
  before { Rake::Task.clear }

  describe '.[]' do
    subject { Rake::Task[task] }

    context 'with :test' do
      let(:task) { :test }

      context 'when ExecutableTask named :test is defined' do
        before { PaperHouse::ExecutableTask.new :test }

        describe '#invoke' do
          it do
            expect do
              subject.invoke
            end.to raise_error('Cannot find sources (*.c).')
          end
        end
      end

      context 'when ExecutableTask named :test is not defined' do
        it { expect { subject }.to raise_error }
      end
    end
  end
end

describe PaperHouse::ExecutableTask, '.new' do
  context 'with name :test' do
    subject { PaperHouse::ExecutableTask.new :test }

    its(:cc) { should eq 'gcc' }
    its(:cflags) { should be_empty }
    its(:executable_name) { should eq 'test' }
    its(:includes) { should be_empty }
    its(:ldflags) { should be_empty }
    its(:library_dependencies) { should be_empty }
    its(:name) { should eq 'test' }
    its(:sources) { should eq '*.c'  }
    its(:target_directory) { should eq '.' }
  end

  context 'with :test and block' do
    subject do
      PaperHouse::ExecutableTask.new(:test) do | task |
        task.executable_name = executable_name
      end
    end

    context %(with #executable_name = 'new_name') do
      let(:executable_name) { 'new_name' }

      its(:executable_name) { should eq 'new_name' }
    end

    context 'with #executable_name = :new_name' do
      let(:executable_name) { :new_name }

      its(:executable_name) { should eq :new_name }
    end
  end
end
