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

      PaperHouse::RubyLibraryTask.new :hello do | task |
        task.library_dependencies = "ruby"
      end
      """
    When I run rake "hello"
    Then I successfully run `ruby -rhello -e "p Hello"`
     And the output should contain:
       """
       Hello
       """
