//SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/utils/Address.sol";

contract ColoredToken is ERC721 {
    uint256 public immutable maxColor;

    constructor() ERC721("ColoredToken", "COLOR") {
        maxColor = 0xffffff;
    }

    function getColor(uint256 id_) external {
        require(id_ <= maxColor, "CT: no more than 0xffffff");
        require(balanceOf(msg.sender) == 0, "CT: wallet already have color");
        _mint(msg.sender, id_);
    }

    function burnColor(uint256 id_) external {
        require(ownerOf(id_) == msg.sender, "CT: you must own the color");
        _burn(id_);
    }
}
