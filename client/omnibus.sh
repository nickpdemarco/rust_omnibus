#!/bin/bash

# Prototype: Synthesize a rust omnibus library for linking into a C++ project.
# Usage: omnibus.sh [path-to-rust-crate ...]
# Note: `path-to-rust-crate` is the parent directory of a crate's Cargo.toml.

# Canonicalize all of the path arguments relative to this script.
set -- $(for arg in "$@"; do realpath "$arg"; done)

mkdir -p out/
cargo init --lib out/omni || exit 0 # Hacky attempt at idempotency.
pushd out/omni

# Erase the default contents of lib.rs
: > src/lib.rs

# Set ambiguous_glob_exports to be a hard error.
# This forces top-level symbols in our omnibus passenger crates to use disambiguating naming conventions.
# If the ambiguity refers to a no_mangle symbol, this will cause a linker error, anyway.
printf "#[deny(ambiguous_glob_reexports)]\n" >> src/lib.rs

# TODO: Use `cargo rustc -- --crate-type staticlib`?
printf "\n[lib]\ncrate-type = [\"staticlib\"]\n" >> Cargo.toml

for dep_manifest_path in "$@"
do
  METADATA=$(cargo metadata --no-deps --manifest-path $dep_manifest_path/Cargo.toml)
  CRATE_NAME=$(printf %s $METADATA | jq --raw-output ".packages.[0].name")
  echo "Adding $CRATE_NAME @ $dep_manifest_path"
  cargo add --path $dep_manifest_path
  # Use all public symbols in the added crate, so they aren't stripped.
  printf "pub use ${CRATE_NAME}::*;\n" >> src/lib.rs
  # Run cbindgen for each crate.
  cbindgen $dep_manifest_path --output ./include/rust/$CRATE_NAME/bindings.h
done

cargo build 

popd
