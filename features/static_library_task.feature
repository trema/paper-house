Feature: PaperHouse::StaticLibraryTask

  PaperHouse offers a rake task called `PaperHouse::StaticLibraryTask`
  that can build a static library from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  Scenario: Build a static library from one *.c and *.h file
    Given the current project directory is "examples/static_library"
    When I run rake "hello"
    Then a file named "libhello.a" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/static_library"
    When I run rake "llvm_hello"
    Then a file named "libhello.a" should exist
    And a file named "llvm_hello" should exist
    And I successfully run `./llvm_hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from one *.c and *.h file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/static_library"
    When I run rake "hello CC=llvm-gcc"
    Then a file named "libhello.a" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build a static library from multiple *.c and *.h files in subcirectories
    Given the current project directory is "examples/static_library_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/libprintsqrt.a" should exist
    And a file named "sqrt" should exist
    And I successfully run `./sqrt 4`
    And the output should contain:
    """
    sqrt(4.0) = 2.0
    """
