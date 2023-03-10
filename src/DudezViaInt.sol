// SPDX-License-Identifier: MIT

import {ERC721A} from "ERC721A/ERC721A.sol";

pragma solidity ^0.8.17;

contract DudezViaInt is ERC721A {

	uint256 minted;
    mapping(address => uint256) userMint;
	error CanOnlyMintOnce();

    constructor() ERC721A("Dudez", "DUDE") {}

	function mint() public payable {
		if (userMint[msg.sender] > 0) revert CanOnlyMintOnce();
		userMint[msg.sender] += 1;
		minted++;
		_mint(msg.sender, 1);
	}

	function getMinted() public view returns(uint256) {
		return minted;
	}
}
