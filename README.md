# Static Vector

An svec is a static vector (resizeable array) with a static storage backing it,
effectively a stack. Useful for if you don't want allocate memory & your vector
will always be small, but still want to enjoy push / pop / len semantics

## Running tests

```
odin run tests --out:svec-tests
```

## Usage

```go
import svec "svec"

// ...

my_svec = svec.make(int, 4); // Make an svec backed by [4]int
// Similar usage to [dynamic]T:
svec.append(&my_svec, 1);
svec.append(&my_svec, 2);
svec.append(&my_svec, 3);
svec.append(&my_svec, 4);
assert(svec.pop(&my_svec) == 4);
svec.append(&my_svec, 4);
// To index, use .data
assert(my_svec.data[0] == 1);
// To get the len, use .len or svec.len()
assert(my_svec.len == svec.len(my_svec))

// Exceeding the size results in an assertion failure
svec.append(&my_svec, 5); // This is a runtime error

// You append without an assertion with try_append
// This returns false as the svec is already full, nothing is appended
assert(svec.try_append(&my_svec, 5) == false);
svec.pop(&my_svec);
// This now returns true, as we created space with the pop. 5 is appended, and
// data is currently [1, 2, 3, 5].
assert(svec.try_append(&my_svec, 5) == true);
```
