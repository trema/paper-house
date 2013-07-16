Before do
  ENV[ "CC" ] = nil
  ENV[ "dragonegg_disable_version_check" ] = "1"
  @aruba_timeout_seconds = 5
end


After do
  ENV[ "CC" ] = nil
  ENV[ "dragonegg_disable_version_check" ] = nil
  Rake::Task.clear
end
