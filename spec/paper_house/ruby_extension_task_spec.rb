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

  describe '.find_named' do
    subject { PaperHouse::RubyExtensionTask.find_named name }

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

    context %{with 'test'} do
      let(:name) { 'test' }

      context %{when RubyExtensionTask named 'test' is defined} do
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

      context %{with #library_name = 'new_name'} do
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

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
