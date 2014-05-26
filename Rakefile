# encoding: utf-8

task default: :travis
task travis: [:spec, :cucumber, :quality, 'coveralls:push']

desc 'Check for code quality'
task quality: [:reek, :flog, :flay, :rubocop]

Dir.glob('tasks/*.rake').each { |each| import each }
