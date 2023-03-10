// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {DudezViaBitmap} from "src/DudezViaBitmap.sol";

contract DudezViaBitmapTest is DSTest {
    DudezViaBitmap deployedDudez;
    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    address bob = address(0x1);
    address jon = address(0x2);
    address sal = address(0x3);

    error CanOnlyMintOnce();

    function setUp() public {
        deployedDudez = new DudezViaBitmap();
    }

    function testDeploy() public {
        new DudezViaBitmap();
    }

    function testMint() public {
        vm.startPrank(bob);
        deployedDudez.mint();
    }

    function testMintWithoutCounter() public {
        vm.startPrank(bob);
        deployedDudez.mintWithoutCounter();
    }

    function testMint2() public {
        vm.startPrank(jon);
        deployedDudez.mint();
    }

    function testMint3() public {
        vm.startPrank(sal);
        deployedDudez.mint();
    }

    function testMint4() public {
        vm.startPrank(sal);
        deployedDudez.mint();
        vm.expectRevert(CanOnlyMintOnce.selector);
        deployedDudez.mint();
    }

    function testGetCount() public {
        vm.startPrank(bob);
        deployedDudez.mintWithoutCounter();
        vm.stopPrank();
        vm.startPrank(jon);
        deployedDudez.mintWithoutCounter();
        vm.stopPrank();
        vm.startPrank(sal);
        deployedDudez.mintWithoutCounter();
        assert(deployedDudez.getMinted() == 3);
    }
}
