# More info at https://github.com/guard/guard#readme


guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end


guard 'spork' do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch(%r{features/support/}) { :cucumber }
end


guard 'rspec', :cli => "--color --drb -r rspec/instafail -f RSpec::Instafail", :rvm => [ "1.8.7", "1.9.3", "2.0.0" ], :all_on_start => false do
  watch(%r{^spec/paper-house/.+_spec\.rb$})
  watch(%r{^lib/paper-house/(.+)\.rb$})     { |m| "spec/paper-house/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


require "paper-house/platform"

cli_opts = %w(--format progress --strict --profile)
if PaperHouse::Platform::MAC
  cli_opts << "mac"
else
  cli_opts << "linux"
end

guard 'cucumber', :cli => cli_opts.join( " " ), :rvm => [ "1.8.7", "1.9.3", "2.0.0" ], :all_on_start => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
