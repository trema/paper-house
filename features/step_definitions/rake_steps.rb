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
