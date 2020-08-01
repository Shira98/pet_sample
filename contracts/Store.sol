
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;

import "./Customer.sol";
import "./Shipping.sol";

contract Store{

    Customer customer;
    Shipping shipping;

    enum Status {Created, Released}
    Status status;
    Status constant defaultStatus = Status.Created;

    function setCustomerAndShippingAddress(address _custAdd, address _shippingAdd) public{
        customer = Customer(_custAdd);
        shipping = Shipping(_shippingAdd);
    }


    //Data Structure -
    //@dev creating a struct for item inventory
    struct ItemList{
        uint vin_ID;
        string vin_Name;
        string vin_Des;
        uint vin_Price;
        uint inv_Qty;
    }

    uint public ID;

    //@dev temporary invoice struct
    struct Invoice{
        uint invoiceid;
        uint cartid;
        uint discount;
        uint total_price;
        uint delivery_date;
        uint payment_method;
        string customer_delivery_address;
        string customer_name;
        address shipper_address;
        address customer_address;
        Status status;
    }

    struct ItemCart {
        uint itemId;
        uint itemQuantity;
        uint itemPrice;
        uint subTotal;
    }

    struct UserDetails {
        string delivery_address;
        string user_name;
        uint cartSubtotal;
        address customer_address;
        uint cartItemCount;
        uint payment_method;
    }

    mapping(address => UserDetails) public user;

    mapping(address =>  ItemCart[] ) public cart;

    //Mapping -
    ItemList[100] public items;
    mapping(address =>  Invoice[] )  public invoices;
    address storeStaff;
    uint public itemCount;

    constructor() public {

        storeStaff = msg.sender;

        //@dev List of Items available in the shop:
        addItem("Little Giant Leveler Aluminum ", "18-ft Reach Type 1A - 300 lbs. Capacity Telescoping Multi-Position Ladder",2,1000);
        addItem("Metabo HPT (was Hitachi Power Tools)", "3-in 21-Degree Pneumatic Framing Nails (1000-Count)",2,1500);
        addItem("NETGEAR", "Range Extender 2.4 802.11n Smart Wireless Router",2,2000);
        addItem("DELLA TORRE", "Cementina Black and White 8-in x 8-in Glazed Ceramic Encaustic Tile",1,2000);
        addItem("Kichler", "Angelica 13-in Polished Nickel Modern/Contemporary Incandescent Semi-flush Mount Light",2,1000);
        addItem("Transolid", "Radius 33-in x 22-in Black Single Bowl Drop-In 1-Hole Residential Kitchen Sink All-in-One Kit",2,1500);
        addItem("IRWIN", "All-Purpose SAE 13-Pack Tap and Drill Se",2,2000);
        addItem("Freedom", "Ready-to-Assemble Everton 6-ft H x 6-ft W White Vinyl Flat-Top Vinyl Fence Panel",1,2000);
    }

    function setReleased() public {
        //5sec timer
        status = Status.Released;
    }

    function getStatus() public view returns (Status) {
        return status;
    }

    function getDefaultStatus() public pure returns (uint) {
        return uint(defaultStatus);
    }

    function addItem(string memory _name, string memory _des, uint _price, uint _qty) private {
            itemCount++;
            items[itemCount - 1] = ItemList(itemCount, _name, _des, _price, _qty);
    }
    function getItemCount() public view returns (uint){
        return itemCount;
    }

    function getItems(uint _itemIndex) public view returns (uint ,uint){
        // require(msg.value <= gasleft());
        if(_itemIndex <= itemCount - 1){
            return (items[_itemIndex].vin_Price, items[_itemIndex].inv_Qty);
        }
        revert("Item ID doesn't exist!");
    }

    function setCustomerDetails(string memory delivery_address,string memory user_name, uint cartSubTotal, uint payment,
    address customer_address, uint cartItemCount) public {
        user[customer_address].delivery_address = delivery_address;
        user[customer_address].user_name = user_name;
        user[customer_address].cartSubtotal = cartSubTotal;
        user[customer_address].payment_method = payment;
        user[customer_address].cartItemCount = cartItemCount;
        decrementItemQuantity(user[customer_address],customer_address);
    }

    function decrementItemQuantity(UserDetails memory _userDetails, address _customer_address) public {

        for(uint i = 0; i < _userDetails.cartItemCount; i++){

            (uint itemId, uint itemQuantity, uint subTotal) = customer.getCartItems(_customer_address, i);
            if(items[itemId].inv_Qty > itemQuantity)
                 items[itemId].inv_Qty -= itemQuantity;
            else
                revert("Sorry! Out of Stock");

        }
    }

    function generateInvoice(address _customer_address, address _shipperAddress) public payable{
        Invoice memory newInvoice;
        newInvoice.invoiceid = ID++;
        newInvoice.cartid = user[_customer_address].cartItemCount;
        newInvoice.discount = uint(1)/uint(5);
        newInvoice.total_price = (user[_customer_address].cartSubtotal * uint(4))/uint(5);
        newInvoice.delivery_date = 7;
        newInvoice.payment_method = user[_customer_address].payment_method;
        newInvoice.status = Status.Created;
        newInvoice.customer_address = user[_customer_address].customer_address;
        newInvoice.customer_name = user[_customer_address].user_name;
        newInvoice.customer_delivery_address = user[_customer_address].delivery_address;
        newInvoice.shipper_address = _shipperAddress;
        invoices[_customer_address].push(newInvoice);

        shipping.setReceiptDetails(newInvoice.invoiceid,newInvoice.cartid,newInvoice.total_price,
        newInvoice.payment_method,
        newInvoice.customer_name,newInvoice.customer_delivery_address,newInvoice.shipper_address, _customer_address);
    }

}
