// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowance;

    string private _name; // 名称
    string private _symbol; // 代号
    uint256 private _totalSupply; // 代币总供给
    uint8 public _decimals; // 小数位数

    /**
     * @dev 构造函数，初始化代币名称、代号、总供给、小数位数
     */
    constructor(string memory name_, string memory symbol_, uint256 totalSupply_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        _decimals = decimals_;
    }

    /**
     * @dev 返回代币总供给
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev 返回账户`account`所持有的代币数.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev 代币转账逻辑。调用方扣除amount数量代币，接收方增加相应代币 
     */
    function transfer(address recipient, uint amount) external override returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    /**
     * @dev 返回`owner`账户授权给`spender`账户的额度，默认为0。
     *
     * 当{approve} 或 {transferFrom} 被调用时，`allowance`会改变.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowance[owner][spender];
    }

    /**
     * @dev 代币授权逻辑。被授权方spender可以支配授权方的amount数量的代币
     *
     * spender可以是EOA账户，也可以是合约账户
     */
    function approve(address spender, uint amount) external override returns (bool) {
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * @dev 授权转账逻辑，被授权方将授权方sender的amount数量的代币转账给接收方recipient 
    */
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        _allowance[sender][msg.sender] -= amount;
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    /**
     * @dev 铸造代币函数，不在IERC20标准中。
     */
    function mint(uint amount) external {
        _balances[msg.sender] += amount;
        _totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    /**
     * @dev 销毁代币函数，不在IERC20标准中。
     */
    function burn(uint amount) external {
        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}