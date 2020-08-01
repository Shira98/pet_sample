var Store = artifacts.require("./Store");
var Customer = artifacts.require("./Customer");
var Shipping = artifacts.require("./Shipping");
 
module.exports = function(deployer) {
  deployer.deploy(Store).then(function(){
        return deployer.deploy(Customer, Store.address)
}).then(function(){
    return deployer.deploy(Shipping, Store.address)
});
};  
