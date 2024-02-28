// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Mutisig{

    uint8 private _requiredApprovals;
    address[] private _owners;
    
    struct Transaction{
        address _to;
        uint _value;
        bytes _data;
        bool _executed;
        mapping (address => bool) signatures;
    }

    Transaction[] public _transactions;

    function isOwner () public view returns (bool) {
        if(_owners[msg.sender]){
            return true;
        }
        
        return false;
    }


    event TransactionCreated(uint trxId, address to, uint value, bytes data);
    event TransactionSigners(uint trxId, address signer);
    event TransactionComplete(uint trxId, address executer);

    constructor(address[] memory owners, uint8 requiredApprovals){
        
        require(owners.length > 0, "Invalid owners amount");
        require(requiredApprovals > 0 && requiredApprovals <= owners.length, "Invalid number of signers");
        
        _owners = owners;
        _requiredApprovals = requiredApprovals;

    }
}