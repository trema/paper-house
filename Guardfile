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


guard 'rspec', :cli => "--color --drb -r rspec/instafail -f RSpec::Instafail", :all_on_start => false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end


guard 'cucumber', :cli => "--drb", :all_on_start => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
