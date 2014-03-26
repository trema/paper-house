# -*- coding: utf-8 -*-

Given(/^the current project directory is "(.*?)"$/) do | dir |
  example_name = File.basename(dir)
  in_current_dir do
    FileUtils.cp_r File.join('..', '..', dir), '.'
    Dir.chdir example_name do
      system 'rake clobber'
      FileUtils.rm_r 'objects' if FileTest.exists?('objects')
    end
  end
  step %(I cd to "#{example_name}")
end

When(/^I run rake "(.*?)"$/) do |args|
  step "I successfully run `rake #{args} -I../../.. -rrake_simplecov_hook`"
end
