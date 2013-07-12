Given(/^the current project directory is "(.*?)"$/) do | dir |
  in_current_dir do
    project_files = Dir.glob( File.join( "..", "..", dir, "*" ) )
    FileUtils.cp_r project_files, "."
  end
end
