Feature: PaperHouse::ExecutableTask

  PaperHouse offers a rake task called `PaperHouse::ExecutableTask`
  that can build an executable from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  Scenario: Build an executable from one *.c file
    Given the current project directory is "examples/executable"
    When I run rake "hello"
    Then a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build an executable from one *.c file using llvm-gcc
    Given the current project directory is "examples/executable"
    When I run rake "llvm_hello"
    Then a file named "llvm_hello" should exist
    And I successfully run `./llvm_hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build an executable from one *.c file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/executable"
    When I run rake "hello CC=llvm-gcc"
    Then a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build an executable from multiple *.c and *.h files in subdirectories
    Given the current project directory is "examples/executable_subdirs"
    When I run rake "sqrt"
    Then a file named "objects/print_sqrt" should exist
    And I successfully run `./objects/print_sqrt 4`
    And the output should contain:
    """
    sqrt(4.0) = 2.0
    """
