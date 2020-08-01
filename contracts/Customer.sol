// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "./Shop.sol";
import "./Ownable.sol";

contract Customer is Ownable{

    Shop shop  = new Shop();
    address newCart ;
    uint subtotal;
    //@dev Event triggers after new item added to cart
    event addItemToCartEvent(string name, uint price, uint subtotal, uint cartItemsCount);
    event checkoutEvent (string name, string userAddress, address cart, uint subtotal, uint payment, uint deliveryDate);

    constructor () public {
         newCart = shop.getWineCart(msg.sender);
    }

    uint public cartitemCount;

    function addToCart(uint _cart_item_id) public  returns (bool){
        if(cartitemCount<2){

            cartitemCount++;
            (newCart[], subtotal) = shop.getWineToCart(msg.sender,  newCart, _cart_item_id);

            string memory name = newCart.vin_Name;
            uint price = newCart.vin_Price;

            emit addItemToCartEvent(name,price,subtotal,cartitemCount);
            return true;
        }
        else
            return false;
    }

     //Customer cart delete item


    function CheckOutCart(string memory user_name, string memory userAddress, uint payment_method) public {
        //Add new_subtotal = discount() to this function -
        uint delivery_date = shop.getDeliveryDate();
        emit checkoutEvent (user_name, userAddress, newCart,subtotal, payment_method, delivery_date);
    }

    function emptyCart() public {
        delete newCart;
        subtotal = 0;
    }
}