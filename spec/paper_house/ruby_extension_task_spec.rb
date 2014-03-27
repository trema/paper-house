# encoding: utf-8

require 'paper_house/ruby_extension_task'

describe Rake::Task do
  before { Rake::Task.clear }

  describe '.[]' do
    subject { Rake::Task[task] }

    context 'with :test' do
      let(:task) { :test }

      context 'when RubyExtensionTask named :test is defined' do
        before { PaperHouse::RubyExtensionTask.new :test }

        describe '#invoke' do
          it do
            expect do
              subject.invoke
            end.to raise_error('Cannot find sources (*.c).')
          end
        end
      end

      context 'when RubyExtensionTask named :test is not defined' do
        it { expect { subject }.to raise_error }
      end
    end
  end
end

describe PaperHouse::RubyExtensionTask do
  before { Rake::Task.clear }

  describe '.find_by_name' do
    subject { PaperHouse::RubyExtensionTask.find_by_name name }

    context 'with :test' do
      let(:name) { :test }

      context 'when RubyExtensionTask named :test is defined' do
        before { PaperHouse::RubyExtensionTask.new :test }

        it { expect(subject).to be_a PaperHouse::RubyExtensionTask }
      end

      context 'when RubyExtensionTask named :test is not defined' do
        it { expect(subject).to be_nil }
      end
    end

    context %(with 'test') do
      let(:name) { 'test' }

      context %(when RubyExtensionTask named 'test' is defined) do
        before { PaperHouse::RubyExtensionTask.new :test }

        it { expect(subject).to be_a PaperHouse::RubyExtensionTask }
      end
    end

    context 'with :no_such_task' do
      let(:name) { :no_such_task }

      it { expect(subject).to be_nil }
    end
  end

  describe '.new' do
    context 'with :test' do
      subject { PaperHouse::RubyExtensionTask.new :test }

      its(:cc) { should eq 'gcc' }
      its(:cflags) { should be_empty }
      its(:includes) { should be_empty }
      its(:name) { should eq 'test' }
      its(:sources) { should eq '*.c'  }
      its(:target_directory) { should eq '.' }
    end

    context 'with :test and block' do
      subject do
        PaperHouse::RubyExtensionTask.new(:test) do | task |
          task.library_name = library_name
        end
      end

      context %(with #library_name = 'new_name') do
        let(:library_name) { 'new_name' }

        its(:library_name) { should eq 'new_name' }
      end

      context 'with #library_name = :new_name' do
        let(:library_name) { :new_name }

        its(:library_name) { should eq :new_name }
      end
    end
  end
end
