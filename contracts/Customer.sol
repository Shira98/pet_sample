// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
 
pragma experimental ABIEncoderV2;
 
import "./Shop.sol"; 

contract Customer{

    address customer;
    Shop shop;

    //@dev modifer allowing only owner of contract
    constructor(address _shopContractAddress) public {
        customer = msg.sender;
        shop = Shop(_shopContractAddress);
    }

    //@dev temporary cart struct
    struct WineCart{
        uint wineId;
        uint wineQuantity;
        uint winePrice;
        uint subTotal;
    }
 
    mapping(address => WineCart[]) public cart; 

    //Variable's declaration -
    mapping(address => uint) public cartItemCount; 
 
    function addToCart(uint _wine_item_id) public payable { 
        cartItemCount[customer]++;
        WineCart memory newCartItem;

        (uint winePrice, uint wineQty) = shop.getWines(_wine_item_id);

        newCartItem.wineId = _wine_item_id;
        newCartItem.winePrice = winePrice;
        newCartItem.wineQuantity = wineQty;
        newCartItem.subTotal += newCartItem.winePrice;
        cart[customer].push(newCartItem);  
    }

     //Customer cart delete item func.
 
    // function CheckOutCart(string memory _user_name, string memory _user_address, uint _payment_method) public  {
    //     //Add new_subtotal = discount() to this function ~
    //     uint delivery_date = shop.getDeliveryDate();
    //     //Remove the wine from shop by ID ~
    // }

    function emptyCart() public {
        delete cart[customer];  
        cartItemCount[customer] = 0;
    }
    
    function getCart() public view returns (WineCart[] memory){
        return cart[customer];
    }
}
 