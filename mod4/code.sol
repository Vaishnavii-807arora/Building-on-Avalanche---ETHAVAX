// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DegenGamingToken {
    string public name = "Degen Gaming Token";
    string public symbol = "DGT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // Add a mapping to store the cost of each prize
    mapping(uint256 => uint256) public prizeCosts;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Redeem(address indexed from, uint256 prizeId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10**uint256(decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;

        // Set up the cost of each prize (for example)
        prizeCosts[1] = 100 * 10**uint256(decimals); // Prize 1 costs 100 tokens
        prizeCosts[2] = 200 * 10**uint256(decimals); // Prize 2 costs 200 tokens
        prizeCosts[3] = 300 * 10**uint256(decimals); // Prize 3 costs 300 tokens
        // Add more prizes and costs as needed
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Allowance exceeded");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function mint(address to, uint256 value) external onlyOwner {
        require(to != address(0), "Invalid recipient");
        balanceOf[to] += value;
        totalSupply += value;
        emit Mint(to, value);
    }

    function burn(uint256 value) external {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        emit Burn(msg.sender, value);
    }

    function redeem(uint256 prizeId) external payable {
        require(prizeCosts[prizeId] > 0, "Invalid prize ID");
        require(balanceOf[msg.sender] >= prizeCosts[prizeId], "Insufficient balance for redemption");
        
        // Deduct the cost of the prize from the user's account
        balanceOf[msg.sender] -= prizeCosts[prizeId];
        
        // Add the redemption logic here, e.g., providing the in-game item/prize to the user
        // You can emit an event to indicate the successful redemption
        emit Redeem(msg.sender, prizeId);
    }
    
    mapping(uint256 => string) public items;
    
    function addItem(uint256 itemId, string memory itemDetails) public {
        require(
            bytes(items[itemId]).length == 0,
            "Item already exists"
        );

        items[itemId] = itemDetails;
}

function getItemDetails(uint256 itemId) public view returns (string memory) {
        return items[itemId];
}
    
}