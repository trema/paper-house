Feature: PaperHouse::StaticLibraryTask

  PaperHouse provides a rake task called
  `PaperHouse::StaticLibraryTask` that can build a static library from
  *.c and *.h files. These source files can be located in multiple
  subdirectories.

  Scenario: Build a static library from one *.c and *.h file
    Given the current project directory is "examples/static_library"
    When I successfully run `rake hello`
    Then the output should contain:
    """
    gcc -H -fPIC -I. -c hello.c -o ./hello.o
    gcc -H -fPIC -I. -c main.c -o ./main.o
    ar -cq ./libhello.a ./hello.o
    ranlib ./libhello.a
    gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.a" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from one *.c and *.h file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/static_library"
    When I successfully run `rake hello CC=llvm-gcc`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    ar -cq ./libhello.a ./hello.o
    ranlib ./libhello.a
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.a" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/static_library"
    When I successfully run `rake -f Rakefile.llvm hello`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    ar -cq ./libhello.a ./hello.o
    ranlib ./libhello.a
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.a" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from multiple *.c and *.h files in subcirectories
    Given the current project directory is "examples/static_library_subdirs"
    When I successfully run `rake sqrt`
    Then a file named "objects/libprintsqrt.a" should exist
    And a file named "sqrt" should exist
    And I successfully run `./sqrt 4`
    And the output should contain:
    """
    sqrt(4.0) = 2.0
    """
