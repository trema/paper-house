require "rubygems"
require "simplecov"


def scenario_name
  File.basename Dir.pwd
end


def id_file
  File.join( Dir.getwd, "..", "..", ".#{ scenario_name }_id" )
end


def new_scenario_id
  if File.exists?( id_file )
    new_id = IO.read( id_file ).chomp.to_i + 1
    File.open( id_file, "w" ) { | file | file.puts new_id }
    new_id
  else
    File.open( id_file, "w" ) { | file | file.puts 0 }
    0
  end
end


SimpleCov.start do
  root File.dirname( __FILE__ )
  command_name "#{ scenario_name } scenario ##{ new_scenario_id }"
  use_merging true
end
