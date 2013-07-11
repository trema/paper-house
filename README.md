Paper House
===========
[![Gem Version](https://badge.fury.io/rb/paper-house.png)](http://badge.fury.io/rb/paper-house)
[![Build Status](https://travis-ci.org/trema/paper-house.png?branch=master)](https://travis-ci.org/trema/paper-house)
[![Code Climate](https://codeclimate.com/github/trema/paper-house.png)](https://codeclimate.com/github/trema/paper-house)
[![Coverage Status](https://coveralls.io/repos/trema/paper-house/badge.png?branch=master)](https://coveralls.io/r/trema/paper-house)
[![Dependency Status](https://gemnasium.com/trema/paper-house.png)](https://gemnasium.com/trema/paper-house)

<a href="http://www.flickr.com/photos/studiobeerhorst/8221979536/" title="paper houses - 3d woodcut prints by {studiobeerhorst}-bbmarie, on Flickr"><img src="http://farm9.staticflickr.com/8202/8221979536_60404c309d_n.jpg" width="320" height="240" alt="paper houses - 3d woodcut prints" align="right"></a>

Paper House is a class library to easily build C projects using [Rake](https://github.com/jimweirich/rake). It supports the following build targets:

 * [Executable file](http://rubydoc.info/github/trema/paper-house/PaperHouse/ExecutableTask)
 * [Static library](http://rubydoc.info/github/trema/paper-house/PaperHouse/StaticLibraryTask)
 * [Shared library](http://rubydoc.info/github/trema/paper-house/PaperHouse/SharedLibraryTask)
 * [Ruby extension library in C](http://rubydoc.info/github/trema/paper-house/PaperHouse/RubyLibraryTask)

You can find these examples in the [examples/](https://github.com/trema/paper-house/tree/master/examples) directory.


Supported Platforms
-------------------

Paper House supports Linux and Mac OS X, and is tested on the following Ruby versions:

 * 1.8.7
 * 1.9.3
 * 2.0.0


Installation
------------

The simplest way to install Paper House is to use [Bundler](http://gembundler.com/).

Add Paper House to your `Gemfile`:

```ruby
gem 'paper-house'
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


License
-------

Trema is released under the GNU General Public License version 3.0:

* http://www.gnu.org/licenses/gpl.html
