# encoding: utf-8

require 'paper_house/shared_library_task'

describe Rake::Task do
  before { Rake::Task.clear }

  describe '.[]' do
    subject { Rake::Task[task] }

    context 'with :libtest' do
      let(:task) { :libtest }

      context 'when SharedLibraryTask named :libtest is defined' do
        before { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

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

describe PaperHouse::SharedLibraryTask do
  before { Rake::Task.clear }

  describe '.find_named' do
    subject { PaperHouse::SharedLibraryTask.find_named name }

    context 'with :libtest' do
      let(:name) { :libtest }

      context 'when SharedLibraryTask named :libtest is defined' do
        before { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

        it { expect(subject).to be_a PaperHouse::SharedLibraryTask }
      end

      context 'when SharedLibraryTask named :libtest is not defined' do
        it { expect(subject).to be_nil }
      end
    end

    context %(with 'libtest') do
      let(:name) { 'libtest' }

      context %(when SharedLibraryTask named 'libtest' is defined) do
        before { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

        it { expect(subject).to be_a PaperHouse::SharedLibraryTask }
      end
    end

    context 'with :no_such_task' do
      let(:name) { :no_such_task }

      it { expect(subject).to be_nil }
    end
  end

  describe '.new' do
    context %(with name :libtest and version '0.1.0') do
      subject { PaperHouse::SharedLibraryTask.new :libtest, '0.1.0' }

      its(:cc) { should eq 'gcc' }
      its(:cflags) { should be_empty }
      its(:includes) { should be_empty }
      its(:name) { should eq 'libtest' }
      its(:sources) { should eq '*.c'  }
      its(:target_directory) { should eq '.' }
      its(:version) { should eq '0.1.0' }
      its(:linker_name) { should eq 'libtest.so' }
      its(:soname) { should eq 'libtest.so.0' }
      its(:target_file_name) { should eq 'libtest.so.0.1.0' }
      its(:library_name) { should eq 'libtest' }
      its(:lname) { should eq 'test' }
    end

    context 'with name :libtest and no version string' do
      subject { PaperHouse::SharedLibraryTask.new :libtest }

      it do
        expect { subject }.to raise_error('version option is a mandatory.')
      end
    end

    context 'with name :libtest and block' do
      subject do
        PaperHouse::SharedLibraryTask.new(:libtest) do | task |
          task.library_name = library_name
          task.version = version
        end
      end

      context %(with #version = '0.1.0') do
        let(:version) { '0.1.0' }

        context %(with #library_name = 'libtest') do
          let(:library_name) { 'libtest' }

          its(:library_name) { should eq 'libtest' }
        end

        context 'with #library_name = :libtest' do
          let(:library_name) { :libtest }

          its(:library_name) { should eq 'libtest' }
        end

        context %(with #library_name = 'test') do
          let(:library_name) { 'test' }

          its(:library_name) { should eq 'libtest' }
        end

        context 'with #library_name = :test' do
          let(:library_name) { :test }

          its(:library_name) { should eq 'libtest' }
        end
      end

      context 'with #version = nil' do
        let(:library_name) { 'libtest' }
        let(:version) { nil }

        it do
          expect { subject }.to raise_error('version option is a mandatory.')
        end
      end
    end
  end
end
