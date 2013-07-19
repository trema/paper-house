# More info at https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end


guard :rspec, :cli => "--color -r rspec/instafail -f RSpec::Instafail", :all_on_start => false do
  watch(%r{^spec/paper-house/.+_spec\.rb$})
  watch(%r{^lib/paper-house/(.+)\.rb$})     { |m| "spec/paper-house/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


require "paper-house/platform"

cli_opts = %w(--format progress --strict --profile) + [ PaperHouse::Platform::MAC ? "mac" : "linux" ]

guard :cucumber, :cli => cli_opts.join( " " ), :all_on_start => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
