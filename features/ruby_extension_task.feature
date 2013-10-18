Feature: PaperHouse::RubyExtensionTask

  PaperHouse provides a rake task called `PaperHouse::RubyExtensionTask`
  to build a C extention library from *.c and *.h files. These source
  files can be located in multiple subdirectories.

  @linux
  Scenario: Build a Ruby extension from one *.c and *.h file
    Given the current project directory is "examples/ruby_extension"
    When I run rake "hello"
    Then the output should match /^gcc/
    And the output should not match /^llvm-gcc/
    And a file named "hello.so" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @mac
  Scenario: Build a Ruby extension from one *.c and *.h file
    Given the current project directory is "examples/ruby_extension"
    When I run rake "hello"
    Then the output should match /^gcc/
    And the output should not match /^llvm-gcc/
    And a file named "hello.bundle" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @linux
  Scenario: Build a Ruby extension from one *.c and *.h file using llvm-gcc by specifying 'CC=' option
    Given the current project directory is "examples/ruby_extension"
    When I run rake "hello CC=llvm-gcc"
    Then the output should match /^llvm-gcc/
    And the output should not match /^gcc/
    And a file named "hello.so" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @mac
  Scenario: Build a Ruby extension from one *.c and *.h file using llvm-gcc by specifying 'CC=' option
    Given the current project directory is "examples/ruby_extension"
    When I run rake "hello CC=llvm-gcc"
    Then the output should match /^llvm-gcc/
    And the output should not match /^gcc/
    And a file named "hello.bundle" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @linux
  Scenario: Build a Ruby extension from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/ruby_extension"
    When I run rake "-f Rakefile.llvm hello"
    Then the output should match /^llvm-gcc/
    And the output should not match /^gcc/
    And a file named "hello.so" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @mac
  Scenario: Build a Ruby extension from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/ruby_extension"
    When I run rake "-f Rakefile.llvm hello"
    Then the output should match /^llvm-gcc/
    And the output should not match /^gcc/
    And a file named "hello.bundle" should exist
    And I successfully run `ruby -I. -rhello -e "p HelloPaperHouse"`
    And the output should contain "HelloPaperHouse"

  @linux
  Scenario: Clean
    Given the current project directory is "examples/ruby_extension"
    And I successfully run `rake hello`
    When I successfully run `rake clean`
    Then a file named "hello.o" should not exist
    And a file named ".hello.depends" should exist
    And a file named "hello.so" should exist

  @mac
  Scenario: Clean
    Given the current project directory is "examples/ruby_extension"
    And I successfully run `rake hello`
    When I successfully run `rake clean`
    Then a file named "hello.o" should not exist
    And a file named ".hello.depends" should exist
    And a file named "hello.bundle" should exist

  @linux
  Scenario: Clobber
    Given the current project directory is "examples/ruby_extension"
    And I successfully run `rake hello`
    When I successfully run `rake clobber`
    Then a file named "hello.o" should not exist
    And a file named ".hello.depends" should not exist
    And a file named "hello.so" should not exist

  @mac
  Scenario: Clobber
    Given the current project directory is "examples/ruby_extension"
    And I successfully run `rake hello`
    When I successfully run `rake clobber`
    Then a file named "hello.o" should not exist
    And a file named ".hello.depends" should not exist
    And a file named "hello.bundle" should not exist
