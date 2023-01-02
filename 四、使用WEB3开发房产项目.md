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

https://www.youtube.com/watch?v=C4blK6X-D_4&list=PLS5SEs8ZftgUNcUVXtn2KXiE1Ui9B5UrY&index=2&t=3177s
