// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InheritanceContract {
    address public owner;
    address public heir;
    uint256 public lastWithdrawalTime;
    uint256 public constant INHERITANCE_PERIOD = 30 days;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event HeirChanged(address indexed previousHeir, address indexed newHeir);
    event Withdrawal(address indexed withdrawer, uint256 amount);

    constructor(address _heir) {
        owner = msg.sender;
        heir = _heir;
        lastWithdrawalTime = block.timestamp;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyHeir() {
        require(msg.sender == heir, "Only the heir can call this function");
        _;
    }

    function withdraw(uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");
        lastWithdrawalTime = block.timestamp;
        payable(owner).transfer(amount);
        emit Withdrawal(owner, amount);
    }

    function resetInheritancePeriod() external onlyOwner {
        lastWithdrawalTime = block.timestamp;
    }

    function changeHeir(address newHeir) external onlyOwner {
        require(newHeir != address(0), "New heir cannot be the zero address");
        emit HeirChanged(heir, newHeir);
        heir = newHeir;
    }

    function claimOwnership() external onlyHeir {
        require(block.timestamp > lastWithdrawalTime + INHERITANCE_PERIOD, "Inheritance period not passed");
        emit OwnershipTransferred(owner, heir);
        owner = heir;
        heir = address(0);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}
}