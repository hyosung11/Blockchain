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

    // create a public function called feedAndMultiply that takes two parameters a uint _zombieId and a uint _targetDna
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {

        // require statement to verify msg.sender == zombie's owner
        require(msg.sender == zombieToOwner[_zombieId]);

        // declare local Zombie named myZombie == index _zmobieId in our zombies array
        Zombie storage myZombie = zombies[_zombieId];

        // set _targetDna to only take the last 16 digits
        _targetDna = _targetDna % dnaModulus;

        // declare a uint named newDna equal to average of myZombie's DNA and _targetDna
        uint newDna = (myZombie.dna + _targetDna) / 2;

        // call _createZombie
        _createZombie("NoName", newDna);

    }
}
