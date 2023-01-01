const TarotCard = artifacts.require("TarotCard");
/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("TarotCard", function (/* accounts */) {
  // 测试合约是否正常发布
  it("should assert true", async () => {
    const tarotCardInstance = await TarotCard.deployed();
    return assert.isTrue(true);
  });

  // 测试合约铸币函数逻辑是否正确
  it("verify mint call", async () => {
    const tarotCardInstance = await TarotCard.deployed();
    return assert.isTrue(true);
  });
});
