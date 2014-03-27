# encoding: utf-8

require 'rbconfig'

module PaperHouse
  # Platform-dependent stuff.
  module Platform
    include RbConfig

    # MACOSX or not.
    MAC = (/darwin|mac os/ =~ CONFIG['host_os'])

    # File extension of C extensions.
    SHARED_EXT = (MAC ? '.bundle' : '.so').freeze

    # CC options for compiling shared libraries.
    LDSHARED = (MAC ? '-dynamic -bundle' : '-shared').freeze

    # CC option for setting soname.
    SONAME_OPTION = (MAC ? '-install_name' : '-soname').freeze

    # Include directories for compiling C extensions.
    RUBY_INCLUDES =
      [
        File.join(CONFIG['rubyhdrdir'], CONFIG['arch']),
        File.join(CONFIG['rubyhdrdir'], 'ruby/backward'),
        CONFIG['rubyhdrdir']
      ].freeze

    # Library directories for compiling C extensions.
    RUBY_LIBDIR = CONFIG['libdir'].freeze

    # Platform name.
    def self.name
      (MAC ? 'mac' : 'linux').freeze
    end
  end
end
