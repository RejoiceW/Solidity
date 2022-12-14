// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./IERC20.sol";

contract Faucet {
    uint256 public amountAllowed = 100; // 每次领100单位代币
    address public tokenContract; // token合约地址
    mapping(address => bool) public requestedAddress; // 记录领取过代币的地址

    // sendToken事件
    event sendToken(address indexed Receiver, uint256 indexed Amount);

    // 部署时设定代币合约
    constructor(address _tokenContract) {
        tokenContract = _tokenContract; // set token contract
    }

    // 用户领取代币函数
    function requestTokens() external {
        require(
            requestedAddress[msg.sender] == false,
            "Can't Request Multiple Times!"
        ); // 每个地址只能领一次
        IERC20 token = IERC20(tokenContract); // 创建IERC20合约对象
        require(
            token.balanceOf(address(this)) >= amountAllowed,
            "Faucet Empty!"
        ); // 水龙头空了

        token.transfer(msg.sender, amountAllowed); // 发送token
        requestedAddress[msg.sender] = true; // 记录领取地址

        emit sendToken(msg.sender, amountAllowed); // 释放SendToken事件
    }
}
