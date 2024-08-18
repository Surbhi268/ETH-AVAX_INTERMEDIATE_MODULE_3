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
