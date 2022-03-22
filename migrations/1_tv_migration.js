const TradingVault = artifacts.require('TradingVault');
const MockWETH = artifacts.require('MockWETH');

module.exports = async function (deployer) {
  const admin = deployer.networks[deployer.network].from;
  await deployer.deploy(MockWETH, admin);

  await deployer.deploy(TradingVault, "MockWETH.address");
};
