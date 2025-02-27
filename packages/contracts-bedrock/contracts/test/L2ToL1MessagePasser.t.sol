//SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import { CommonTest } from "./CommonTest.t.sol";
import { L2ToL1MessagePasser } from "../L2/L2ToL1MessagePasser.sol";
import { Hashing } from "../libraries/Hashing.sol";

contract L2ToL1MessagePasserTest is CommonTest {
    L2ToL1MessagePasser messagePasser;

    event WithdrawalInitiated(
        uint256 indexed nonce,
        address indexed sender,
        address indexed target,
        uint256 value,
        uint256 gasLimit,
        bytes data
    );

    event WithdrawerBalanceBurnt(uint256 indexed amount);

    function setUp() virtual public {
        messagePasser = new L2ToL1MessagePasser();
    }

    // Test: initiateWithdrawal should emit the correct log when called by a contract
    function test_initiateWithdrawal_fromContract() external {
        vm.expectEmit(true, true, true, true);
        emit WithdrawalInitiated(
            messagePasser.nonce(),
            address(this),
            address(4),
            100,
            64000,
            hex""
        );

        vm.deal(address(this), 2**64);
        messagePasser.initiateWithdrawal{ value: 100 }(
            address(4),
            64000,
            hex""
        );
    }

    // Test: initiateWithdrawal should emit the correct log when called by an EOA
    function test_initiateWithdrawal_fromEOA() external {
        uint256 gasLimit = 64000;
        address target = address(4);
        uint256 value = 100;
        bytes memory data = hex"ff";
        uint256 nonce = messagePasser.nonce();

        // EOA emulation
        vm.prank(alice, alice);
        vm.deal(alice, 2**64);
        vm.expectEmit(true, true, true, true);
        emit WithdrawalInitiated(
            nonce,
            alice,
            target,
            value,
            gasLimit,
            data
        );

        bytes32 withdrawalHash = Hashing.hashWithdrawal(
            nonce,
            alice,
            target,
            value,
            gasLimit,
            data
        );

        messagePasser.initiateWithdrawal{ value: value }(
            target,
            gasLimit,
            data
        );

        // the sent messages mapping is filled
        assertEq(messagePasser.sentMessages(withdrawalHash), true);
        // the nonce increments
        assertEq(nonce + 1, messagePasser.nonce());
    }

    // Test: burn should destroy the ETH held in the contract
    function test_burn() external {
        messagePasser.initiateWithdrawal{ value: NON_ZERO_VALUE }(
            NON_ZERO_ADDRESS,
            NON_ZERO_GASLIMIT,
            NON_ZERO_DATA
        );

        assertEq(address(messagePasser).balance, NON_ZERO_VALUE);
        vm.expectEmit(true, false, false, false);
        emit WithdrawerBalanceBurnt(NON_ZERO_VALUE);
        messagePasser.burn();

        // The Withdrawer should have no balance
        assertEq(address(messagePasser).balance, 0);
    }
}
