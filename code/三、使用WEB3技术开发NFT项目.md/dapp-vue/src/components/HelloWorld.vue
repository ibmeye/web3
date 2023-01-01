<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <button v-on:click="setMessage">发送消息</button>
    <button v-on:click="getMessage">获得消息</button>
  </div>
</template>

<script>
import Web3 from 'web3';
import HelloBlockchain from '../../../build/contracts/HelloBlockchain.json';
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },
  mounted() {
    this.loadWeb3();
    this.loadContract();
    this.loadAccount();
  },
  methods: {
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
        location.reload();
      })
    },
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
    async loadAccount() {
      let accounts = await window.web3.eth.getAccounts();
      this.account = accounts[0];
      console.log("账户地址:" + this.account);
    },
    async setMessage() {
        console.log(this.account);
        await this.contract.methods.setMessage('Hello World!!!').send({from: `${this.account}`});
    },
    async getMessage() {
        let result = await this.contract.methods.getMessage().call({from: `${this.account}`});
        alert(result);
    },
    
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
