Given(/^the current project directory is "(.*?)"$/) do | dir |
  in_current_dir do
    project_files = Dir.glob( File.join( "..", "..", dir, "*" ) )
    FileUtils.cp_r project_files, "."
  end
end


When(/^I run rake "(.*?)"$/) do | args |
  arglist = args.split( /\s+/ )

  task = arglist.shift

  arglist.each do | each |
    if each.include?( "=" )
      env, value = each.split( "=" )
      ENV[ env ] = value
    end
  end

  in_current_dir do
    load "Rakefile"
    Rake::Task[ task ].invoke
  end
end
