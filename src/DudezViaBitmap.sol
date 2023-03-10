// SPDX-License-Identifier: MIT

import {ERC721A} from "ERC721A/ERC721A.sol";
import {LibBitmap} from "solady/utils/LibBitmap.sol";

pragma solidity ^0.8.17;

contract DudezViaBitmap is ERC721A {
    using LibBitmap for LibBitmap.Bitmap;

    uint256 minted;
    LibBitmap.Bitmap userMint;

    error CanOnlyMintOnce();

    constructor() ERC721A("Dudez", "DUDE") {}

    function mint() public payable {
        uint256 addrToBytes = uint256(uint160(msg.sender));
        if (userMint.get(addrToBytes)) revert CanOnlyMintOnce();
        userMint.set(addrToBytes);
        minted++;
        _mint(msg.sender, 1);
    }

    function mintWihtoutCounter() public payable {
        uint256 addrToBytes = uint256(uint160(msg.sender));
        if (userMint.get(addrToBytes)) revert CanOnlyMintOnce();
        userMint.set(addrToBytes);
        _mint(msg.sender, 1);
    }

    function getMinted() public view returns (uint256) {
        return userMint.popCount(0, 4);
    }
}
