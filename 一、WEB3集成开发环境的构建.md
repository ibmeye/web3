相关代码已经推送到我的github项目中，在code目录下的同名子目录中，结合代码来阅读文章，更加容易理解。

https://github.com/ibmeye/web3

### （一）开发智能合约的集成开发环境

不论哪种方式创建合约，最终的目的就是可以编译成EVM（以太坊虚拟机）能识别的程序。这个和Java也非常相似。不论通过通过什么语言编写`Kotlin`或者是`Java`，只要最后编译出来的`.class`文件可以在符合Java虚拟机规范，就可以在Java虚拟机上运行。

以太坊虚拟机规范定义了它可以识别的程序程序文件的格式，我们在使用`solidity`语言编写合约后，可以借助多种工具生成这种文件，这类文件使用ABI（Application Binary Interface）标识。

为了将solidity转化为这种文件，我们有很多的方式来解决这个问题，第一个就是`remix`，第二个就是借助本地的`truffle`集成开发环境，类似Java中的javac。

- remix是一个网页的集成开发环境，在调试的时候非常方便，但是在进行项目开发的时候比较麻烦，尤其是和本地钱包进行互动的时候。
- truffle是一个本地客户端的开发环境，虽然配置的时候比较麻烦，但是和前端项目结合起来进行开发的时候，很方便，借助于truffle项目框架，智能合约的依赖可以通过npm进行管理，非常方便。

### （二）使用Vscode开发Truffle项目

**(1)**首先安装插件`Truffle for Vs Code`，如下：

![image-20221118161332286](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221118161332286.png)

安装完成插件以后，打开命令`CTRL+SHIFT+P`，输入`Truffle`，然后随便选择一个命令，就可以激活`Truffle`组件，并弹出下面这个窗口来提示需要安装的其他组件，将他们一一点击，全部安装即可。

其中，`node.js`版本要求是v17.0.0以下，可以直接在后面这个链接中下载：https://nodejs.org/dist/v16.9.1/

**(2)**安装插件的依赖项

插件和相关的依赖安装完成后，重新启动`Vscode`，就可以在`Vscode`的开始页面看到下图中框出来的内容，点击这个内容就可以看到刚才安装的Truffle插件的一些主要功能。

![Welcome page](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/welcome-page.png)

**(3)**查看可以可以执行的`truffle`指令

进入后的第一项就是查看`Truffle`可以执行的指令，这些指令用来编译，发布和执行智能合约。这些指令，从`Java`的视角来看，就是使用`java -jar`启动程序，使用`javac`编译程序。

![Walkthrough](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/walkthrough.png)

**(4)**创建新的`Solidity`项目

使用`CTRL+SHIFT+P`打开VSCode的命令窗口，找到并点击`Truffle: New Solidity Project`，然后点击`Create sample project`，来创建一个例子项目，项目的目录如下图所示。

![image-20221119212540249](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119212540249.png)

这个目录中，各个文件夹和文件的都有什么用，后面再说。只需要知道在`contracts`文件夹中放置的就是我们的智能合约。

右键点击智能合约，点击`Build Contracts`，可以编译合约。

点击`Deploy Contracts`，就可以发布合约到本地模拟的区块链网络，以太坊测试网路，或者直接可以发布的主网。

![image-20221119213634911](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119213634911.png)

**（5）**创建本地合约网络

在发布合约的时候，会弹出框让选择希望把合约发布到哪里。如果第一次发布，可以选择第一项`Create a new network`。

![image-20221119214138223](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119214138223.png)

然后，接着弹出框，让选择智能合约发布的位置，这个可以选择`Ganache`，这个网络类型是借助插件`Ganache`创建的本地虚拟的以太坊网络，在这个网络初始化的时候，会创建10个账户，每个账户1000个ETH。

![image-20221119214349842](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119214349842.png)

选择智能合约发布的位置为`Ganache Service`以后，弹出框，让选择发布的类型，这个选择`Local`，表示发布到本地。

![image-20221119214704073](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119214704073.png)

选择发布类型为`Local`以后，需要制定本地以太坊网络的监听端口，一般以太坊网路的监听端口是`8545`，当然，既然是模拟，也可以选择别的端口。

![image-20221119214836661](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119214836661.png)

