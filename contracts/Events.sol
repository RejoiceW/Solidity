// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Events {
    // 定义balances映射变量，存储每个地址的持币数量
    mapping(address => uint256) public balances;

    // 定义transfer事件，记录转账地址，接收地址和转账数量
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 定义mint函数，给地址铸造500代币
    function mint(address _address) external {
        balances[_address] += 500;
    }

    // 定义transfer函数，执行转帐逻辑
    function _transfer(address from, address to, uint256 amount) external {
        balances[from] -= amount;
        balances[to] += amount;

        // 释放事件
        emit Transfer(from, to, amount);
    }
}