# encoding: utf-8

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new do |t|
    require 'paper_house/platform'
    t.cucumber_opts = "--profile #{PaperHouse::Platform.name}"
  end
rescue LoadError
  task :cucumber do
    $stderr.puts 'Cucumber is disabled'
  end
end
