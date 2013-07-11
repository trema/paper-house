Feature: PaperHouse::CExtensionTask

  PaperHouse offers a rake task called `PaperHouse::CExtensionTask`
  that can build a C extention library from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  Scenario: Build a C extension from one *.c and *.h file
    Given the current project directory is "examples/c_extension"
    When I run rake "hello"
    Then I successfully run `ruby -I. -rhello -e "p Hello"`
    And the output should contain:
    """
    Hello
    """

  Scenario: Build a C extension from one *.c and *.h file by specifying 'CC=' option
    Given the current project directory is "examples/c_extension"
    When I run rake "hello CC=/usr/bin/llvm-gcc"
    Then I successfully run `ruby -I. -rhello -e "p Hello"`
    And the output should contain:
    """
    Hello
    """