输入端口以后，点击`Enter`会弹出一个框，让输入`Ganache`模拟出来的网络到底应该是什么名字。如果做过Java，可以把这个理解为不同阶段合约发布的位置。比如，我们在`8545`创建一个虚拟网络来用于发布验证环境的智能合约，就将其命名为`验证环境`。在`8544`创建一个虚拟以太坊网络来用于发布测试环境的智能合约，将其命名为`测试环境`。最后，在`8543`创建一个开发环境，将其命名为`开发环境`。

![image-20221119214913623](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119214913623.png)

输入完成以后，相关插件就会自动创建网络并发布合约到该网络了。

点击`Vscode`左边的`Truffle`图标，就可以在`NETWORKS`中看到已经发布的网路了。

![image-20221119222319532](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221119222319532.png)

### （三）安装浏览器钱包插件

钱包有很多，`Metamusk`是比较好用的一个，可以在`Chrome`或者`Edge`浏览器中安装。

在介绍如何使用之前，我们需要了解的是，钱包和账户的关系，钱包就相当于我们现实中的钱包，账户就相当于我们现实中的银行卡。一个钱包可以放置多个账户，同时，我们可以将一个钱包中的账户放到另一个钱包中，就像把一个钱包中的银行卡放置到另一个钱包中一样。

唯一不同的是，现实中如果银行卡丢失了，可以去银行补办，但是在网络世界中，如果账户丢失了（账户私钥），就无法再次寻找到这个账户了。

下面介绍如何在`Edge`中安装`Metamusk`。

**(1)**打开`Edge`浏览器，点击菜单按钮（右上角，三个点），然后点击扩展，然后再在扩展项中点击`Microsoft Edge`加载项。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120100321937.png" alt="image-20221120100321937"  />

**(2)**搜索`Metamusk`，然后点击后面的获取。

当获取完成后，会自动安装，在Edge浏览器的右上角会弹出相应的插件，并同时打开一个初始化钱包的网页。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120100220254.png" alt="image-20221120100220254"  />

**(3)**钱包初始化步骤

下面这个页面点击开始使用。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120113723253.png" alt="image-20221120113723253"  />

下面这个页面点击创建钱包。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120113919403.png" alt="image-20221120113919403"  />

下面这个页面按照要求输入密码，并点击同意跳转，选择创建。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120114059106.png" alt="image-20221120114059106"  />

下面这个页面记住助记词，这个助记词可以帮助找回钱包，如果钱包里头有账户就可以顺便帮忙找回账户。

由于这个助记词可以完全证明钱包的所有权，所以，这步一般建议使用纸笔进行物理抄录，不要截图放在电脑里头，否则，黑客很容易获得到。

下面的`shrimp fail quality bracker develop split drama can purchase flock spring inform`就是刚才创建的这个钱包的助记词，以后即使电脑爆炸了，拼接这些助记词也可以找到钱包。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120114618418.png" alt="image-20221120114618418"  />

钱包创建成功以后，就可以看到下面这个页面。

最上面那个红框表示的是当前的所在的以太坊网络（以太坊网络有很多种，主网，测试网，本地模拟网）。

中间的红框表示的是账户ID，这个ID是不随着上面的网络切换而切换的，换句话说，账户仅仅表示唯一的ID，创建一次就可以在不同网络中代表一个账户实体，但是不同网络中这个账户实体到底有多少钱，完全由网络来决定。

最下面的一个红框表示的是，**账户**在**以太坊主网**中包含的代币数量。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120114938681.png" alt="image-20221120114938681"  />

到目前为止，我们已经创建了自己的钱包，但是如果钱包在主网的话，除非别人给你转账，否则这个余额一定是0ETH。

**(4)**将钱包连接到本地以太坊网络

在前面的开发中，我们在`Vscode`中使用`Ganache`创建了以太坊的本地虚拟网络。我们可以在`Vscode`中，使用下面的方式启动本地虚拟网络，注意网络IP地址和端口是：`http://127.0.0.1:8543`。

![image-20221120120020720](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120120020720.png)

下面是控制台启动后，打印出来的信息，我截取了几个比较重要的部分。`Available Accounts`表示的是虚拟网络中创建的账户，`Private Keys`表示的是虚拟网络中上面创建的账户的私钥。`Chain Id`表示的是区块链ID，`RPC Listening on 127.0.0.1:8543`表示区块链网络监听的端口是本地的8543端口。使用这些信息，我们可以将钱包连接的本地虚拟化出来的以太坊网络，并且将有钱的账户导入到钱包。

