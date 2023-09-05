// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SomtoT {
    // state variables
    string public name = "SomtoT";
    string public symbol = "ST";
    uint8 public  decimals = 18;
    uint256 public  totalSupply;
    /*
    I think the owner variable should be privtae because
    no function outside of the contact will make use of it.
    */
    address private owner;
    mapping (address => uint256) private users; // alias: "BalanceOf" ... 
    mapping (address => mapping (address => uint256)) public allowance;
    // Event(s) definition(s)
    event Transfer(address indexed indexedFrom, address indexed indexedTo, uint256 value);
    event Approval(address indexed indexedOwner, address indexed indexedSpender, uint256 value);
    event Burn(address indexed indexedOwner, uint256 amount);
    // 
    constructor() {
        owner = msg.sender;
        _mint(msg.sender, 100e18);
    }
    /*
    function allow()...
    this function allows me to determine the amount of funds a
    particular address can transfer unbehalf of another.
    In other words, it assigns value to the ALLOWANCE MAP at line 18.
    Its more like the approve function but more dynamic.
    */ 
    function allow(address addressFrom, address addressTO, uint256 allowed ) public  {
        allowance[addressFrom][addressTO] = allowed;
    }
    /*
    function balanceOf()
    it allows an instance of the contract to store and return
    the balance of the provided address(user)
    */
    function balanceOf( address _user) public view returns (uint256) {
        // code(s)
        return users[_user];
    }
    /*
    function _mint()...
    I think its reponsible for liquidity or creating of value.
    */
    function _mint(address address_to, uint256 amount ) public  {
        // Snaity check
        require(address_to != address(0), "MUST NOT BE A ZERO ADDRESS.");
        require(msg.sender == owner, "YOU ARE NOT AUTHORIZED TO MINT THIS TOKEN");
        // code(s)
        totalSupply += amount;
        users[address_to] += amount;
        emit Transfer(msg.sender, address_to, amount);
    }
    /*
    function burn()..
    Enables the owner of the contract to burn a certain
    amount of token from the total supply.
    */
    function burn(address _owner, uint256 amount) public  {
        // Snaity check: [Using the require statement ensure that only the owner can call the _burn function]
        require(_owner == owner, "NOT AUTHORIZED.");
        // code(s)
        users[_owner] -= amount;
        totalSupply -= amount;
        emit Burn(_owner, amount);
    }
    /*
    function _transfer()...
    this is a boiler plate to reduce CODE DUPLICATION
    */
    function _transfer(address addressFrom, address addressTo, uint256 amount) private returns (bool) {
        // local variables 
        uint256 currentBalance = users[addressFrom];
        // Snaity check
        require(addressTo != address(0), "ERC20 TRANSFER TO ADDRESS 0.");
        require(amount <= currentBalance, "INSUFFICIENT BALANCE.");
        // code(s)
        users[addressFrom] -= amount; // currentAllowance -= amount; ... doeas not work
        users[addressTo] += amount;
        emit Transfer(addressFrom, addressTo, amount);
        return true;
    }
    /*
    function transfer()...
    this function allows a certian amount of token
    to be transferred from the total supply to an addres
    */
    function transfer(address recipient, uint256  amount) external returns (bool){
        return _transfer(msg.sender, recipient, amount);
    }
    /*
    function transferFrom()...
    this function allows a certian amount of token 
    to be transferred from one address to another
    */
    function transferFrom(address addressFrom, address addressTo, uint256 amount) external returns (bool){
        // local variables 
        uint256 currentAllowance = allowance[addressFrom][msg.sender];
        // Snaity check
        require(currentAllowance >= amount, "ERC20 TRANSFER AMOUNT NOT EXCEED ALLOWANCE."); 
        require(addressTo != address(0), "ERC20 TRANSFER TO ADDRES 0.");
        // code(s)
        currentAllowance = currentAllowance - amount;
        emit Approval(addressFrom, addressTo, amount);
        return _transfer(addressFrom, addressTo, amount);
    }
    /*
    function approve()...
    allows an address to approve another address to spend
    a certain amount of tokens on its behal
    */
    function approve(address addressSpender, uint256 value) external returns (bool) {
        // Snaity check
        require(addressSpender != address(0), "INVALID ADDRESS!");
        // code(s)
        allowance[msg.sender][addressSpender];
        emit Approval(msg.sender, addressSpender, value);
        return true;
    }
}