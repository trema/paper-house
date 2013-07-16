Feature: PaperHouse::ExecutableTask

  PaperHouse provides a rake task called `PaperHouse::ExecutableTask`
  that can build an executable from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  Scenario: Build an executable from one *.c file
    Given the current project directory is "examples/executable"
    When I successfully run `rake hello`
    Then a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build an executable from one *.c file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/executable"
    When I successfully run `rake hello CC=llvm-gcc`
    Then a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Build an executable from one *.c file using llvm-gcc
    Given the current project directory is "examples/executable"
    When I successfully run `rake -f Rakefile.llvm hello`
    Then a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: clean
    Given the current project directory is "examples/executable"
    And I successfully run `rake hello`
    When I successfully run `rake clean`
    Then a file named "hello.o" should not exist
    And a file named ".hello.depends" should exist
    And a file named "hello" should exist

  Scenario: clobber
    Given the current project directory is "examples/executable"
    And I successfully run `rake hello`
    When I successfully run `rake clobber`
    Then a file named "hello" should not exist
    And a file named "hello.o" should not exist
    And a file named ".hello.depends" should not exist

  Scenario: Build an executable from multiple *.c and *.h files in subdirectories
    Given the current project directory is "examples/executable_subdirs"
    When I successfully run `rake sqrt`
    Then a file named "objects/print_sqrt" should exist
    And I successfully run `./objects/print_sqrt 4`
    And the output should contain:
    """
    sqrt(4.0) = 2.0
    """