```shell
Available Accounts
==================
(0) 0xd7D07F0a493C1b80EC93204DD574169D1C3CEb6d (1000 ETH)
(1) 0x4F607AA980e0049c53Be08389D4Dd5D88642CC14 (1000 ETH)
(2) 0x4b364104D17cFBfc55bD840ae5aD823841A275DF (1000 ETH)
(3) 0x516e6D27925dfFc8242d5Ee0455618d6e65AB0Ca (1000 ETH)
(4) 0xC8635893787024fF82C4E53b270EcA118Be74d40 (1000 ETH)
(5) 0xD3b4897c87b434B1BB506CE77D4695d8E5e0c881 (1000 ETH)
(6) 0x893FF646F800f5FD7f00112a67ad52B0FC1C2d20 (1000 ETH)
(7) 0xF72f6daaa73b1ff9D72440a1843CcE4AB37760AC (1000 ETH)
(8) 0x4b10a6c3c05eB7B4f482A6dA455226Bb07B6f63F (1000 ETH)
(9) 0x80A6798d8592734c7601C97C13A195288A7D3013 (1000 ETH)

Private Keys
==================
(0) 0xe43ca32bc2b320d6ea15e15946f6a890d94dca74f88292c51d5503d72145e417
(1) 0x7bd02a6a02e911a52792707b474f14c7cc5979293d5f8b5af7e3ea77eef79afc
(2) 0x5a59b2bfb1936de2bdaf97ab1232282c24a2f1fd73bf3b9c2c453503b872f480
(3) 0x2cc17041f787a17ed20b82301278530454e81a7de924fb9398e2a9b8177ed531
(4) 0xdbf632c02faff5d849ac15300d3a6a3c4a3c3aff5e81bdb82baf1087aaa5ee42
(5) 0xc71504f9439bf479c8dc1b3e876b7b0cc00407e9eb7f0864b569528830c28c55
(6) 0x7a772b5d1283078cfacab5cf79c9ca6bf832437de01e976d39ea604586719e9f
(7) 0xdbe8cc53645f1866a1f6028e9306f9d4c09883a90475029d6cdbfe3289d6a84a
(8) 0x08c5d3f86b0881d8f3920ef435c99e651194e9a96ebce20ee15c94e4093c3e8d
(9) 0xdaafbfcd5394ed1b4cac36910bcd183da00f82e75d4f6af540cca58a61d27d33

Chain Id
==================
1337

RPC Listening on 127.0.0.1:8543

net_listening
```

复制上面一个账户的私钥（Private Keys中的一个，比如`0xe43ca32bc2b320d6ea15e15946f6a890d94dca74f88292c51d5503d72145e417`)，然后点击钱包，然后选择导入账户，

![image-20221120133010400](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120133010400.png)

在弹出框中，选择类型为私钥，然后将复制的私钥放入输入框，点击导入。

![image-20221120133202054](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120133202054.png)

导入后，可以立即跳回到前面的主界面，如下图所示，其中账户的地址，就是可用账户（`Avaiable Accounts`）中的第一个账户`(0) 0xd7D07F0a493C1b80EC93204DD574169D1C3CEb6d (1000 ETH)`。

![image-20221120133442079](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120133442079.png)

但是，为什么余额还是`0ETH`呢？是因为我们的网络还是在主网，没有切换到本地的虚拟出来的以太坊网络。

下面，我们将一步一步来演示如何让钱包连接本地虚拟网络。

1. 点击账户，选择设置，

![image-20221120134857510](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120134857510.png)

2. 在设置中选择网络，然后将最下面的`Localhost 8545`修改成如下图所示的内容，这些内容都是在Vscode的Ganache启动的时候答应出来的内容，唯一有区别的就是要在`127.0.0.1:8543`前面加上`http`。

![image-20221120135102677](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120135102677.png)

3. 修改完后，点击保存，账户会立即切换为`localhost 8543`

![image-20221120135424939](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120135424939.png)

4. 此时，如果再回去看刚才导入的账户，就可以发现其余额为1000ETH。

![image-20221120135521387](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120135521387.png)

到此为止，我们已经学会了，在本地虚拟的网络中发布了自己的合约，同时使用`metamask`连接了本地虚拟化的网络，下一步的目标就是制作可以使用钱包来调用智能合约的前端DApp，这也是Web3开发的最后一步。

### （三）使用vue构建可以与钱包交互的项目

