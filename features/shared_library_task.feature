Feature: PaperHouse::SharedLibraryTask

  PaperHouse provides a rake task called
  `PaperHouse::SharedLibraryTask` to build a shared library from *.c
  and *.h files. These source files can be located in multiple
  subdirectories.

  @linux
  Scenario: Build a shared library from one *.c and *.h file
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello`
    Then the output should contain:
    """
    gcc -H -fPIC -I. -c hello.c -o ./hello.o
    gcc -H -fPIC -I. -c main.c -o ./main.o
    gcc -shared -Wl,-soname,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @mac
  Scenario: Build a shared library from one *.c and *.h file
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello`
    Then the output should contain:
    """
    gcc -H -fPIC -I. -c hello.c -o ./hello.o
    gcc -H -fPIC -I. -c main.c -o ./main.o
    gcc -shared -Wl,-install_name,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @linux
  Scenario: Build a shared library from one *.c and *.h file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello CC=llvm-gcc`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    llvm-gcc -shared -Wl,-soname,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @mac
  Scenario: Build a shared library from one *.c and *.h file using llvm-gcc by specifying `CC=` option
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello CC=llvm-gcc`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    llvm-gcc -shared -Wl,-install_name,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @linux
  Scenario: Build a shared library from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake -f Rakefile.llvm hello`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    llvm-gcc -shared -Wl,-soname,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @mac
  Scenario: Build a shared library from one *.c and *.h file using llvm-gcc
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake -f Rakefile.llvm hello`
    Then the output should contain:
    """
    llvm-gcc -H -fPIC -I. -c hello.c -o ./hello.o
    llvm-gcc -H -fPIC -I. -c main.c -o ./main.o
    llvm-gcc -shared -Wl,-install_name,libhello.so.0 -o ./libhello.so.0.1.0 ./hello.o
    ln -s libhello.so.0.1.0 libhello.so
    ln -s libhello.so.0.1.0 libhello.so.0
    llvm-gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @linux
  Scenario: Build a shared library from multiple *.c and *.h files in subcirectories
    Given the current project directory is "examples/shared_library_subdirs"
    When I successfully run `rake hello`
    Then the output should contain:
    """
    gcc -H -Werror -Wall -Wextra -fPIC -Iincludes -Isources -c sources/hello.c -o objects/hello.o
    gcc -H -fPIC -Iincludes -Isources -c sources/main.c -o ./main.o
    gcc -shared -Wl,-soname,libhello.so.0 -o objects/libhello.so.0.1.0 objects/hello.o
    ln -s objects/libhello.so.0.1.0 libhello.so
    ln -s objects/libhello.so.0.1.0 libhello.so.0
    gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "objects/libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  @mac
  Scenario: Build a shared library from multiple *.c and *.h files in subcirectories
    Given the current project directory is "examples/shared_library_subdirs"
    When I successfully run `rake hello`
    Then the output should contain:
    """
    gcc -H -Werror -Wall -Wextra -fPIC -Iincludes -Isources -c sources/hello.c -o objects/hello.o
    gcc -H -fPIC -Iincludes -Isources -c sources/main.c -o ./main.o
    gcc -shared -Wl,-install_name,libhello.so.0 -o objects/libhello.so.0.1.0 objects/hello.o
    ln -s objects/libhello.so.0.1.0 libhello.so
    ln -s objects/libhello.so.0.1.0 libhello.so.0
    gcc -o ./hello ./main.o -L. -lhello
    """
    And a file named "objects/libhello.so.0.1.0" should exist
    And a file named "hello" should exist
    And I successfully run `./hello`
    And the output should contain:
    """
    Hello, PaperHouse!
    """

  Scenario: Clean
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello`
    When I successfully run `rake clean`
    Then a file named "hello.o" should not exist
    And a file named "main.o" should not exist
    And a file named ".libhello.depends" should exist
    And a file named ".hello.depends" should exist
    And a file named "libhello.so.0.1.0" should exist
    And a file named "hello" should exist

  Scenario: Clobber
    Given the current project directory is "examples/shared_library"
    When I successfully run `rake hello`
    When I successfully run `rake clobber`
    Then a file named "hello.o" should not exist
    And a file named "main.o" should not exist
    And a file named ".libhello.depends" should not exist
    And a file named ".hello.depends" should not exist
    And a file named "libhello.so.0.1.0" should not exist
    And a file named "hello" should not exist
