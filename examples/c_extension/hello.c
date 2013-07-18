#include "ruby.h"

void
Init_hello() {
  VALUE cHelloPaperHouse = rb_define_class( "HelloPaperHouse", rb_cObject );
}
