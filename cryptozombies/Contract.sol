// 1. Enter solidity version here
pragma solidity >=0.5.0 <0.6.0;

// 2. Create contract here
contract ZombieFactory {
  // This will be stored permanently in the blockchain
  uint dnaDigits = 16;
  // Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.
  uint dnaModulus = 10 ** dnaDigits;
}
