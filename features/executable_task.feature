Feature: PaperHouse::ExecutableTask
  Scenario: Simple C project
    Given the current project directory is "examples/executable"
    When I run rake "hello"
    Then a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
     """
     Hello, PaperHouse!
     """

  Scenario: Build simple C project with specifying 'CC=' option
    Given the current project directory is "examples/executable"
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then a file named "hello" should exist
     And I successfully run `./hello`
     And the output should contain:
     """
     Hello, PaperHouse!
     """

  Scenario: C project with subdirectories
    Given the current project directory is "examples/executable_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/print_sqrt" should exist
     And I successfully run `./objects/print_sqrt 4`
     And the output should contain:
     """
     sqrt(4.0) = 2.0
     """
