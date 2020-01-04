package svec_tests

import svec ".."
import "core:fmt"

test_append :: proc() {
  my_svec := svec.make(int, 4);
  assert(svec.try_append(&my_svec, 1));
  assert(svec.try_append(&my_svec, 2));
  assert(svec.try_append(&my_svec, 3));
  assert(svec.try_append(&my_svec, 4));
  assert(my_svec.data[0] == 1);
  assert(my_svec.data[1] == 2);
  assert(my_svec.data[2] == 3);
  assert(my_svec.data[3] == 4);
  assert(!svec.try_append(&my_svec, 1));
}

test_pop :: proc() {
  my_svec := svec.make(int, 4);
  assert(svec.try_append(&my_svec, 1));
  assert(svec.try_append(&my_svec, 2));
  assert(svec.try_append(&my_svec, 3));
  assert(svec.try_append(&my_svec, 4));
  assert(my_svec.len == 4);
  assert(svec.pop(&my_svec) == 4);
  assert(my_svec.len == 3);
  assert(svec.pop(&my_svec) == 3);
  assert(svec.pop(&my_svec) == 2);
  assert(svec.pop(&my_svec) == 1);
  assert(my_svec.len == 0);
  assert(svec.pop(&my_svec) == 0);
  assert(my_svec.len == 0);
}

test_len :: proc() {
  my_svec := svec.make(int, 4);
  assert(svec.try_append(&my_svec, 1));
  assert(svec.len(my_svec) == 1);
  assert(svec.try_append(&my_svec, 2));
  assert(svec.len(my_svec) == 2);
  assert(svec.try_append(&my_svec, 3));
  assert(svec.len(my_svec) == 3);
  assert(svec.try_append(&my_svec, 4));
  assert(svec.len(my_svec) == 4);
}

main :: proc() {
  fmt.println("Testing append");
  test_append();
  fmt.println("Testing pop");
  test_pop();
  fmt.println("Testing len");
  test_len();
}
