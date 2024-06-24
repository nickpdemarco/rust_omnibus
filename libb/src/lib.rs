use rand::Rng;

#[no_mangle]
pub extern fn subtract(left: usize, right: usize) -> usize {
    left - right
}

#[no_mangle]
pub extern fn b_rust_rand() -> usize {
  let mut rng = rand::thread_rng();
  rng.gen()
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = subtract(2, 2);
        assert_eq!(result, 0);
    }
}
