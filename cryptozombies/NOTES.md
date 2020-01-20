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
-  It's convention (but not required) to start function parameter variable names with an underscore (_) in order to differentiate them from global variables.

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

### Chapter 10: More on Functions
- function **return values**
```
string greeting = "What's up dog";

function sayHello() public returns (string memory) {
  return greeting;
}
```
- **view** function (only views data doesn't modify it)
  - `function sayHello() public view returns (string memory) {`
- **pure** function (not even accessing any data in the app, only its function parameters)
  - `function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}`

### Chapter 11: Keccak256 and Typecasting
- Ethereum has the hash function keccak256 built in, which is a version of SHA3.
- A hash function basically maps an input into a random 256-bit hexidecimal number. A slight change in the input will cause a large change in the hash.
-  `keccak256` expects a single parameter of type `bytes`. This means that we have to "pack" any parameters before calling `keccak256`:
- Typecasting: sometimes you need to convert between data types.
```
uint8 a = 5;
uint b = 6;
// throws an error because a * b returns a uint, not uint8:
uint8 c = a * b;
// we have to typecast b as a uint8 to make it work:
uint8 c = a * uint8(b);
```

### Chapter 12: Putting It Together
- We're going to create a public function that takes an input, the zombie's name, and uses the name to create a zombie with random DNA.

### Chapter 13: Events
- Events are a way for your contract to communicate that something happened on the blockchain to your app front-end, which can be 'listening' for certain events and take action when they happen.
```
// declare the event
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;
  // fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}
```

### Chapter 14: Web3.js
- Web3.js: Ethereum JavaScript library to interact with frontend.
- What our javascript then does is take the values generated in zombieDetails above, and use some browser-based javascript magic (we're using Vue.js) to swap out the images and apply CSS filters.

---

## Lesson 2 Overview

### Chapter 2: Mappings and Addresses
- data types: `mapping` and `addresses`
- Addresses: an address is owned by a specific user (or a smart contract).
- Mappings
  - another way to store organized data in Solidity (like `structs` and `arrays`)
  - A mapping is essentially a key-value store for storing and looking up data

```
// For a financial app, storing a uint that holds the user's account balance:
mapping (address => uint) public accountBalance;
// Or could be used to store / lookup usernames based on userId
mapping (uint => string) userIdToName;
```

### Chapter 3: Msg.sender
- In Solidity, there are certain global variables that are available to all functions. One of these is `msg.sender`, which refers to the address of the person (or smart contract) who called the current function.
```
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
  // ^ The syntax for storing data in a mapping is just like with arrays
}

function whatIsMyNumber() public view returns (uint) {
  // Retrieve the value stored in the sender's address
  // Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
}
```

### Chapter 4: Require
- `require` makes it so that the function will throw an error and stop executing if some condition is not true:
```
function sayHiToVitalik(string memory _name) public returns (string memory) {
  // Compares if _name equals "Vitalik". Throws an error and exits if not true.
  // (Side note: Solidity doesn't have native string comparison, so we
  // compare their keccak256 hashes to see if the strings are equal)
  require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));
  // If it's true, proceed with the function:
  return "Hi!";
}
```

### Chapter 5: Inheritance
- `inheritance` allows splitting of code across multiple contracts
- This can be used for logical inheritance (such as with a subclass, a `Cat` is an `Animal`). But it can also be used simply for organizing your code by grouping similar logic together into different contracts.
```
contract Doge {
  function catchphrase() public returns (string memory) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string memory) {
    return "Such Moon BabyDoge";
  }
}
```

### Chapter 6: Import
- When you have multiple files and you want to import one file into another, Solidity uses the `import` keyword:
```
import "./someothercontract.sol";

contract newContract is SomeOtherContract {

}
```

### Chapter 7: Storage vs Memory (Data location)
- In Solidity, there are two locations you can store variables — in `storage` and in `memory`.
- **Storage** refers to variables stored **permanently** on the blockchain.
- *Memory* variables are *temporary*, and are *erased* between external function calls to your contract.
- Think of it like your computer's hard disk vs RAM.
