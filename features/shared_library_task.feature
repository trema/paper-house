Feature: PaperHouse::SharedLibraryTask

  PaperHouse offers a rake task called `PaperHouse::SharedLibraryTask`
  that can build a shared library from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  Scenario: Build a shared library from one *.c and *.h file
    Given the current project directory is "examples/shared_library"
    When I run rake "hello"
    Then a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a shared library from one *.c and *.h file by specifying `CC=` option
    Given the current project directory is "examples/shared_library"
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a shared library from multiple *.c and *.h files in subcirectories
    Given the current project directory is "examples/shared_library_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/libprintsqrt.so.0.1.0" should exist
    And a file named "sqrt" should exist
    And I successfully run `./sqrt 4`
    And the output should contain:
    """
    sqrt(4.0) = 2.0
    """
