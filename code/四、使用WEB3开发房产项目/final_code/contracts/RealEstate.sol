//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RealEstate is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Real Estate", "REAL") {}

    function awardItem(string memory tokenURI) public returns (uint256) {
        uint256 newItemId = _tokenIds.current();

        // 用于给消息发送者绑定tokenId
        _mint(msg.sender, newItemId);
        
        // 用于后续根据tokenId来获得tokenURI，tokenURI可以是ipfs的地址
        _setTokenURI(newItemId, tokenURI);

        _tokenIds.increment();
        
        return newItemId;
    }

    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }
}
