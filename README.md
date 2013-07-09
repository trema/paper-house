Paper House
===========
[![Gem Version](https://badge.fury.io/rb/paper-house.png)](http://badge.fury.io/rb/paper-house)
[![Build Status](https://travis-ci.org/trema/paper-house.png?branch=master)](https://travis-ci.org/trema/paper-house)
[![Code Climate](https://codeclimate.com/github/trema/paper-house.png)](https://codeclimate.com/github/trema/paper-house)
[![Coverage Status](https://coveralls.io/repos/trema/paper-house/badge.png?branch=master)](https://coveralls.io/r/trema/paper-house)
[![Dependency Status](https://gemnasium.com/trema/paper-house.png)](https://gemnasium.com/trema/paper-house)

<a href="http://www.flickr.com/photos/studiobeerhorst/8221979536/" title="paper houses - 3d woodcut prints by {studiobeerhorst}-bbmarie, on Flickr"><img src="http://farm9.staticflickr.com/8202/8221979536_60404c309d_n.jpg" width="320" height="240" alt="paper houses - 3d woodcut prints" align="right"></a>

Paper House is a class library to easily build C projects using [Rake](https://github.com/jimweirich/rake). It supports the following build targets:

 * [Executable file](https://www.relishapp.com/trema/paper-house/docs/paperhouse-executabletask)
 * [Static library](https://www.relishapp.com/trema/paper-house/docs/paperhouse-staticlibrarytask)
 * [Shared library](https://www.relishapp.com/trema/paper-house/docs/paperhouse-sharedlibrarytask)
 * [Ruby extension library in C](https://www.relishapp.com/trema/paper-house/docs/paperhouse-rubylibrarytask)


Examples
--------

### Build an executable from one *.c file

Rakefile:
```ruby
require "paper-house"

PaperHouse::ExecutableTask.new :hello
```

hello.c:
```c
#include <stdio.h>

int
main() {
  printf( "Hello, PaperHouse!\n" );
  return 0;
}
```

The hello.c should build and run:
```shell
$ rake hello
$ ./hello
Hello, PaperHouse!
```

### Build an executable from multiple *.c files

Rakefile:
```ruby
require "paper-house"

PaperHouse::ExecutableTask.new :sqrt do | task |
  task.executable_name = "print_sqrt"
  task.target_directory = "objects"
  task.sources = "sources/*.c"
  task.includes = "includes"
  task.cflags = [ "-Wall", "-Wextra" ]
  task.library_dependencies = "m"
end
```

sources/sqrt.c:
```c
#include <stdio.h>
#include <math.h>

void
print_sqrt( double number ) {
  printf( "sqrt(%.1f) = %.1f\n", number, sqrt( number ) );
}
```

includes/sqrt.h:
```c
void print_sqrt( double number );
```

The sqrt.c should build and run:
```shell
$ rake sqrt
$ ./objects/print_sqrt 4
sqrt(4.0) = 2.0
```


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

 * [Usage document generated with Cucumber and Relish](https://www.relishapp.com/trema/paper-house/docs)
 * [API document generated with YARD](http://rubydoc.info/github/trema/paper-house/master/frames)


### Author

[Yasuhito Takamiya](https://github.com/yasuhito) ([@yasuhito](http://twitter.com/yasuhito))

### Contributors

[https://github.com/trema/paper-house/contributors](https://github.com/trema/paper-house/contributors)
