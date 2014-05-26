# encoding: utf-8

begin
  require 'inch/rake'
  Inch::Rake::Suggest.new
rescue LoadError
  task :inch do
    $stderr.puts 'Inch is disabled'
  end
end
