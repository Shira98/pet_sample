var Shop = artifacts.require("./Shop");
 
var Customer = artifacts.require("./Customer");

// module.exports = function(deployer) {
//     deployer.deploy(Shop)
//     .then(()=>{
//        deployer.deploy(Customer, );
//    });
//   };

module.exports = function(deployer) {
  deployer.deploy(Shop).then(function(){
        return deployer.deploy(Customer, Shop.address)
});
};  
 
