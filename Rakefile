require "bundler/gem_tasks"
require "reek/rake/task"


Reek::Rake::Task.new do | t |
  t.fail_on_error = true
  t.verbose = false
  t.ruby_opts = [ "-rubygems" ]
  t.reek_opts = "--quiet"
  t.source_files = FileList[ "lib/**/*.rb" ]
end
