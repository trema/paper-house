Feature: PaperHouse::StaticLibraryTask
  Scenario: Generate a static library
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
      require "paper-house/static-library-task"

      PaperHouse::StaticLibraryTask.new "libhello" do | task |
        task.target_directory = "."
        task.sources = "*.c"
      end
      """
    When I run `rake libhello`
    Then a file named "libhello.a" should exist

