// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TarotCard is ERC721 {
	
bool isNotMinted = true;
	mapping(address => uint8[]) public addr2tokenIds;

	constructor() ERC721("Tarot","TAROT") {

	}

	function mint() public {
		require(isNotMinted, "should mint only once");
		for (uint8 i = 0; i < 26; i++) {
			addr2tokenIds[msg.sender].push(i);
			_mint(msg.sender, i);
		}
		isNotMinted = false;
	}

	function getOwnedTokenIds() public view returns(uint8[] memory) {
		return addr2tokenIds[msg.sender];
	}

	function transfer(address to, uint8 tokenId) public {
		uint8[] storage tokenIds = addr2tokenIds[msg.sender];
		
		bool isExist = false;
		uint i = 0;
		while(i < tokenIds.length) {
			if (tokenIds[i] == tokenId) {
				isExist = true;
				break;
			}
			i += 1;
		}
		require(isExist, "account should contains tokenId");

		for(uint j = i; j < tokenIds.length - 1; j++) {
			tokenIds[j] = tokenIds[j+1];
		}
		tokenIds.pop();			
		addr2tokenIds[to].push(tokenId);
		transferFrom(msg.sender, to, tokenId);
	}

	function burn(uint8 tokenId) public {
		 require(ERC721.ownerOf(tokenId) == msg.sender, "ERC721: transfer of token that is not own");

		uint8[] storage tokenIds = addr2tokenIds[msg.sender];

		bool isExist = false;
		uint i = 0;
		while(i < tokenIds.length) {
			if (tokenIds[i] == tokenId) {
				isExist = true;
				break;
			}
			i += 1;
		}
		require(isExist, "account should contains tokenId");

		for(uint j = i; j < tokenIds.length - 1; j++) {
			tokenIds[j] = tokenIds[j+1];
		}
		tokenIds.pop();	
		_burn(tokenId);
	}
}