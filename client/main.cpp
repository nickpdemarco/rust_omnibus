#include <iostream>

#include <rust/liba/bindings.h>
#include <rust/libb/bindings.h>

int main() {
  std::cout << "The answer is " << subtract(40, 2) + add(2, 2) << '\n';
  return 0;
}