**(1)构建web项目**

首先，全局安装`vue-cli`

```shell
npm install -g @vue/cli
vue --version
```

然后，在刚才创建的智能合约项目中，执行下面的指令，初始化`Vue`

```shell
vue create dapp-vue
```

然后，一路点击确认执行下去，直到如下图所示，表示项目成功安装完成。

![image-20221120180538357](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120180538357.png)

使用上面的指令，可以直接启动`vue`的前端项目。此时，目录结构如下图所示，红框标出来的就是使用`vue-cli`创建的`vue`前端项目。

![image-20221120180911335](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120180911335.png)

我们在`dapp-vue/src/components/HelloWorld.vue`中，直接在`methods`对象中添加下面这个函数，然后再在`created`方法中调用`loadWeb3`即可页面加载前，让程序和浏览器中的钱包连接起来。

```solidity
    async loadWeb3() {
      if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
      } else if (window.web3) {
        window.web3 = new Web3(window.web3.currentProvider);
      } else {
        window.alert(
          "Non-Ethereum browser detected. You should consider trying to install MetaMask!"
        );
      }
      window.web3.currentProvider.on('accountsChanged', () => {
        this.refresh();
      })
    },
```

项目中的具体结构如下：

![image-20221120181832364](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120181832364.png)

点击保存后，可以发现有下面两个错误，可以看到是在45行和48行，使用`new Web3(window.ethereum)`的时候报的。这是因为我们没有安装`web3.js`插件，这个插件可以帮助程序和浏览器中的钱包插件进行互动，从而使用钱包插件来调用其连接的以太坊网络中的智能合约。

![image-20221120181802414](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120181802414.png)

使用下面的指令可以安装`web3.js`，然后使用下面的方式在项目中引入`web3.js`。

安装指令：`npm install web3`。

引入方式：

![image-20221120191349596](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120191349596.png)

再次访问网页的时候，如果已经安装了钱包，就会弹出如下图所示的窗口，来询问使用钱包中的哪个账户与网站进行交互，当然，我们需要选择有钱的账户，也就是账户2`Account2`。

![image-20221120191229437](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120191229437.png)

下面我们再来回看一下代码：

```java
    async loadWeb3() {
      if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
      } else if (window.web3) {
        window.web3 = new Web3(window.web3.currentProvider);
      } else {
        window.alert(
          "Non-Ethereum browser detected. You should consider trying to install MetaMask!"
        );
      }
      window.web3.currentProvider.on('accountsChanged', () => {
        this.refresh();
      })
    },
```

首先，我们一旦我们在浏览器安装了插件，浏览器中的原生对象`window`的属性`window.ethereum`和`window.web3.currentProvider`这两个属性就会被初始化，凭借这两个属性指向的代理对象，就可以与钱包进行交互了。

但是上述交互比较底层，为了方便开发者使用，我们可以借助`Web3`这个插件，继续包装钱包提供的代理对象来方便我们使用，因此，会使用`window.web3 = new Web3(window.web3.currentProvider)`这样的内容来进行包装。

最后一句比较有意思，`window.web3.currentProvider.on('accountsChanged', () => { this.refresh(); })`，其中`accountsChanged`是web3插件自己定义的，表示的是钱包账户的切换事件。这句话的意思就是，如果监听到钱包账户切换的话，调用函数`refresh()`做动态刷新。

**(2)使用web3.js调用智能合约的函数**

每次，我们发布的合约都会生成abi文件，这个文件类似于`Java`的字节码，这个字节码不仅可以发布到区块链网络中，还可以在项目中引入，来获得合约的基本信息。

比如，上面的项目中生成的`abi`文件就在根目录下的`build`文件夹中，与智能合约的名字一一对应，如下图中，左边红框标识的内容。

![image-20221120223723395](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120223723395.png)

我们在`vue`项目中，我们可以直接使用import命令来引入这个abi文件，利用这个abi文件，我们可以初始化`web3.js`中的智能合约对象。

![image-20221120223821830](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120223821830.png)

智能合约的初始化方式如下，每步的具体目的可以参看注解。

```solidity
    async loadContract() {
      // 获得网络ID，主网的ID为1，其他的是自定义的
      const networkId = await window.web3.eth.net.getId();
      console.log("networkId=" + networkId);

      // 获得该网络中的合约地址
      const address = await HelloBlockchain.networks[networkId].address;
      console.log("address=" + address);

      // 获得智能合约的abi内容
      const abi = HelloBlockchain.abi;
      console.log("abi=" + abi);

      // 使用合约的网络地址和合约的abi内容，来初始化web3中的合约对象
      this.contract = this.contract = await new window.web3.eth.Contract(abi, address);
      console.log("contract=" + this.contract);
    },
```

