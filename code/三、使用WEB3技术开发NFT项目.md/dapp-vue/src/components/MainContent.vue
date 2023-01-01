<template>
  <el-container>
    <el-container>
      <el-header>
        <span class="bilibili-text">哔哩哔哩</span>
        <span class="dot-text">·</span>
        <span class="tarot-text">塔罗牌</span>
        <span class="account-text">账户:{{isAccountAvaiable?accounts[0]:'未登录'}}</span>
      </el-header>
      <el-main>
        <el-row type="flex" class="transfer-area">
            <el-input placeholder="目标账户：" v-model="targetAccount" class="transfer-input"></el-input>
            <el-input placeholder="资产编号：" v-model="tokenId" class="transfer-input"></el-input>
            <el-button type="primary" @click="mint">铸造</el-button>
            <el-button type="primary" @click="transfer">转让</el-button>
        </el-row>
        <div v-if="isAccountAvaiable">
          <div style="text-align:center; display: inline-block;" v-for="(nft,index) in nfts" :key="index">
            <div class="img-wrapper">
              <img class="card-img" :src="'https://muzhi-picgo.oss-cn-beijing.aliyuncs.com/' + +nft + '.webp'" />
              <el-button type="warning" size="small" @click="burn">销毁</el-button>
            </div>
          </div>
        </div>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Color from '../../../build/contracts/TarotCard.json';
import Web3 from "web3";

export default {
  props: {
    msg: String,
  },
  data() {
    return {
      accounts: [],
      nfts:[],
      contract: null,
      tokenId: '',
      targetAccount: ''
    };
  },
  computed: {
    isAccountAvaiable() {
      return !(this.accounts == null || this.accounts == undefined || this.accounts.length == 0)
    }
  },
  methods: {
    async loadBlockChainData() {
      await this.loadWeb3();
      await this.loadAccounts();
      const networkId = await window.web3.eth.net.getId()
      const networkData = Color.networks[networkId]
      if (networkData) {
        const abi = Color.abi
        const address = networkData.address
        this.contract = await new window.web3.eth.Contract(abi, address)
        console.log(this.contract)
        window.contract = this.contract;
        await this.loadAllNfts();
      } else {
        window.alert('Smart contract not deployed to detected network')
      }
    },
    async refresh() {
      await this.loadAccounts();
      await this.loadAllNfts();
    },
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
    async loadAccounts() {
      this.accounts = await window.web3.eth.getAccounts();
    },
    async loadAllNfts() {
      this.nfts = await this.contract.methods.getOwnedTokenIds().call({from: `${this.accounts[0]}`});
    },
    mint() {
      this.contract.methods.mint().send({from: `${this.accounts[0]}`}).on('confirmation', function(confirmationNumber, receipt) {
        console.log(confirmationNumber);
        console.log(receipt);
      }).on('error', function(error) {
        console.log(error);
      });
    },
    async transfer() {
      if (this.tokenId && this.targetAccount) {
        console.log(this.tokenId)
        console.log(this.targetAccount)
        await this.contract.methods.transfer(`${this.targetAccount}`, `${this.tokenId}`).send({from: `${this.accounts[0]}`});
        await this.loadAllNfts();
      }
    },
    async burn() {
      if (this.tokenId && this.targetAccount) {
        await this.contract.methods.burn(`${this.targetAccount}`, `${this.tokenId}`).send({from: `${this.accounts[0]}`});
      }
    }
  },
  beforeMount() {
    this.loadBlockChainData();
  },
};
</script>

<style scoped>
.el-header {
  background-color: #fed800;
  color: #333;
  line-height: 60px;
  text-align: left; 
  font-size: 12px;
}

.el-aside {
  color: #333;
}

.el-main {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items:center;
}

.transfer-area {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items:center;
  flex-wrap: wrap;
}

.transfer-input {
  width: 350px;
  margin-right: 20px;
}

.bilibili-text {
  font-size: 20px;
  font-weight: bold;
  color: black;
}

.dot-text {
  font-size: 20px;
  font-weight: bold;
  color: red;
}

.tarot-text {
  font-size: 20px;
  font-weight: bold;
  color: white;
}

.card-img {
  width: 200px;
  margin: 30px;
  margin-bottom: 10px;
}

.account-text {
  float: right;
  font-size: 14px;
}

.img-wrapper {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items:center;
  flex-wrap: wrap;
}
</style>
