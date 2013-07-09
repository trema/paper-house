Feature: PaperHouse::RubyLibraryTask
  Scenario: Simple C extension
    Given a file named "hello.c" with:
      """
      #include "ruby.h"

      void
      Init_hello() {
        VALUE cHello = rb_define_class( "Hello", rb_cObject );
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      PaperHouse::RubyLibraryTask.new :hello
      """
    When I run rake "hello"
    Then I successfully run `ruby -I. -rhello -e "p Hello"`
     And the output should contain:
       """
       Hello
       """

  Scenario: Build simple C extension with specifying 'CC=' option
    Given a file named "hello.c" with:
      """
      #include "ruby.h"

      void
      Init_hello() {
        VALUE cHello = rb_define_class( "Hello", rb_cObject );
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      PaperHouse::RubyLibraryTask.new :hello
      """
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then I successfully run `ruby -I. -rhello -e "p Hello"`
     And the output should contain:
       """
       Hello
       """
