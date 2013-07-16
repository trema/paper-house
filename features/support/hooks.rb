Before do
  ENV[ "CC" ] = nil
  @aruba_timeout_seconds = 5
end


After do
  ENV[ "CC" ] = nil
  Rake::Task.clear
end
