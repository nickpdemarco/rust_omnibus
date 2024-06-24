use rand::Rng;

#[no_mangle]
pub extern fn add(left: usize, right: usize) -> usize {
    left + right
}

#[no_mangle]
pub extern fn a_rust_rand() -> usize {
  let ap = std::thread::available_parallelism().inspect(|ap| {
    println!("{} cores", ap);
  }).expect("Unable to get available_parallelism");

  let mut rng = rand::thread_rng();
  let random: usize = rng.gen();
  random + ap.get()
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
