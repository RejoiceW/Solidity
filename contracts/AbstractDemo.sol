// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

//抽象合约
abstract contract Base {
    string public name = "Base";
    function getAlias() public pure virtual returns(string memory);
}

contract BaseImpl is Base {
    function getAlias() public pure override returns(string memory){
        return "BaseImpl";
    }
}