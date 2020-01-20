// 1. Enter solidity version here
pragma solidity >=0.5.0 <0.6.0;

import "./zombiefactory.sol";

// Make a contract called ZombieFeeding. This contract should inherit from our ZombieFactory contract.

contract ZombieFeeding is ZombieFactory {

    // create a public function called feedAndMultiply that takes two parameters a uint _zombieId and a uint _targetDna
    function feedAndMultiply(uint _zombieId, uint _targetDna) public {

      // require statement to verify msg.sender == zombie's owner
      require(msg.sender == zombieToOwner[_zombieId]);
      
      // declare local Zombie named myZombie == index _zmobieId in our zombies array
      Zombie storage myZombie = zombies[_zombieId];

    }
}
