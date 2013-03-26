Feature: PaperHouse::SharedLibraryTask
  Scenario: Generate a shared library
    Given a file named "hello.c" with:
      """
      #include <stdio.h>

      void
      hello() {
        printf( "hello PaperHouse!\n");
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house/shared-library-task"

      PaperHouse::SharedLibraryTask.new "libhello" do | task |
        task.target_directory = "."
        task.sources = "*.c"
        task.version = "0.1.0"
      end
      """
    When I run `rake libhello`
    Then a file named "libhello.so.0.1.0" should exist
