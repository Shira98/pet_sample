// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "./Shop.sol";
import "./Ownable.sol";

contract Customer is Ownable{

    Shop shop;

    //@dev Event triggers after new item added to cart
    event addItemToCartEvent(string name, uint price, uint subtotal, uint cartItemsCount);
    event checkoutEvent (uint subtotal);

    constructor () public {

    }

    function addToCart(uint _cart_item_id) public  returns (bool){
        if(shop.cartitemCount<2){
            shop.cartitemCount++;
            //var newCartItem = cart[_cust];
            shop.WineCart memory newCartItem;
            name = wines[_cart_item_id].vin_Name;
            price = wines[_cart_item_id].vin_Price;
            newCartItem.wineid = _cart_item_id;
            newCartItem.wineprice = wines[_cart_item_id].vin_Price;
            subtotal[msg.sender] += newCartItem.wineprice;
            cart[msg.sender].push(newCartItem);

            emit addItemToCartEvent(name,price,subtotal[msg.sender],cartitemCount);

            return true;
        }
        else
            return false;
    }

    function CheckOutCart() public payable {

        //wines[id].inv_Qty--  cart[address][x].
        //require(msg.value == subtotal[msg.sender]);
        //balance[msg.sender] += msg.value;
    //    subtotal[msg.sender] = 0;

        emit checkoutEvent (subtotal[msg.sender]);
    }

    function emptyCart() public {
        delete cart[msg.sender];
        subtotal[msg.sender] = 0;
    }
}