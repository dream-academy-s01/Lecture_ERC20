// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/ERC20.sol";

contract DreamTokenTest1 is Test {
    ERC20 drm_token;
    address internal constant alice = address(1);
    address internal constant bob = address(2);

    function setUp() public {
        drm_token = new ERC20();
    }
    
    function testName() public {
        assertEq(drm_token.name(), "DREAM");
    }

    function testSymbol() public {
        assertEq(drm_token.symbol(), "DRM");
    }

    function testDecimals() public {
        assertEq(drm_token.decimals(), 18);
    }

    function testTotalSupply() public {
        assertEq(drm_token.totalSupply(), 100 ether);
        assertEq(drm_token.balanceOf(address(this)), 100 ether);
    }

    function testApprove() public {
        drm_token.approve(alice, 10 ether);
        assertEq(drm_token.allowance(address(this), alice), 10 ether);
    }

    function testTransfer() public {
        drm_token.transfer(alice, 1 ether);
        assertEq(drm_token.balanceOf(alice), 1 ether);
        assertEq(drm_token.balanceOf(address(this)), 99 ether);
        assertEq(drm_token.totalSupply(), 100 ether);
    }

    function testFailTransfer() public {
        drm_token.transfer(alice, 1000 ether);
    }

    function testTransferFrom() public {
        drm_token.approve(bob, 10 ether);
        assertEq(drm_token.allowance(address(this), bob), 10 ether);
        vm.prank(bob);
        drm_token.transferFrom(address(this), bob, 10 ether);
        assertEq(drm_token.balanceOf(bob), 10 ether);
        assertEq(drm_token.balanceOf(address(this)), 90 ether);
        assertEq(drm_token.allowance(address(this), bob), 0);
        assertEq(drm_token.totalSupply(), 100 ether);
    }

    function testFailTransferFrom() public {
        drm_token.approve(bob, 10 ether);
        assertEq(drm_token.allowance(address(this), bob), 10 ether);
        vm.prank(bob);
        drm_token.transferFrom(address(this), bob, 100 ether);
    }
}
