# CryptoZombies

CryptoZombies is a free, open source, interactive code school that teaches you to build games on Ethereum. The course is designed for beginners to Solidity and starts off with the absolute basics. So if you've never coded with Solidity before, don't worry — we'll walk you through step by step.

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


### Chapter 5: Structs
- structs allow you to create more complicated data types that have multiple properties.

### Chapter 6: Arrays
```
// Array with a fixed length of 2 elements:
uint[2] fixedArray;
// another fixed Array, can contain 5 strings:
string[5] stringArray;
// a dynamic Array - has no fixed size, can keep growing:
uint[] dynamicArray;
```
- Public Arrays
`Person[] public people;`

### Chapter 7: Function Declarations
```
function eatHamburgers(string memory _name, uint _amount) public {

}
```
- Two ways to pass an argument to a Solidity function:
  - By **value**, which means that the Solidity compiler *creates a new copy* of the parameter's value and *passes it to your function*. This allows your function to modify the value without worrying that the value of the initial parameter gets changed.
  - By **reference**, which means that your function is called with a reference to the original variable. Thus, if your function changes the value of the variable it receives, the *value of the original variable gets changed.*
-  It's convention (but not required) to start function parameter variable names with an underscore _ in order to differentiate them from global variables.

### Chapter 8: Working with Structs and Arrays
```
// create a New Person:
Person satoshi = Person(172, "Satoshi");

// Add that person to the Array:
people.push(satoshi);
```
`people.push(Person(16, "Vitalik"));`

### Chapter 9: Private / Public Functions
- In Solidity, functions are public by default. This means anyone (or any other contract) can call your contract's function and execute its code.
- Mark your functions as `private` by default, and then only make `public` the functions you want to expose to the world.
- As you can see, we use the keyword private after the function name. And as with function parameters, it's convention to start private function names with an underscore (_).

```
uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}
```
