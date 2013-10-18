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

require 'paper_house'

#
# RubyExtensionTask spec.
#
module PaperHouse
  describe RubyExtensionTask, '.new :libtest' do
    subject { RubyExtensionTask.new :libtest }

    its(:cc) { should eq 'gcc' }
    its(:cflags) { should be_empty }
    its(:includes) { should be_empty }
    its(:name) { should eq 'libtest' }
    its(:sources) { should eq '*.c'  }
    its(:target_directory) { should eq '.' }

    it do
      expect do
        Rake::Task[subject.name].invoke
      end.to raise_error('Cannot find sources (*.c).')
    end
  end

  describe RubyExtensionTask, '.new( :libtest ) do ... end' do
    subject do
      RubyExtensionTask.new :libtest do | task |
        task.library_name = 'test'
      end
    end

    its(:library_name) { should eq 'test' }
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
