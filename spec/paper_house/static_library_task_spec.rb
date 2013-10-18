# -*- coding: utf-8 -*-
#
# Copyright (C) 2013 NEC Corporation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License, version 3, as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

require 'paper_house/static_library_task'

describe 'Rake::Task' do
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

#
# PaperHouse::StaticLibraryTask spec.
#
module PaperHouse
  describe StaticLibraryTask do
    before { Rake::Task.clear }

    describe '.find_named' do
      subject { StaticLibraryTask.find_named name }

      context 'with :libtest' do
        let(:name) { :libtest }

        context 'when StaticLibraryTask named :libtest is defined' do
          before { StaticLibraryTask.new :libtest }

          it { expect(subject).to be_a StaticLibraryTask }
        end

        context 'when StaticLibraryTask named :libtest is not defined' do
          it { expect(subject).to be_nil }
        end
      end

      context %{with 'libtest'} do
        let(:name) { 'libtest' }

        context 'when StaticLibraryTask named :libtest is defined' do
          before { StaticLibraryTask.new :libtest }

          it { expect(subject).to be_a StaticLibraryTask }
        end
      end

      context 'with :no_such_task' do
        let(:name) { :no_such_task }

        it { expect(subject).to be_nil }
      end
    end

    describe '.new' do
      subject { StaticLibraryTask.new task }

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
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
