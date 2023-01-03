相关代码已经推送到我的github项目中，在code目录下的同名子目录中，结合代码来阅读文章，更加容易理解。

https://github.com/ibmeye/web3

原先的项目使用`truffle`作为构建工具，本项目使用`hardhat`作为构建工具。`hardhat`相对于`truffle`更加方便。

### （一）房产项目描述

### （二）项目启动

**(1)项目技术栈**

- Solidity，用于编写智能合约
- Javascript，用于测试智能合约和编写前端逻辑
- Hardhat，智能合约开发框架，包含EVM模拟器，功能类似于truffle，但更加方便易用，文档：https://hardhat.org/)
- Ethers.js，可以与以太坊模拟器进行交互，文档：https://docs.ethers.io/v5/
- Vue.js，前端框架

**(2)克隆仓库**

可以在根目录下的`code`子目录的`四、使用WEB3开发房产项目`的`init_code`找到本项目的初始模板，找到项目模板后，使用`vscode`打开，然后再在`vscode`中执行后续的命令来初始化项目。

**(3)依赖安装**

在根目录下执行下面的代码：

````shell
$ npm install
````

**(4)执行测试来验证安装效果**

```shell
$ npx hardhat test
```

**(5)启动`Hardhat`实例**

```shell
$ npx hardhat node
```

**(6)执行发布脚本**

```shell
$ npx hardhat run ./scripts/deploy.js --network localhost
```

**(7)启动前端**

```shell
$ npm run start
```

### （三）ERC721

我们已经讨论了如何使用ERC20制作可替换令牌，但如果不是所有令牌都相同呢？这在房地产或收藏品等情况下会出现，其中一些物品因其有用性、稀有性等而价值高于其他物品。

ERC721是表示不可替代代币所有权的标准，即每个代币都是唯一的。

**(1)下面是房产NFT合约，`RealEstate`表示地产公司**

具有两个功能：

1. `mint`用于给消息发送者生成和进行绑定`tokenId`，传入的参数可以是ipfs上的NFT的地址，比如说可以是ipfs地址。
2. `totalSupply`用来获得全部的`token`的数量。

```solidity
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract RealEstate is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Real Estate", "REAL") {}

    function mint(string memory tokenURI) public returns (uint256) {
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
```

**(2)下面这个合约用来质押上面的房产NFT的token，用于销售**

其中`nftAddress`表示的是上面房产`NFT`的合约地址、`seller`表示的是`NFT`的售卖者，它被修饰为`payable`，意味着别人可以付款到这个地址，`inspector`和`lender`后面再说。

```solidity
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Escrow {
    address public nftAddress;
    address payable public seller;
    address public inspector;
    address public lender;

    constructor(
        address _nftAddress,
        address payable _seller,
        address _inspector,
        address _lender
    ) {
        nftAddress = _nftAddress;
        seller = _seller;
        inspector = _inspector;
        lender = _lender;
    }
}

```

下面可以在下面的文件中，编写测试脚本。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20230103200410502.png"/>

具体代码如下：

```javascript
const { expect } = require('chai');
const { ethers } = require('hardhat');

const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe('Escrow', () => {
    it('saves the addresses', async() => {
        // 创建一个房产合约工厂
        const RealEstate = await ethers.getContractFactory('RealEstate');
        // 创建一个房产合约
        realEstate = await RealEstate.deploy();
        // 打印合约地址
        console.log(realEstate.address);
    })
})
```

执行下面指令来进行脚本测试：

```shell
$ npx hardhat test
```

下面是执行结果：

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/20230103200701.png"/>



https://www.youtube.com/watch?v=C4blK6X-D_4&list=PLS5SEs8ZftgUNcUVXtn2KXiE1Ui9B5UrY&index=2&t=3177s
