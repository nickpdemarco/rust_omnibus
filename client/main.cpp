#include <iostream>

#include <rust/liba/bindings.h>
#include <rust/libb/bindings.h>

int main() {
  std::cout << "The answer is " << subtract(40, 2) + add(2, 2) << '\n';
  if (a_rust_rand() != b_rust_rand()) {
    std::cout << "Ok: Different\n";
  } else {
    std::cout << "Neat!\n";
  }
  return 0;
}
