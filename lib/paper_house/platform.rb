# encoding: utf-8

require 'rbconfig'

module PaperHouse
  # Platform-dependent stuff.
  module Platform
    include RbConfig

    # MACOSX or not.
    MAC = (/darwin|mac os/ =~ CONFIG['host_os'])

    # File extension of C extensions.
    SHARED_EXT = MAC ? '.bundle' : '.so'

    # CC options for compiling shared libraries.
    LDSHARED = MAC ? '-dynamic -bundle' : '-shared'

    # CC option for setting soname.
    SONAME_OPTION = MAC ? '-install_name' : '-soname'

    # Include directories for compiling C extensions.
    RUBY_INCLUDES =
      [
        File.join(CONFIG['rubyhdrdir'], CONFIG['arch']),
        File.join(CONFIG['rubyhdrdir'], 'ruby/backward'),
        CONFIG['rubyhdrdir']
      ]

    # Library directories for compiling C extensions.
    RUBY_LIBDIR = CONFIG['libdir']

    def self.name
      MAC ? 'mac' : 'linux'
    end
  end
end
