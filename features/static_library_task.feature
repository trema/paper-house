Feature: PaperHouse::StaticLibraryTask
  Scenario: Simple C project
    Given a file named "hello.c" with:
      """
      #include <stdio.h>

      void
      hello() {
        printf( "Hello, PaperHouse!\n");
      }
      """
     And a file named "hello.h" with:
      """
      void hello();
      """
     And a file named "main.c" with:
      """
      #include "hello.h"

      int
      main() {
        hello();
        return 0;
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      task :hello => :libhello

      PaperHouse::StaticLibraryTask.new :libhello

      PaperHouse::ExecutableTask.new :hello do | task |
        task.ldflags = "-L."
        task.library_dependencies = "hello"
      end
      """
    When I run rake "hello"
    Then a file named "libhello.a" should exist
     And a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
       """
       Hello, PaperHouse!
       """

  Scenario: C project with subdirectories
    Given a file named "sources/sqrt.c" with:
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
     And a file named "main.c" with:
      """
      #include <stdlib.h>
      #include "includes/sqrt.h"

      int
      main( int argc, char *argv[] ) {
        if ( argc > 1 ) {
          print_sqrt( atof( argv[ 1 ] ) );
        }
        return 0;
      }
      """
     And a file named "Rakefile" with:
      """
      require "paper-house"

      task :sqrt => :libsqrt

      PaperHouse::StaticLibraryTask.new :libsqrt do | task |
        task.library_name = "printsqrt"
        task.target_directory = "objects"
        task.sources = "sources/*.c"
        task.includes = "includes"
        task.cflags = [ "-Werror", "-Wall", "-Wextra" ]
      end

      PaperHouse::ExecutableTask.new :sqrt do | task |
        task.ldflags = "-Lobjects"
        task.library_dependencies = [ "printsqrt", "m" ]
      end
      """
    When I run rake "sqrt"
    Then a file named "objects/libprintsqrt.a" should exist
     And a file named "sqrt" should exist
     And I successfully run `./sqrt 4`
     And the output should contain:
      """
      sqrt(4.0) = 2.0
      """
