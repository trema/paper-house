Feature: PaperHouse::RubyLibraryTask
  Scenario: Generate a Ruby library
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
      require "paper-house/ruby-library-task"

      PaperHouse::RubyLibraryTask.new "hello" do | task |
        task.library_dependencies = [ "ruby" ]
      end
      """
    When I run rake "hello"
    Then a file named "hello.so" should exist
