#include "ruby.h"

void
Init_hello() {
  VALUE cHello = rb_define_class( "Hello", rb_cObject );
}
