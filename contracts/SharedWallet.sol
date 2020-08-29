pragma solidity ^0.6.0;

import "./Allowance.sol";

contract SharedWallet is Allowance {
    
    event PaymentRecieved(address indexed _from, uint _amount);
    event PaymentSent(address indexed _beneficiary, uint _amount);
    
    function withdrawPayment(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There are not enough funds stored in the smart contract");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
        emit PaymentSent(_to, _amount);
    }
    
    function renounceOwnership() public override {
        revert("Can not renounce ownership here.");
    }
    
    receive() external payable {
        emit PaymentRecieved(msg.sender, msg.value);        
    }
}