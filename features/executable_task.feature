Feature: PaperHouse::ExecutableTask
  Scenario: Generate an executable
    Given a file named "hello.c" with:
      """
      #include <stdio.h>

      int
      main( int argc, char *argv[] ) {
        printf( "Hello PaperHouse!\n");
        return 0;
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house/executable-task"

      PaperHouse::ExecutableTask.new :hello do | task |
        task.target_directory = "."
        task.sources = [ "*.c" ]
      end
      """
    When I run rake "hello"
    Then a file named "hello" should exist
