var Shop = artifacts.require("./Shop");

module.exports = function(deployer) {
    deployer.deploy(Shop)
  //   .then(()=>{
  //     return SupplyChainStorage.deployed();
  //  });
  };