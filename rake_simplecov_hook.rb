require 'rubygems'
require 'simplecov'

def scenario_name
  File.basename Dir.pwd
end

def id_file
  File.join Dir.pwd, '..', '..', ".#{scenario_name}_id"
end

def new_scenario_id
  new_id = 0
  new_id = IO.read(id_file).chomp.to_i + 1 if File.exists?(id_file)
  File.open(id_file, 'w') { | file | file.puts new_id }
  new_id
end

SimpleCov.start do
  root File.dirname(__FILE__)
  command_name "#{scenario_name} scenario ##{new_scenario_id}"
  use_merging true
end
