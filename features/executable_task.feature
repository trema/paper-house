Feature: PaperHouse::ExecutableTask
  Scenario: Simple C project
    Given a file named "hello.c" with:
      """
      #include <stdio.h>

      int
      main() {
        printf( "Hello, PaperHouse!\n");
        return 0;
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      PaperHouse::ExecutableTask.new :hello
      """
    When I run rake "hello"
    Then a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
       """
       Hello, PaperHouse!
       """

  Scenario: Build simple C project with specifying 'CC=' option
    Given a file named "hello.c" with:
      """
      #include <stdio.h>

      int
      main() {
        printf( "Hello, PaperHouse!\n");
        return 0;
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      PaperHouse::ExecutableTask.new :hello
      """
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
       """
       Hello, PaperHouse!
       """

  Scenario: C project with subdirectories
    Given a file named "sources/main.c" with:
      """
      #include <stdlib.h>
      #include "sqrt.h"

      int
      main( int argc, char *argv[] ) {
        print_sqrt( atof( argv[ 1 ] ) );
        return 0;
      }
      """
     And a file named "sources/sqrt.c" with:
      """
      #include <stdio.h>
      #include <math.h>

      void
      print_sqrt( double number ) {
        printf( "sqrt(%.1f) = %.1f\n", number, sqrt( number ) );
      }
      """
     And a file named "includes/sqrt.h" with:
      """
      void print_sqrt( double number );
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      PaperHouse::ExecutableTask.new :sqrt do | task |
        task.executable_name = "print_sqrt"
        task.target_directory = "objects"
        task.sources = "sources/*.c"
        task.includes = "includes"
        task.cflags = [ "-Wall", "-Wextra" ]
        task.library_dependencies = "m"
      end
      """
    When I run rake "sqrt"
    Then a file named "objects/print_sqrt" should exist
     And I successfully run `./objects/print_sqrt 4`
     And the output should contain:
      """
      sqrt(4.0) = 2.0
      """
