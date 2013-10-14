# More info at https://github.com/guard/guard#readme

notification :terminal_notifier
notification :tmux, :display_message => true


guard :rspec, :cmd => "rspec --color -r rspec/instafail -f RSpec::Instafail", :all_on_start => false do
  watch(%r{^spec/paper_house/.+_spec\.rb$})
  watch(%r{^lib/paper_house/(.+)\.rb$})     { |m| "spec/paper_house/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


require "paper_house/platform"

cli_opts = %w(--format progress --strict --profile) + [ PaperHouse::Platform::MAC ? "mac" : "linux" ]

guard :cucumber, :cli => cli_opts.join( " " ), :all_on_start => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
