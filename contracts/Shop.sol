// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;

contract Shop{

    address owner;
    //@dev modifer allowing only owner of contract
    modifier onlyOwner(){
        require(msg.sender == owner,   "not working");
        _;
    }

    //Data Structure -
    //@dev creating a struct for wine inventory
    struct WineList{
        uint vin_ID;
        string vin_Name;
        string vin_Des;
        uint vin_Price;
        uint inv_Qty;
    }
    //@dev temporary cart struct
    struct WineCart{

        uint wineid;
        uint wineprice;
    }

    //@dev temporary invoice struct
    // struct Invoice{
    //     uint invoiceid;
    //     uint cartid;
    //     uint discount;
    //     uint total_price;
    // }

    //Mapping -
    mapping (uint => WineList) public wines;
    mapping(address => WineCart[]) public cart;
    mapping(address => uint) public subtotal;
    mapping(address => uint) balance;

    //Variable definitions -
    uint public wineCount;
    string public name;
    uint public price;

    constructor() public {

        owner = msg.sender;
        //@dev List of Vino available.
        /*Improvement Prop: Using oracles to retrive list of Vino from
        distribution center*/
        addWineItem("Duckhorn Merlot", "Napa Valley Three Palms Vineyard",1 wei,1000);
        addWineItem("K Syrah ", "Walla Walla Valley Powerline Estate",2 wei,1500);
        addWineItem("Château Coutet", "Barsac",2 wei,2000);
        addWineItem("Casanova di Neri", "Brunello di Montalcino",1 wei,2000);
    }

    function getWineCart( address _userAddress ) public  view  returns ( WineCart[] memory){
            // WineCart memory newCartItem;

            // newCartItem.wineid = _cart_item_id;
            // newCartItem.wineprice = wines[_cart_item_id].vin_Price;

            // subtotal[_userAddress] += newCartItem.wineprice;
            // cart[_userAddress].push(newCartItem);
            return cart[_userAddress];
    }

    function getWineToCart( address _userAddress, WineCart memory newCartItem, uint _cart_item_id) public
    returns (WineCart[] memory, uint)
    {
            newCartItem.wineid = _cart_item_id;
            newCartItem.wineprice = wines[_cart_item_id].vin_Price;

            subtotal[_userAddress] += newCartItem.wineprice;
            cart[_userAddress].push(newCartItem);

            return (cart[_userAddress], subtotal[_userAddress]);
    }

    //Functions -
    function  addWineItem(string memory _name, string memory _des, uint _price, uint _qty) private returns (bool){
        if(wineCount < 10){
            wineCount++;
            wines[wineCount] = WineList(wineCount, _name, _des, _price, _qty);
            return true;
        }
        else{
            return false;
        }
    }

    function getDeliveryDate() public pure returns (uint){
        return 7;
    }
}