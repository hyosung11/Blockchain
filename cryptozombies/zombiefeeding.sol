// 1. Enter solidity version here
pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";


// Create KittyInterface here
contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
    );
}

// Make a contract called ZombieFeeding. This contract should inherit from our ZombieFactory contract.

contract ZombieFeeding is ZombieFactory {

    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;

    // Initialize kittyContract here using `ckAddress` from above
    // change this to just a declaration
    KittyInterface kittyContract;

    // add setKittyContractAddress method here
    function setKittyContractAddress(address _address) external onlyOwner {
      kittyContract = KittyInterface(_address);
    }

    // create a public function called feedAndMultiply that takes two parameters a uint _zombieId and a uint _targetDna; add third parameter
    function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {

        // require statement to verify msg.sender == zombie's owner
        require(msg.sender == zombieToOwner[_zombieId]);

        // declare local Zombie named myZombie == index _zmobieId in our zombies array
        Zombie storage myZombie = zombies[_zombieId];

        // set _targetDna to only take the last 16 digits
        _targetDna = _targetDna % dnaModulus;

        // declare a uint named newDna equal to average of myZombie's DNA and _targetDna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        // add an if statement
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
          newDna = newDna - newDna % 100 + 99;
        }

        // call _createZombie
        _createZombie("NoName", newDna);

        // make a function called feedOnKitty
        function feedOnKitty(uint _zombieId, uint _kittyId) public {

            // declare uint named kittyDna
            uint kittyDna;

            // The function should then call the kittyContract.getKitty function with _kittyId and store genes in kittyDna.

            (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);

            // the function should call feedAndMultiply, and pass it both _zombieId and kittyDna.
            // modify function call and add "kitty" to the end
            feedAndMultiply(_zombieId, kittyDna, "kitty");
        }
    }
}
