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

    event Heal(
        address indexed healed,
        address indexed healer,
        uint256         amount
    );

    event Hit(
        address indexed defender,
        address indexed attacker,
        uint256         amount,
        uint256         reward
    );

    event Died(address indexed who);

    constructor(string _name, Element _element) public {
      name = _name;
      element = _element;
    }

    modifier onlyActive() {
      require(active, "Critter not active");
        _;
    }

    function attack(Critter _target) public onlyOwner onlyActive {
        _target.receive(element);
        active = false;
    }

    function selfHeal(uint256 _amount) public onlyOwner onlyActive {
        require(power >= _amount, "Not enough power");

        power = power.sub(_amount);
        heal(this, _amount);

        active = false;
    }

    function receive(Element _attackElement) external returns (uint256 _reward) {
        require(hitPoints > 0, "Critter not alive");

        active = true;
        power += 3;

        if (element == _attackElement) {
            hitPoints.add(10);
            return 2;
        }

        // 00, 01 -> 0
        // 10, 11 -> 1
        if ((uint(element) >> 1) == (uint(_attackElement) >> 1)) {
            damage(25);
            return 10;
        }

        damage(10);
        return 5;
    }

    function heal(address _healer, uint256 _amount) internal {
        hitPoints = hitPoints.add(_amount);
        emit Heal(this, _healer, _amount);
    }

    function damage(address _attacker, uint256 _amount) internal {
        event Hit(this, attacker, _amount);

        if (_amount < hitPoints) {
            hitPoints -= _amount;
        } else {
            hitPoints = 0;
            active = false;
            emit Died(this);
        }
    }
}