下面就是项目启动后，前端控制台打印出来的内容。

![image-20221120223958104](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221120223958104.png)

到此为止，合约对象已经被初始化了，下一步就是使用这个合约对象，通过钱包和以太坊的网络进行交互。

**(3)前端调用智能合约返回数据**

[web3.js - Ethereum JavaScript API — web3.js 1.0.0 documentation (web3js.readthedocs.io)](https://web3js.readthedocs.io/en/v1.7.5/)

目前来说，web3.js有两种调用合约方法的函数，一个是`send`，这个函数表示会修改合约的状态，另一个是`call`，这个函数表示不会修改合约的状态。

1. `call`函数的调用方式

```javascript
let result = myContract.methods.myMethod(123).call(
    {from: '0xde0B295669a9FD93d5F28D9Ec85E40f4cb697BAe'}
	).on('transactionHash', function(hash) {}
    ).on('receipt', function(receipt) {}
    ).on('confirmation', function(confirmationNumber, receipt) {}
    ).on('error', function(error, receipt) {});
```

2. `send`函数的调用方式

```javascript
let result = myContract.methods.myMethod(123).send(
    {from: '0xde0B295669a9FD93d5F28D9Ec85E40f4cb697BAe'}
	).on('transactionHash', function(hash) {}
    ).on('receipt', function(receipt) {}
    ).on('confirmation', function(confirmationNumber, receipt) {}
    ).on('error', function(error, receipt) {});
```

可以看到，除了名字不一样以外，其他都一样。

首先，为了便于测试，我们将`HelloBlockchain.sol`中的内容修改如下：

```solidity
pragma solidity >=0.4.25 <0.9.0;

contract HelloBlockchain {

    string public message;

    constructor(string memory _message) {
        message = _message;
    }

    // call this function to send a request
    function setMessage(string memory _message) public {
        message = _message;
    }

    // call this function to send a response
    function getMessage() public view returns (string memory) {
        return message;
    }
}
```

将上述合约发布以后，我们在前端项目中，再添加一个函数用来载入当前钱包的活跃账户。

因为，观察上面调用智能合约的前端函数（`send`和`call`）都是需要添加一个参数`from: 'xxx`，表示请求合约函数的账户（换句话说，就是花钱的账户）。

```solidity
    async loadAccount() {
      let accounts = await window.web3.eth.getAccounts();
      this.account = accounts[0];
      console.log(this.account);
    }
```

然后，我们就可以使用下面的两个函数来调用合约中的函数了，其中`setMessage`由于需要修改合约的状态，所以，需要使用`send`，而`getMessage`不需要修改合约的状态，所以仅仅需要使用`call`，不修改合约状态的函数都不会花费以太。

```javascript
    async setMessage() {
        console.log(this.account);
        await this.contract.methods.setMessage('Hello World!!').send({from: `${this.account}`});
    },
    async getMessage() {
        let result = await this.contract.methods.getMessage().call({from: `${this.account}`});
        alert(result);
    },
```

我们设置了两个按钮，按钮**设置信息**点击时调用`setMessage`，按钮**获得信息**点击时调用`getMessage`。

![image-20221121200657721](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221121200657721.png)

点击设置信息，钱包就会弹出如下图所示的`MetaMask Norification`，表示现在`测试账号3`正在执行合约`HelloBlockchain`的函数，发起调用的网站是：`http://localhost:8080`，函数的名称是`SET MESSAGE`。此次交易需要的燃料费是`0.0001455`，由于没有转账，所以最终的交易费用是`0.0001455`，如果点击确认，那么这笔交易就会成功，`Hello World!`就会被写入区块链中的`message`状态中。

![image-20221121201759308](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221121201759308.png)

当点击确认，将内容写入到区块链中后，再点击获取信息，就可以直接弹出如下图所示的提示框。这从侧面看出，使用`call`并不会损耗以太。

![image-20221121202015353](https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20221121202015353.png)

到此为止，我们可以创建以太坊虚拟的网络，然后可以使用钱包连接虚拟的网路，也可以使用前端项目调用合约中的函数。