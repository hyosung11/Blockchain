# CryptoZombies

- CryptoZombies is a free, open source, interactive code school that teaches you to build games on Ethereum. The course is designed for beginners to Solidity and starts off with the absolute basics. So if you've never coded with Solidity before, don't worry — we'll walk you through step by step.

## Making the Zombie Factory

### Chapter 1: Lesson Overview
- Our factory will maintain a database of all zombies in our army
- Our factory will have a function for creating new zombies
- Each zombie will have a random and unique appearance

### Chapter 2: Contracts
```
pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

}
```

### Chapter 3: State Variables & Integers
- **State variables** are permanently stored in contract storage. This means they're written to the Ethereum blockchain. Think of them like writing to a DB.
- Unsigned Integers: `uint` value must >= 0 (non-negative)
  - In Solidity, `uint` is actually an alias for `uint256`, a 256-bit unsigned integer.
  - You can declare `uints` with less bits — `uint8`, `uint16`, `uint32`, etc.
  - But in general you want to simply use uint except in specific cases.
- `int` data type for signed integers

### Chapter 4: Math Operations
  - same as in most programming languages
  - `uint x = 5 ** 2; // equal to 5^2 = 25`
