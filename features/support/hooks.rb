Before do
  ENV[ "CC" ] = nil
end


After do
  ENV[ "CC" ] = nil
  Rake::Task.clear
end
