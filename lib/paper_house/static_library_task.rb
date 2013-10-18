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

require 'paper_house/library_task'

module PaperHouse
  # Compiles *.c files into a static library.
  class StaticLibraryTask < LibraryTask
    # Name of target library file.
    def target_file_name
      library_name + '.a'
    end

    private

    def generate_target
      maybe_rm_target
      ar
      ranlib
    end

    def maybe_rm_target
      a_file = target_path
      sh "rm #{a_file}" if FileTest.exist?(a_file)
    end

    def ar
      sh "ar -cq #{target_path} #{objects.to_s}"
    end

    def ranlib
      sh "ranlib #{target_path}"
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
