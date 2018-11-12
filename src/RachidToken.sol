pragma solidity ^0.4.10;

import {ERC20} from './ERC20.sol';

contract RachidToken is ERC20 {

  string private _name;
  string private _symbol;
  uint8 private _decimals;
  uint256 private _totalSupply;

  mapping (address => uint256) private balances;
  mapping (address => mapping (address => uint256)) private allowed;

  constructor() public {
    _name = "Rachid Token";
    _symbol = "RAC";
    _decimals = 0;
    _totalSupply = 100000000;
    balances[msg.sender] = _totalSupply;
  }

  function name() public view returns(string) {
    return _name;
  }

  function symbol() public view returns(string) {
    return _symbol;
  }

  function decimals() public view returns(uint8) {
    return _decimals;
  }

  function totalSupply() public view returns(uint256) {
    return _totalSupply;
  }

  function balanceOf(address who) public view returns (uint256) {
    return balances[who];
  }

  function transfer(address to, uint256 value) public returns (bool) {
    require(to != address(0));
    require(value <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender] - value;
    balances[to] = balances[to] + value;
    emit Transfer(msg.sender, to, value);
    return true;
  }

  function allowance(address owner, address spender) public view returns (uint256) {
    return allowed[owner][spender];
  }

  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    require(to != address(0));
    require(value <= balances[from]);
    require(value <= allowed[from][msg.sender]);

    balances[from] = balances[from] - value;
    balances[to] = balances[to] - value;
    allowed[from][msg.sender] = allowed[from][msg.sender] - value;
    emit Transfer(from, to, value);
    return true;
  }

  function approve(address spender, uint256 value) public returns (bool) {
    allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }

  function increaseApproval(address spender, uint addedValue) public returns (bool) {
    allowed[msg.sender][spender] = allowed[msg.sender][spender] + addedValue;
    emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
    return true;
  }

  function decreaseApproval(address spender, uint subtractedValue) public returns (bool) {
    uint oldValue = allowed[msg.sender][spender];
    if (subtractedValue > oldValue) {
      allowed[msg.sender][spender] = 0;
    } else {
      allowed[msg.sender][spender] = oldValue - subtractedValue;
    }
    emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
    return true;
  }

}
