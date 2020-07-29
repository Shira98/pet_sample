// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;


import "./Shop.sol";
import "./Ownable.sol";

contract Customer{

    address owner;

    //@dev modifer allowing only owner of contract
    modifier onlyOwner(){
        require(msg.sender == owner,   "not working");
        _;
    }

    //@dev temporary cart struct
    struct WineCart{
        uint wineId;
        uint wineQuantity;
        uint winePrice;
        uint subTotal;
    }

    Shop shop;
    mapping(address => WineCart[]) public cart;
    // mapping(address => uint) public subtotal;

    //Variable's declaration -
    uint public cartItemCount;

    //@dev Event triggers after new item added to cart
    event addItemToCartEvent(string name, uint price, uint sub, uint cartItemsCount);
    event checkoutEvent (string name, string userAddress, uint subtotal,  uint payment, uint deliveryDate);

    function addToCart(uint _wine_item_id) public  returns (bool){
        if(cartItemCount<5)
        {
            cartItemCount++;
            WineCart memory newCartItem;

            (string memory wineName, uint winePrice, uint wineQty) = shop.getWines(_wine_item_id);

            newCartItem.wineId = _wine_item_id;
            newCartItem.winePrice = winePrice;
            newCartItem.wineQuantity = wineQty;
            newCartItem.subTotal += newCartItem.winePrice;
            cart[msg.sender].push(newCartItem);

            emit addItemToCartEvent(wineName, winePrice, cart[msg.sender][cartItemCount].subTotal, cartItemCount);

            return true;
        }
        else
            return false;
    }

     //Customer cart delete item func.

    //Can't we associate the user's details with his wallet address?
    function CheckOutCart(string memory _user_name, string memory _user_address, uint _payment_method) public {
        //Add new_subtotal = discount() to this function ~
        uint delivery_date = shop.getDeliveryDate();
        emit checkoutEvent(_user_name, _user_address, cart[msg.sender][cartItemCount].subTotal, _payment_method, delivery_date);
        //Remove the wine from shop by ID ~
    }

    function emptyCart() public {
        delete cart[msg.sender];
    }
}