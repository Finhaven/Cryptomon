pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Critter is Ownable {
    using SafeMath for uint256;

    string public name;
    Element private element;

    uint256 public hitPoints = 100;
    uint256 public power = 10;
    bool private active = true;

    enum Element {
        Earth,
        Wind,
        Fire,
        Water
    }

      event .........

    constructor(string _name, Element _element) public {
      name = _name;
      element = _element;
    }

    modifier onlyLiving() {
        require hitPoints > 0;
        _;
    }

    function attack(Critter _enemy) public onlyOwner onlyLiving {
        _enemy.receive(element, power);
    }

    function heal(uint256 _hp) public onlyOwner onlyLiving {
      require(power > _hp);

      power = power.sub(_hp);
      hitPoints = hitPoints.add(_hp);
    }

    function receive(Element _attackElement) external returns (uint256 _reward) {
        if (element == _attackElement) {
            hitPoints.add(10);
            return 2;
        }

        // 00 -> 0
        // 01 -> 0
        // 10 -> 1
        // 11 -> 1
        if ((uint(element) >> 1) == (uint(_attackElement) >> 1)) {
            hitPoints.sub(25);
            return 10;
        }

        hitPoints.sub(10);
        return 5;
    }

}
