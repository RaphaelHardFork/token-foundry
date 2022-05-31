// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../ColoredToken.sol";
import "./cheatCodes.sol";

contract ColoredToken_test is DSTest {
    CheatCodes vm = CheatCodes(HEVM_ADDRESS);
    ColoredToken public nft;

    function setUp() public {
        nft = new ColoredToken();
    }

    function testGetColor(uint256 id_) public {
        vm.startPrank(address(1));
        vm.assume(id_ <= 0xffffff);
        nft.getColor(id_);
        assertEq(nft.ownerOf(id_), address(1));
    }

    function testCannotGetColor() public {
        vm.startPrank(address(1));
        vm.expectRevert("CT: no more than 0xffffff");
        nft.getColor(0xffffff1);

        nft.getColor(0xaaffee);
        vm.startPrank(address(2));
        vm.expectRevert("ERC721: token already minted");
        nft.getColor(0xaaffee);

        vm.expectRevert("CT: wallet already have color");
        vm.startPrank(address(1));
        nft.getColor(0xaa5fee);
    }

    function testBurnColor(uint256 id_) public {
        vm.assume(id_ <= 0xffffff);
        vm.startPrank(address(1));
        nft.getColor(id_);
        assertEq(nft.balanceOf(address(1)), 1);
        nft.burnColor(id_);
        assertEq(nft.balanceOf(address(1)), 0);
    }

    function testCannotBurnColor() public {
        vm.startPrank(address(2));
        nft.getColor(0x123456);
        vm.startPrank(address(1));
        nft.getColor(0x112233);
        vm.expectRevert("CT: you must own the color");
        nft.burnColor(0x123456);
    }
}
