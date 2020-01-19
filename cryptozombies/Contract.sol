// 1. Enter solidity version here
pragma solidity >=0.5.0 <0.6.0;


// 2. Create contract here
contract ZombieFactory {

    // This will be stored permanently in the blockchain
    uint dnaDigits = 16;

    // Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.
    uint dnaModulus = 10 ** dnaDigits;

    // Create a `struct` named `Zombie` with properties: name(a string) and dna (a uint)
    struct Zombie {
        string name;
        uint dna;
    }

    // Create a public array of Zombie structs, and name it zombies.
    Zombie[] public zombies;

    // Create a public function named createZombie. It should take two parameters: _name (a string), and _dna (a uint). Don't forget to pass the first argument by value by using the memory keyword
    function createZombie(string memory _name, uint _dna) public {

        // create a new zombie and add it to the zombies array
        zombies.push(Zombie(_name, _dna));

    }
}
