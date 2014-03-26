# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paper_house/version'

Gem::Specification.new do |gem|
  gem.name = 'paper_house'
  gem.version = PaperHouse::VERSION
  gem.summary = 'Rake for C projects.'
  gem.description = 'Rake tasks for compiling C projects.'

  gem.license = 'GPL3'

  gem.authors = ['Yasuhito Takamiya']
  gem.email = ['yasuhito@gmail.com']
  gem.homepage = 'http://github.com/trema/paper-house'

  gem.files = %w(CONTRIBUTING.md LICENSE Rakefile paper_house.gemspec)
  gem.files += Dir.glob('lib/**/*.rb')
  gem.files += Dir.glob('bin/**/*')
  gem.files += Dir.glob('spec/**/*')
  gem.files += Dir.glob('features/**/*')

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = ['README.md']
  gem.test_files = Dir.glob('spec/**/*')
  gem.test_files += Dir.glob('features/**/*')

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_dependency 'POpen4', '~> 0.1.4'
  gem.add_dependency 'rake', '~> 10.2.1'
end
