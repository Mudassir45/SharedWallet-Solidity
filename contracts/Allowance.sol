pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    
    using SafeMath for uint;
    
    mapping(address => uint) public allowance;
    
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }
    
    event AllowanceChanged(address indexed _forWho, address indexed _fromWhom, uint _oldAmount, uint _newAmount);
    
    function isOwner() internal view returns(bool) {
        return owner() == msg.sender;
    }
    
    function setAllowance(address _address, uint _amount) public onlyOwner {
        emit AllowanceChanged(_address, msg.sender, allowance[_address], _amount);
        allowance[_address] = _amount;
    }
    
    function reduceAllowance(address _address, uint _amount) internal {
        emit AllowanceChanged(_address, msg.sender, allowance[_address], allowance[_address].sub(_amount));
        allowance[_address] = allowance[_address].sub(_amount);
    }
}