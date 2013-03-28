require "bundler/gem_tasks"
require "rake/tasklib"
require "flay"
require "flay_task"
require "flog"
require "reek/rake/task"
require "rspec/core"
require "rspec/core/rake_task"
require "yard"


$ruby_source = FileList[ "lib/**/*.rb" ]


task :default => :travis
task :travis => [ :spec, :cucumber, :quality ]
task :quality => [ :reek, :flog, :flay ]


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
  t.source_files = $ruby_source
end


desc "Analyze for code complexity"
task :flog do
  flog = Flog.new( :continue => true )
  flog.flog $ruby_source
  threshold = 10

  bad_methods = flog.totals.select do | name, score |
    ( not ( /#none$/=~ name ) ) and score > threshold
  end
  bad_methods.sort do | a, b |
    a[ 1 ] <=> b[ 1 ]
  end.each do | name, score |
    puts "%8.1f: %s" % [ score, name ]
  end
  unless bad_methods.empty?
    raise "#{ bad_methods.size } methods have a flog complexity > #{ threshold }"
  end
end


FlayTask.new do | t |
  t.dirs = $ruby_source.collect do | each |
    each[ /[^\/]+/ ]
  end.uniq
  t.threshold = 0
  t.verbose = $trace
end


task :relish do
  sh "relish push trema/paper-house"
end


YARD::Rake::YardocTask.new do | t |
  t.options = [ "--no-private" ]
  t.options << "--debug" << "--verbose" if $trace
end
