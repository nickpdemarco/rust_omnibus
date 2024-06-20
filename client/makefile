# Requires `cargo` and `cbindgen`.
# https://doc.rust-lang.org/cargo/getting-started/installation.html
# https://github.com/mozilla/cbindgen?tab=readme-ov-file#quick-start

.PHONY: all
all: out/client

out/client: main.cpp out/omni/target/debug/libomni.a
	clang++ main.cpp -I out/omni/include -L out/omni/target/debug/ -l omni -o out/client

out/omni/target/debug/libomni.a: ../liba/src/lib.rs ../libb/src/lib.rs out/omni/Cargo.toml
	cargo build --manifest-path out/omni/Cargo.toml

out/omni/Cargo.toml: omnibus.sh
	./omnibus.sh ../liba ../libb

.PHONY: clean
clean:
	rm -rf out
