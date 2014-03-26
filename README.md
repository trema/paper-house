Paper House
===========
[![Gem Version](http://img.shields.io/gem/v/paper_house.svg)][gem]
[![Build Status](http://img.shields.io/travis/trema/paper-house/develop.svg)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/trema/paper-house.svg)][codeclimate]
[![Inline docs](http://inch-pages.github.io/github/trema/paper-house.svg)][inchpages]
[![Coverage Status](http://img.shields.io/coveralls/trema/paper-house/develop.svg)][coveralls]
[![Dependency Status](http://img.shields.io/gemnasium/trema/paper-house.svg)][gemnasium]

[gem]: https://rubygems.org/gems/paper_house
[travis]: http://travis-ci.org/trema/paper-house
[codeclimate]: https://codeclimate.com/github/trema/paper-house
[inchpages]: http://inch-pages.github.io/github/trema/paper-house
[coveralls]: https://coveralls.io/r/trema/paper-house?branch=develop
[gemnasium]: https://gemnasium.com/trema/paper-house

<a href="http://www.flickr.com/photos/studiobeerhorst/8221979536/" title="paper houses - 3d woodcut prints by Rick&Brenda Beerhorst, on Flickr"><img src="http://farm9.staticflickr.com/8202/8221979536_60404c309d_n.jpg" width="320" height="240" alt="paper houses - 3d woodcut prints" align="right"></a>

Paper House is a ruby gem to easily build C projects using [Rake](https://github.com/jimweirich/rake). It supports the following build targets:

 * [Executable](http://rubydoc.info/github/trema/paper-house/PaperHouse/ExecutableTask)
 * [Static library](http://rubydoc.info/github/trema/paper-house/PaperHouse/StaticLibraryTask)
 * [Shared library](http://rubydoc.info/github/trema/paper-house/PaperHouse/SharedLibraryTask)
 * [Ruby extension written in C](http://rubydoc.info/github/trema/paper-house/PaperHouse/RubyExtensionTask)


Features Overview
-----------------

 * Provides a simple yet a powerful syntax to build above mentioned
   targets using predefined Rake tasks.
 * Pure Ruby. No additional dependency on other external tools
   ([makedepend](http://linux.die.net/man/1/makedepend) etc.) to
   resolve file dependencies.
 * Multi-Platform. Runs on both Linux and MacOSX, and supports all
   major version of Ruby (1.9.3, 2.0.0).


Example
-------

Its usage is dead simple: to build an executable from all the `*.c`
and `*.h` files in the current directory, just add the following lines
to your `Rakefile`.

```ruby
require 'paper_house'

PaperHouse::ExecutableTask.new :hello
```

This defines a new task `hello`, and `rake hello` will automatically
analyze all file dependencies of the source files, compile them into
an executable named `hello`.

If you wish to customize the build process more, please set the
following options defined in
[PaperHouse::ExecutableTask](http://rubydoc.info/github/trema/paper-house/PaperHouse/ExecutableTask):

```ruby
PaperHouse::ExecutableTask.new :hello do |task|
  task.executable_name = 'hello_world'
  task.target_directory = 'objects'
  task.cc = 'llvm-gcc'
  task.includes = 'includes'
  task.sources = 'sources'
  task.cflags = %w(-Werror -Wall -Wextra)
  task.ldflags = '-L/some/path'
  task.library_dependencies = 'm'
end
```

You can find more examples in the
[examples/](https://github.com/trema/paper-house/tree/master/examples)
directory.


Installation
------------

The simplest way to install Paper House is to use [Bundler](http://gembundler.com/).

Add Paper House to your `Gemfile`:

```ruby
gem 'paper_house'
```

and install it by running Bundler:

```bash
$ bundle
```


Documents
---------

 * [API document generated with YARD](http://rubydoc.info/github/trema/paper-house/frames/file/README.md)
 * [Usage document generated with Cucumber and Relish](https://www.relishapp.com/trema/paper-house/docs)


### Author

[Yasuhito Takamiya](https://github.com/yasuhito) ([@yasuhito](http://twitter.com/yasuhito))

### Contributors

[https://github.com/trema/paper-house/contributors](https://github.com/trema/paper-house/contributors)


Alternatives
------------

 * rake-compiler: https://github.com/luislavena/rake-compiler
 * rake-builder: https://github.com/joeyates/rake-builder
 * Rant: http://rant.rubyforge.org/
 * cxxproject: https://github.com/marcmo/cxxproject


License
-------

Trema is released under the GNU General Public License version 3.0:

* http://www.gnu.org/licenses/gpl.html
