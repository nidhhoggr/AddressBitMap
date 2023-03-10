// SPDX-License-Identifier: MIT

import {ERC721A} from "ERC721A/ERC721A.sol";

pragma solidity ^0.8.17;

contract DudezViaBool is ERC721A {

	uint256 minted;
    mapping(address => bool) userMint;
	error CanOnlyMintOnce();

    constructor() ERC721A("Dudez", "DUDE") {}

	function mint() public payable {
		if (userMint[msg.sender]) revert CanOnlyMintOnce();
		userMint[msg.sender] = true;
		minted++;
		_mint(msg.sender, 1);
	}

	function getMinted() public view returns(uint256) {
		return minted;
	}
}
