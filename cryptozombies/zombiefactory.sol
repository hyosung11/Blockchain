// 1. Enter solidity version here
pragma solidity >=0.5.0 <0.6.0;


// Import the contents of ownable.sol
import "./ownable.sol";


// inherit from Ownable

// 2. Create contract here
contract ZombieFactory is Ownable {

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);

    // This will be stored permanently in the blockchain
    uint dnaDigits = 16;

    // Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.
    uint dnaModulus = 10 ** dnaDigits;

    // declare a uint called cooldownTime = to 1 days
    uint cooldownTime = 1 days;

    // Create a `struct` named `Zombie` with properties: name(a string) and dna (a uint)
    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    // Create a public array of Zombie structs, and name it zombies.
    Zombie[] public zombies;

    // declare mappings here
    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // Create a public function named createZombie. It should take two parameters: _name (a string), and _dna (a uint). Don't forget to pass the first argument by value by using the memory keyword.
    // Change it to a private function.
    // change from private to internal so our other contracts can access it.
    function _createZombie(string memory _name, uint _dna) internal {

        // create a new zombie and add it to the zombies array
        // zombies.push(Zombie(_name, _dna));

        // fire event here
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;

        // update zombieToOwner mapping to store msg.sender under the id
        zombieToOwner[id] = msg.sender;
        // increase ownerZombieCount for this msg.sender
        ownerZombieCount[msg.sender]++;

        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        // require function only gets executed once per user
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
