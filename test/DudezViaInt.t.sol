// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {DudezViaInt} from "src/DudezViaInt.sol";

contract DudezViaIntTest is DSTest {
    DudezViaInt deployedDudez;
    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    address bob = address(0x1);
    address jon = address(0x2);
    address sal = address(0x3);

    error CanOnlyMintOnce();

    function setUp() public {
        deployedDudez = new DudezViaInt();
    }

    function testDeploy() public {
        new DudezViaInt();
    }

    function testMint() public {
        vm.startPrank(bob);
        deployedDudez.mint();
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
        deployedDudez.mint();
        vm.stopPrank();
        vm.startPrank(jon);
        deployedDudez.mint();
        vm.stopPrank();
        vm.startPrank(sal);
        deployedDudez.mint();
        assert(deployedDudez.getMinted() == 3);
    }
}
