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
- *Unsigned* Integers: `uint` value must >= 0 (non-negative)
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
  - State variables (variables declared outside of functions) are by default `storage` and written permanently to the blockchain
- *Memory* variables are *temporary*, and are *erased* between external function calls to your contract.
  -  variables declared inside functions are `memory` and will disappear when the function call ends.
- Think of it like your computer's hard disk vs RAM.
```
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}
```

### Chapter 8: Zombie DNA
- The formula for calculating a new zombie's DNA is simple: the average between the feeding zombie's DNA and the target's DNA.
```
function testDnaSplicing() public {
  uint zombieDna = 2222222222222222;
  uint targetDna = 4444444444444444;
  uint newZombieDna = (zombieDna + targetDna) / 2;
  // ^ will be equal to 3333333333333333
}
```

### Chapter 9: More on Function Visibility
- In addition to `public` and `private`, Solidity has two more types of visibility for functions: `internal` and `external`.
- `internal` is the same as `private`, *except that it's also accessible to contracts that inherit from this contract.*
- `external` is similar to `public`, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract.
```
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string memory) {
    baconSandwichesEaten++;
    // We can call this here because it's internal
    eat();
  }
}
```

### Chapter 10: What Do Zombies Eat? - CryptoKitties
- `interface` needed for our contract to talk to another contract on the blockchain that we don't own.
- E.g.,
```
contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}
```
- define an **interface** of the `LuckyNumber` contract:
```
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}
```
  - only declare functions we want to interact with (e.g., `getNum`)
  - end function with (;) not defining function bodies ({and})
- looks like a contract skeleton, so compiler knows it's an interface
- in Solidity you can return more than one value from a function.

### Chapter 11: Using an Interface
- defined the interface as:
```
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}
```
- use it in a contract as follows:
```
contract MyContract {
  address NumberInterfaceAddress = 0xab38...
  // ^ The address of the FavoriteNumber contract on Ethereum
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
  // Now `numberContract` is pointing to the other contract

  function someFunction() public {
    // Now we can call `getNum` from that contract:
    uint num = numberContract.getNum(msg.sender);
    // ...and do something with `num` here
  }
}
```
- In this way, your contract can interact with any other contract on the Ethereum blockchain, as long they expose those functions as `public` or `external`.

### Chapter 12: Handling Multiple Return Values
```
function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // This is how you do multiple assignment:
  (a, b, c) = multipleReturns();
}

// Or if we only cared about one of the values:
function getLastReturnValue() external {
  uint c;
  // We can just leave the other fields blank:
  (,,c) = multipleReturns();
}
```

### Chapter 13: Bonus: Kitty Genes
- If statements in Solidity look just like JavaScript.
```
function eatBLT(string memory sandwich) public {
  // Remember with strings, we have to compare their keccak256 hashes
  // to check equality
  if (keccak256(abi.encodePacked(sandwich)) == keccak256(abi.encodePacked("BLT"))) {
    eat();
  }
}
```

### Chapter 14: Wrapping It Up
- Once we're ready to deploy this contract to Ethereum we'll just compile and deploy **ZombieFeeding** — since this contract is our final contract that inherits from **ZombieFactory**, and has access to all the public methods in both contracts.
- Interacting with our deployed contract using JavaScript and web3.js
```
var abi = /* abi generated by the compiler */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = /* our contract address on Ethereum after deploying */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// Assuming we have our zombie's ID and the kitty ID we want to attack
let zombieId = 1;
let kittyId = 1;

// To get the CryptoKitty's image, we need to query their web API. This
// information isn't stored on the blockchain, just their webserver.
// If everything was stored on a blockchain, we wouldn't have to worry
// about the server going down, them changing their API, or the company
// blocking us from loading their assets if they don't like our zombie game ;)
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // do something to display the image
})

// When the user clicks on a kitty:
$(".kittyImage").click(function(e) {
  // Call our contract's `feedOnKitty` method
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// Listen for a NewZombie event from our contract so we can display it:
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // This function will display the zombie, like in lesson 1:
  generateZombie(result.zombieId, result.name, result.dna)
})
```
