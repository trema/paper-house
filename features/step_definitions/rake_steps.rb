When(/^I run rake "(.*?)"$/) do | task |
  in_current_dir do
    load "Rakefile"
    Rake::Task[ task ].invoke
  end
end
