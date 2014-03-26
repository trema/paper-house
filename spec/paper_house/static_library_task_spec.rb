# encoding: utf-8

require 'paper_house/static_library_task'

describe Rake::Task do
  before { Rake::Task.clear }

  describe '.[]' do
    subject { Rake::Task[task] }

    context 'with :libtest' do
      let(:task) { :libtest }

      context 'when StaticLibraryTask named :libtest is defined' do
        before { PaperHouse::StaticLibraryTask.new :libtest }

        describe '#invoke' do
          it do
            expect do
              subject.invoke
            end.to raise_error('Cannot find sources (*.c).')
          end
        end
      end

      context 'when StaticLibraryTask named :libtest is not defined' do
        it { expect { subject }.to raise_error }
      end
    end
  end
end

describe PaperHouse::StaticLibraryTask do
  before { Rake::Task.clear }

  describe '.find_named' do
    subject { PaperHouse::StaticLibraryTask.find_named name }

    context 'with :libtest' do
      let(:name) { :libtest }

      context 'when StaticLibraryTask named :libtest is defined' do
        before { PaperHouse::StaticLibraryTask.new :libtest }

        it { expect(subject).to be_a PaperHouse::StaticLibraryTask }
      end

      context 'when StaticLibraryTask named :libtest is not defined' do
        it { expect(subject).to be_nil }
      end
    end

    context %(with 'libtest') do
      let(:name) { 'libtest' }

      context 'when StaticLibraryTask named :libtest is defined' do
        before { PaperHouse::StaticLibraryTask.new :libtest }

        it { expect(subject).to be_a PaperHouse::StaticLibraryTask }
      end
    end

    context 'with :no_such_task' do
      let(:name) { :no_such_task }

      it { expect(subject).to be_nil }
    end
  end

  describe '.new' do
    subject { PaperHouse::StaticLibraryTask.new task }

    context 'with :libtest' do
      let(:task) { :libtest }

      its(:cc) { should eq 'gcc' }
      its(:cflags) { should be_empty }
      its(:includes) { should be_empty }
      its(:name) { should eq 'libtest' }
      its(:sources) { should eq '*.c'  }
      its(:target_directory) { should eq '.' }
      its(:library_name) { should eq 'libtest' }
      its(:lname) { should eq 'test' }
      its(:target_file_name) { should eq 'libtest.a' }
      its(:target_path) { should eq './libtest.a' }
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
