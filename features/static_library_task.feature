Feature: PaperHouse::StaticLibraryTask
  Scenario: Simple C project
    Given the current project directory is "examples/static_library"
    When I run rake "hello"
    Then a file named "libhello.a" should exist
     And a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
     """
     Hello, PaperHouse!
     """

  Scenario: C project with subdirectories
    Given the current project directory is "examples/static_library_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/libprintsqrt.a" should exist
     And a file named "sqrt" should exist
     And I successfully run `./sqrt 4`
     And the output should contain:
     """
     sqrt(4.0) = 2.0
     """
