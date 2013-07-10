Feature: PaperHouse::SharedLibraryTask
  Scenario: Build simple shared library
    Given the current project directory is "examples/shared_library"
    When I run rake "hello"
    Then a file named "libhello.so.0.1.0" should exist
     And a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
     """
     Hello, PaperHouse!
     """

  Scenario: Build simple shared library with specifying 'CC=' option
    Given the current project directory is "examples/shared_library"
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then a file named "libhello.so.0.1.0" should exist
     And a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
     """
     Hello, PaperHouse!
     """

  Scenario: C project with subdirectories
    Given the current project directory is "examples/shared_library_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/libprintsqrt.so.0.1.0" should exist
     And a file named "sqrt" should exist
     And I successfully run `./sqrt 4`
     And the output should contain:
     """
     sqrt(4.0) = 2.0
     """
