package svec

import runtime "core:runtime"
import builtin "core:builtin"

/** A static vector of type $T, size $N, which stores elements inline. */
SVec :: struct(T: typeid, N: int) {
  data: [N]T,
  len: int,
}

make :: proc($T: typeid, $N: int) -> SVec(T, N) {
  return SVec(T, N) { len=0 };
}

make_elems :: proc($N: int, vals: ..$T) -> SVec(T, N) {
  ret := make(T, N);
  runtime.mem_copy(&ret.data[0], &vals[0], size_of(T) * builtin.len(vals));
  ret.len = N;
  return ret;
}

/** Returns true on success */
try_append :: proc(svec: ^SVec($T, $N), element: T) -> bool {
  if svec.len == N {
    return false;
  }
  svec.data[svec.len] = element;
  svec.len += 1;
  return true;
}

/** Asserts success */
append :: proc(svec: ^SVec($T, $N), element: T) {
  assert(try_append(svec, element));
}

/** Returns default constructed $T if no elements in array (just like stdlib) */
pop :: proc(svec: ^SVec($T, $N)) -> T {
  if svec.len == 0 { return T {}; }
	res := #no_bounds_check svec.data[svec.len-1];
  svec.len -= 1;
  return res;
}

len :: proc(svec: SVec($T, $N)) -> int {
  return svec.len;
}
