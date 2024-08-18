# ETH-AVAX_INTERMEDIATE_MODULE_3
In this module we have been asked that contract owner should be able to mint tokens to a provided address and any user should be able to burn and transfer tokens.

## Description

"I created a smart contract to develop my own ERC20 token and deployed it using [Remix]. This contract includes essential functionalities such as minting tokens, burning tokens, and transferring them between addresses. The contract owner can mint new tokens to any specified address, while any user has the ability to burn or transfer tokens as needed. The deployment and interaction were successfully tested, and a walk-through video has been prepared to demonstrate these features."
- Vedio walkthrough
  
  [https://www.loom.com/share/675abbd2a9e54a72aa169875866df8c0?sid=f471155a-ae70-4934-8b1e-91a1ef0e0a3d]
## Getting Started
![image](https://github.com/user-attachments/assets/36396a74-c2f4-46f9-8ffa-9d4ac8cf92f4)

![image](https://github.com/user-attachments/assets/d17d739e-1915-4502-b31e-985128eb771f)

![image](https://github.com/user-attachments/assets/df4c9d2f-0d64-4735-b1a0-da66265236b3)

 Code Walk-through vedio link - 
 
### CODE

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SocialGaming is ERC20 {
    address public SurbhiPriya;

    modifier onlySurbhiPriya() {
        require(
            msg.sender == SurbhiPriya,
            "Only the contract Owner can Call this Function"
        );
        _;
    }

    constructor(uint _tokenForMe) ERC20("SurbhiPriya", "SPA") {
        _mint(msg.sender,_tokenForMe);
        SurbhiPriya = msg.sender;
    }

    function mintTokenForOwner(uint256 amount) external payable onlySurbhiPriya {
        _mint(SurbhiPriya, amount);
    }


     function buyToken(uint256 amount) external payable {
        uint valueToPay = amount * 100;
        require(msg.value >= valueToPay, "You didn't payed enough");
        (bool msgRes, ) = payable(msg.sender).call{
            value: msg.value - valueToPay
        }("");
        require(msgRes);
        _mint(msg.sender, amount);
    }

    function buyTokenForOther(address _otherAddress, uint amount) external payable {
        uint valueToPay = amount * 10;
        require(msg.value >= valueToPay, "You didn't payed enough");
        (bool msgRes, ) = payable(msg.sender).call{
            value: msg.value - valueToPay
        }("");
        require(msgRes);
        _mint(_otherAddress, amount);
    }

    function BurnYourToken(uint256 amount) external {
        require(amount <= balanceOf(msg.sender),"You don't have enough Tokens to Burn");
        _burn(msg.sender, amount);
    }

    function seeYourBalance() external view returns (uint _balance) {
        _balance = balanceOf(msg.sender);
    }

    function transferToOtherAccounts(address _recepient, uint256 amount) external {
        require(amount <= balanceOf(msg.sender),"You don't have enough tokens to transfer");
        transfer(_recepient, amount);
    }


    receive() external payable {}
}

### Program explanation
- Contract Overview: This smart contract creates a custom ERC20 token named "SurbhiPriya" with the symbol "SPA". It allows minting, burning, and transferring of tokens.

- Contract Owner (SurbhiPriya): The contract owner is the person who deploys the contract. Only this person (referred to as "SurbhiPriya") has special privileges.

- Minting Tokens for Yourself: The owner can mint new tokens for themselves .

- Minting Tokens for Others: The owner can mint tokens for other addresses by paying the same fee (amount * 10 units).
Excess payment is refunded.

- When a other user wants to mint tokens for himself then he/she has to pay token_amount*100 units .

- Burning Tokens: Any user can burn (permanently destroy) their tokens, reducing the total supply.
  
- Checking Balance: Users can check how many tokens they own.
  
- Transferring Tokens: Users can transfer their tokens to any other address, as long as they have enough balance.

## Authors
Surbhi Priya

Mail - psurbhi237@gmail.com

### License
This project is licensed under the MIT License .
