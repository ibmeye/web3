相关代码已经推送到我的github项目中，在code目录下的同名子目录中，结合代码来阅读文章，更加容易理解。

https://github.com/ibmeye/web3

### （一）NFT理论部分

**(1)同质化代币和非同质化代币的区别**

`NFT`，全称为`Non-Fungible Token`，非同质化货币。

了解非同质化货币之前，首先需要了解同质化货币和非同质化货币的区别。

| 语言         | 框架                                                         |
| ------------ | ------------------------------------------------------------ |
| 同质化货币   | 功能就类似我们现实生活中使用的1元人民币，虽然票面编号是不同的，但是价值是相同的。 |
| 非同质化货币 | 功能则类似于我们现实生活中的车牌，不同车牌的编号是不同的，价值也不同，而且相差的价格十分大。 |

非同质化代币的产生是区块链的一种落地方式。

非同质化代币对于促进艺术品，尤其是虚拟艺术品的流通，提供了极大的支持。

典型的非同质化代币的应用项目：加密猫：[CryptoKitties | Catalogue](https://www.cryptokitties.co/catalogue/latest-cattributes)

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/20221231115043.png"/>



理论上来讲，区块链在同质化货币`ERC-20`的基础上，保证其发行的所有代币的编号唯一，就可以创造了非同质化货币。

### （二）创建普通的前端项目

构建方式在文章《一、WEB3集成开发环境构建》中已经解释了，可以直接使用那个项目中的代码作为基础模板来进行改造。

https://github.com/ibmeye/web3

下面在上述项目的基础上进一步开发，引入通用的NFT合约。

### （三）引入通用的NFT合约

针对非同质化货币，以太坊组织制定了`ERC-721`接口规范。

虽然官方没有给出`ERC-721`接口规范的实现，但是网上已经有很多实现好的通用实现供我们参考或者直接继承。

比如，下面这个开源项目就提供了`ERC-20`和`ERC-721`合约接口的通用实现。

访问地址：https://github.com/OpenZeppelin/openzeppelin-contracts

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/20221231115416.png"/>

该项目已经将实现好的合约打包上传到`npm`仓库中，我们可以通过下面的命令来给项目引入依赖：

```shell
npm install @openzeppelin/contracts --save
```

使用下面的命令创建卡罗牌合约`TarotCard.sol`

```shell
truffle create contract TarotCard
```

合约创建好的样子如下：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TarotCard {
  constructor() public {
  }
}
```

引入`ERC-721`的通用实现，并让`TarotCard`合约继承已经实现好的`ERC-721`合约。

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TarotCard  is ERC721 {
	constructor() ERC721("Tarot","TAROT") {
	}
}
```

到目前为止，我们已经创建好了一个`NFT`合约，合约的名称为`Tarot`，合约的代币为`TAROT`。在该`NFT`合约的基础上，我们可以编写业务代码来构建领域相关的`NFT`合约。

### （四）创建NFT项目的合约部分

哔哩哔哩·卡罗牌项目

该项目将发布以下26个卡罗牌收藏品，每张卡罗牌都有编号，分别为`0~25`。

每张卡片只能被一个账户拥有，且该账户有权将该将收藏品转移到其他账户，或者销毁它。



![image-20211225145838742](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/c1c60cad85a05827e059334aba81fe8a.png)

**(1)项目合约**

> 关于`ERC-721`的通用实现是如何工作的，可以参考第6章，剖析`ERC-721`的通用实现。

任何一个合约中的代币都有三个生命阶段，下面分别编写这三个阶段的代码。

1. 铸币，为了测试方便，合约中的铸币接口直接将所有收藏品先发给第一个调用该合约函数的账户。

```solidity
...
contract TarotCard  is ERC721 {
	uint8[] public tarots;
	
	constructor() ERC721("Tarot","TAROT") {
	}
	function mint() public {
		require(tarots.length <= 0, "only can mint once");
		for (uint8 i = 0; i < 26; i++) {
			tarots.push(i);
			_mint(msg.sender, i);
		}
	}
}
...
```

通过下面的命令来创建测试文件`tarot_card.js`：

```shell
truffle create test TarotCard
```

![image-20211225143355319](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/a41e952108ed6067a4432b99274a1f35.png)

下面是测试文件的基础内容，该内容可以用来测试`TarotCard`合约是否正常发布。

注意配置migrations，以及启动参数要配置为可以输入的内容。

```javascript
const TarotCard = artifacts.require("TarotCard");

contract("TarotCard", function (/* accounts */) {
  it("should assert true", async function () {
    await TarotCard.deployed();
    return assert.isTrue(true);
  });
});
```

下面，补充测试内容来验证铸币函数的正确性。

```java
const TarotCard = artifacts.require("TarotCard");

contract("TarotCard", function (/* accounts */) {
  // 测试合约是否正常发布
  it("should assert true", async function () {
    await TarotCard.deployed();
    return assert.isTrue(true);
  });

  // 测试合约铸币函数逻辑是否正确
  it("verify mint call", async function () {
    await TarotCard.deployed();
    return assert.isTrue(true);
  });
});
```

2. 转账

流通简单来说就是转让收藏品。

```solidity
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
```

3. 销毁

销毁，很简单，永久的将收藏删除。

```solidity
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
```

### （五）创建NFT项目的界面部分

首先给项目安装`element-ui for vue3`，使用下面的指令：

```shell
npm install element-plus --save
```

为了方便演示，我们将上述三个阶段的按钮全部放在了用户操作页面上，分别为铸币，转让(流通)和销毁。

- 阶段1：铸币

在真实环境中，铸币操作大多都在合约初始化的时候完成。

在用户操作界面放置铸币按钮，仅仅是为了方便展示。该按钮可以将塔罗牌中全套收藏品ID一次性赋予第一个调用该合约铸币方法(`mint`)的账户，让该账户拥有全部NFT收藏品。

![image-20211230212118910](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/2fa507cac72e403c9fbcc8034dd0b3cb.png)



- 阶段2：流通

在真实环境中，流通操作或者叫做转账操作是最常见的操作，通过该操作，一个账户中的`NFT`收藏品可以转移到另一个账户中。

在用户操作界面中，用户需要提供转让地址和转让NFT收藏品的ID，才能点击转让按钮来转让该`NFT`收藏品。

![image-20211230212051566](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/45c33398048a79f3159574d35cd9d5fa.png)

- 阶段3：销毁

在真实环境中，销毁操作也是可能会发生的，如果用户真的想让某个NFT收藏品消失的话。

在用户操作界面中，用户需要提供销毁NFT收藏品的ID，才能点击销毁按钮来销毁该`NFT`收藏品。

销毁操作在合约中已经完成，但是按钮并没有添加，有兴趣的可以添加一下，试一试效果。

#### 项目总结

项目继承了ERC721的实现合约，在其基础上增加了我们本身的铸币，转账和销毁合约，非常方便的实现了NFT的一个应用程序。NFT作为区块链的落地方式，其核心的价值就是，虚拟资产一旦被转移后，归属权就会本质变更，而不需要任何人证明。
