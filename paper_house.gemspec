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

  gem.files = `git ls-files`.split("\n")

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = ['README.md']
  gem.test_files = `git ls-files -- {spec,features}/*`.split("\n")

  gem.add_dependency 'POpen4', '~> 0.1.4'
  gem.add_dependency 'rake', '~> 10.1.1'
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
