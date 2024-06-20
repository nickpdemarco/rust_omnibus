#!/bin/bash

# Prototype: Synthesize a rust omnibus library 

# Canonicalize all of the path arguments relative to this script.
set -- $(for arg in "$@"; do realpath "$arg"; done)

mkdir -p out/
cargo init --lib out/omni || exit 0 # Hacky attempt at idempotency.
pushd out/omni

# Erase the default contents of lib.rs
: > src/lib.rs

# TODO: Use `cargo rustc -- --crate-type staticlib`?
printf "\n[lib]\ncrate-type = [\"staticlib\"]\n" >> Cargo.toml

for dep_manifest_path in "$@"
do
  echo "Adding $dep_manifest_path"
  # cargo add --path $dep_manifest_path
  # Add the crate as a local dependency and extract the crate name.
  # Note: cargo writes "Added foo..." to stderr.
  ADDED_CRATE=$(cargo add --path $dep_manifest_path 2> >(awk '{print $2}'))
  # Use all public symbols in the added crate, so they aren't stripped.
  printf "pub use ${ADDED_CRATE}::*;\n" >> src/lib.rs
  # Run cbindgen for each crate.
  cbindgen $dep_manifest_path --output ./include/rust/$ADDED_CRATE/bindings.h
done

cargo build 

popd
