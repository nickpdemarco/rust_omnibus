use rand::Rng;

#[no_mangle]
pub extern fn add(left: usize, right: usize) -> usize {
    left + right
}

#[no_mangle]
pub extern fn a_rust_rand() -> usize {
  let mut rng = rand::thread_rng();
  rng.gen()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
