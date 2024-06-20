# Summary

This project demonstrates a technique for synthesizing a "omnibus" static library from arbitrarily many Rust crates, to mitigate the fact that [it is not possible to link multiple Rust-static-libs into a single C(++) project](https://users.rust-lang.org/t/linking-more-than-one-rustc-compiled-static-libraries-in-a-c-project/89778).

# Usage

Navigate to the `client` directory and run `make`. It expects `cargo` and `cbindgen` to be installed.
