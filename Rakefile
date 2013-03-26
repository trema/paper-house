require "bundler/gem_tasks"
require "coveralls/rake/task"
require "reek/rake/task"
require "rspec/core"
require "rspec/core/rake_task"
require "yard"


task :travis => [ :spec, :cucumber, :reek, "coveralls:push" ]


RSpec::Core::RakeTask.new do | task |
  task.rspec_opts = "--format documentation --color"
end


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


Coveralls::RakeTask.new


task :relish do
  sh "relish push trema/paper-house"
end


YARD::Rake::YardocTask.new do | t |
  t.options = [ "--no-private" ]
  t.options << "--debug" << "--verbose" if $trace
end
