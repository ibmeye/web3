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
