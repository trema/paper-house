require "bundler/gem_tasks"
require "reek/rake/task"


task :travis => [ :cucumber, :reek ]


require "cucumber/rake/task"
Cucumber::Rake::Task.new do | t |
  t.cucumber_opts = "--tags ~@wip"
end


Reek::Rake::Task.new do | t |
  t.fail_on_error = true
  t.verbose = false
  t.ruby_opts = [ "-rubygems" ]
  t.reek_opts = "--quiet"
  t.source_files = FileList[ "lib/**/*.rb" ]
end


task :relish do
  sh "relish push trema/paper-house"
end
