lib = File.expand_path( "../lib", __FILE__ )
$LOAD_PATH.unshift( lib ) unless $LOAD_PATH.include?( lib )
require "paper-house/version"


Gem::Specification.new do | gem |
  gem.name = "paper-house"
  gem.version = PaperHouse::VERSION
  gem.summary = "Rake for C."
  gem.description = "Rake tasks for compiling C projects."

  gem.license = "GPL2"

  gem.authors = [ "Yasuhito Takamiya" ]
  gem.email = [ "yasuhito@gmail.com" ]
  gem.homepage = "http://github.com/trema/paper-house"

  gem.files = `git ls-files`.split( "\n" )

  gem.require_paths = [ "lib" ]

  gem.extra_rdoc_files = [ "README.md" ]
  gem.test_files = `git ls-files -- {spec,features}/*`.split( "\n" )

  gem.add_dependency "popen4", "~> 0.1.2"
  gem.add_dependency "rake", "~> 10.0.3"
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
