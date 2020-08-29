const Allowance = artifacts.require("Allowance.sol");
const SharedWallet = artifacts.require("SharedWallet.sol");

module.exports = function (deployer) {
  deployer.deploy(Allowance);
  deployer.deploy(SharedWallet);
};