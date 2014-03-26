# encoding: utf-8

notification :terminal_notifier
notification :tmux, display_message: true

guard :rspec do
  watch(%r{^spec/paper_house/.+_spec\.rb$})
  watch(%r{^lib/paper_house/(.+)\.rb$}) do |m|
    "spec/paper_house/#{m[1]}_spec.rb"
  end
  watch('spec/spec_helper.rb') { 'spec' }
end

require 'paper_house/platform'

cli_opts = "--format progress --strict --profile #{PaperHouse::Platform.name}"

guard :cucumber, cli: cli_opts, all_on_start: false do
  watch(/^features\/.+\.feature$/)
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  end
end

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end
