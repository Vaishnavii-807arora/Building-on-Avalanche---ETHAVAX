# Degen Gaming Token (DGT) Smart Contract
The Degen Gaming Token (DGT) is an ERC-20 compliant token smart contract designed for a gaming platform. This smart contract allows users to transfer tokens, approve other addresses to spend their tokens on their behalf, mint new tokens (only allowed by the contract owner), burn tokens to decrease the total supply, and redeem tokens to claim in-game prizes.

## Overview
* Name: Degen Gaming Token
+ Symbol: DGT
- Decimals: 18 (Tokens are divisible by 10^18)
* Total Supply: The initial supply is set during contract deployment.
## Contract Owner
The contract owner has special privileges, such as the ability to mint new tokens and execute functions with the onlyOwner modifier, limiting access to specific functionalities.

## ERC-20 Functions
The contract implements the standard ERC-20 functions, which allow users to:

* transfer: Send tokens from one address to another.
+ approve: Allow a third-party address to spend a specific amount of tokens on behalf of the sender.
- transferFrom: Transfer tokens on behalf of a user who has approved the spender.

## Minting and Burning
The owner of the contract can create new tokens by calling the mint function, increasing the total supply. Additionally, users can burn their tokens to reduce the total supply through the burn function.

## Prizes and Redemption
The contract includes the concept of in-game prizes that users can redeem using their DGT tokens. Each prize has a unique identifier, and the cost of each prize is stored in the prizeCosts mapping. Users can use their tokens to redeem prizes by calling the redeem function with the appropriate prizeId. The specific in-game item/prize redemption logic should be implemented externally and triggered within the redeem function.

## Item Management
The contract also provides basic functionality to manage in-game items. The contract owner can add new items and their corresponding details using the addItem function. Users can retrieve the details of an item by calling the getItemDetails function with the itemId.





