// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../src/ERC20.sol";

contract DreamTokenTest2 is ERC20, Test {
    ERC20 drm_token;
    address internal constant alice = address(1);
    address internal constant bob = address(2);

    function setUp() public {
    }
    
    function testMint() public {
        _mint(alice, 100 ether);
        assertEq(totalSupply(), 200 ether);
        assertEq(balanceOf(alice), 100 ether);
    }

    function testBurn() public {
        _mint(alice, 100 ether);
        assertEq(totalSupply(), 200 ether);
        assertEq(balanceOf(alice), 100 ether);
        _burn(alice, 100 ether);
        assertEq(totalSupply(), 100 ether);
        assertEq(balanceOf(alice), 0);
    }

    function testFailMintWAddressZero() public {
        _mint(address(0), 100 ether);
    }

    function testFailburnWAddressZero() public {
        _burn(address(0), 100 ether);
    }

    function testFailBurn() public {
        _mint(alice, 10 ether);
        _burn(alice, 100 ether);
    }
}
