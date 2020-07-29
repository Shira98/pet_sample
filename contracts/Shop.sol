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

    //@dev temporary invoice struct
    // struct Invoice{
    //     uint invoiceid;
    //     uint cartid;
    //     uint discount;
    //     uint total_price;
    // }

    //Mapping -
    mapping (uint => WineList) public wines;

    //Variable definitions -
    uint public wineCount;

    constructor() public {
        owner = msg.sender;
        //@dev List of Wines available in the shop:
        addWineItem("Duckhorn Merlot", "Napa Valley Three Palms Vineyard",1 wei,1000);
        addWineItem("K Syrah ", "Walla Walla Valley Powerline Estate",2 wei,1500);
        addWineItem("Château Coutet", "Barsac",2 wei,2000);
        addWineItem("Casanova di Neri", "Brunello di Montalcino",1 wei,2000);
    }

    function addWineItem(string memory _name, string memory _des, uint _price, uint _qty) private returns (bool){
        if(wineCount < 10){
            wineCount++;
            wines[wineCount] = WineList(wineCount, _name, _des, _price, _qty);
            return true;
        }
        else{
            return false;
        }
    }

    function getWines(uint _wineIndex) public view returns (string memory, uint ,uint){
        if(_wineIndex < 10){
            WineList storage temp = wines[_wineIndex];
            return (temp.vin_Name, temp.vin_Price, temp.inv_Qty);
        }
    }

    function getDeliveryDate() public pure returns (uint){
        //Date returned based on product availability.
        return 7;
    }

    function decrementQuantity(uint _wineIndex) private {
        wines[_wineIndex].inv_Qty--;
    }
}