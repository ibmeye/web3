相关代码已经推送到我的github项目中，在code目录下的同名子目录中，结合代码来阅读文章，更加容易理解。

https://github.com/ibmeye/web3

### （一）使用客户端上传图片文件到IPFS

首先，在https://github.com/ipfs/ipfs-desktop/releases中下载IPFS客户端，我下载的是Windows客户端。

IPFS完成安装以后的界面如下：

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/image-20230104193017226.png"/>

点击右边菜单栏的`文件`按钮，即可导入文件，不论是文本文件和是图片文件都是可以的。

我们将一个房屋信息的`json`文件和一个房屋的图片导入到`IPFS`中，并每个文件右边点击三个点，获得`ipfs`分享链接。

<img src="https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/img/20230104194801.png"/>

文本信息`home.json`如下所示，ipfs链接为：https://ipfs.io/ipfs/QmSDWDCZS6j6nfCxcndjaARWSeBVboiFS9kNQbzut4qNxC

图片信息`home.jpg`如下所示，ipfs链接为：https://ipfs.io/ipfs/QmXcdEbSNAdRU2Hxnw4b1nArEKgBbDSkTszo9xJPSStigL

> 由于网关ipfs.io需要翻墙才能访问，所以可能点击链接的时候，无法得到想要的内容。

因此，我们可以在上传后使用本地网管来对应上述两个文件，除了前面的域名不一样，其他都相似。

`home.json`的地址为：http://127.0.0.1:8080/ipfs/QmSDWDCZS6j6nfCxcndjaARWSeBVboiFS9kNQbzut4qNxC

`home.jpg`的地址为：http://127.0.0.1:8080/ipfs/QmXcdEbSNAdRU2Hxnw4b1nArEKgBbDSkTszo9xJPSStigL

在开发过程中，我们完全可以使用本地网关，但是在以后发布智能合约或者制作类似`openSea`的网站的时候，图片的地址必须使用公共网关。
