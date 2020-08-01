// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;

import "./Store.sol";

contract Customer{

    address customer;
    Store store;

    constructor(address _storeContractAddress) public {
        customer = msg.sender;
        store = Store(_storeContractAddress);

    }

    struct ItemCart {
        uint itemId;
        uint itemQuantity;
        uint itemPrice;
        uint subTotal;
    }

    mapping(address =>  ItemCart[] ) public cart;

    mapping(address => uint) public cartItemCount;
    mapping(address => uint) public cartSubTotal;

    function addToCart(uint _item_id, uint _item_qty) public payable {

        require(_item_qty > 0, "Item quantity should be greater than 0!");

        (uint itemPrice, uint itemQuantity) = store.getItems(_item_id);

        require(_item_qty <= itemQuantity, "Not enough items in the store!");

        cartItemCount[customer]++;
        ItemCart memory newCartItem;
        newCartItem.itemId = _item_id;
        newCartItem.itemPrice = itemPrice;
        newCartItem.itemQuantity = _item_qty;
        newCartItem.subTotal += newCartItem.itemPrice * newCartItem.itemQuantity;
        cartSubTotal[customer] += newCartItem.subTotal;
        cart[customer].push(newCartItem);

    }

    function changeItemQuantity(uint _item_id, uint _item_qty_to_delete) public {
        for(uint i = 0; i<cartItemCount[customer]; i++){
            if(cart[customer][i].itemId == _item_id){

                if(cart[customer][i].itemQuantity == _item_qty_to_delete){
                    //The item will be deleted!
                    revert("You'll be deleting the product! Please click on delete.");
                }

                require(_item_qty_to_delete < cart[customer][i].itemQuantity, "Quantity to delete is more than that of existing item quantity!");

                cartSubTotal[customer] -= cart[customer][i].subTotal;
                cart[customer][i].itemQuantity -= _item_qty_to_delete;
                cart[customer][i].subTotal = cart[customer][i].itemPrice * cart[customer][i].itemQuantity;
                cartSubTotal[customer] += cart[customer][i].subTotal;

            }
        }
    }

    function deleteFromCart(uint _item_id) public {
        for(uint i = 0; i<cartItemCount[customer]; i++){
            if(cart[customer][i].itemId == _item_id){
                cartSubTotal[customer] -= cart[customer][i].subTotal;


                if( i < cartItemCount[customer] - 1) {
                    delete cart[customer][i];
                    for(uint k = i; k<cartItemCount[customer] - 1; k++){
                        cart[customer][k] = cart[customer][k+1];
                    }

                    cart[customer].pop();
                    cartItemCount[customer]--;

                }
                if(i == cartItemCount[customer]-1){
                    delete cart[customer][i];
                    cart[customer].pop();
                    cartItemCount[customer]--;
                }

                if(cartItemCount[customer] == 1)
                    delete cart[customer];
            }
        }
    }

    function CheckOutCart(string memory _user_name, string memory _delivery_address, uint _payment_method) public  {
        //Remove the wine from shop by ID ~
        store.setCustomerDetails(_delivery_address, _user_name, cartSubTotal[customer],_payment_method, customer, cartItemCount[customer]);
        //Date of delivery in the invoice itself.
        emptyCart();
    }

    function emptyCart() private {
        delete cart[customer];
        cartItemCount[customer] = 0;
        cartSubTotal[customer] = 0;
    }

    function getCart() public view returns (ItemCart[] memory){
        return cart[customer];
    }

    function getCartItems(address customerAddress, uint itemIndex) public view returns(uint, uint, uint ){
        return (cart[customerAddress][itemIndex].itemId, cart[customer][itemIndex].itemQuantity, cart[customer][itemIndex].subTotal);
    }
}
