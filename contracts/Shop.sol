// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;

contract Shop{
     
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
    WineList[6] public wines;
    address storeStaff;
    uint public wineCount;

    constructor() public { 
        
        storeStaff = msg.sender;
        
        //@dev List of Wines available in the shop:
        addWineItem("Duckhorn Merlot", "Napa Valley Three Palms Vineyard",1,1000);
        addWineItem("K Syrah ", "Walla Walla Valley Powerline Estate",2,1500);
        addWineItem("Château Coutet", "Barsac",2 wei,2000);
        addWineItem("Casanova di Neri", "Brunello di Montalcino",1,2000);
    }

    function addWineItem(string memory _name, string memory _des, uint _price, uint _qty) private { 
            wineCount++;
            wines[wineCount - 1] = WineList(wineCount, _name, _des, _price, _qty);  
    }
    
    function getWineCount() public view returns (uint){
        return wineCount;
    }

    function getWines(uint _wineIndex) public view   returns (uint ,uint){
        // require(msg.value <= gasleft());
        if(_wineIndex <= wineCount - 1){ 
            return (wines[_wineIndex].vin_Price, wines[_wineIndex].inv_Qty);
        }
        revert("Wine ID doesn't exist!");
    }

    function getDeliveryDate() public pure returns (uint){
        //Date returned based on product availability.
        return 7;
    }

    function decrementWineQuantity(uint _wineIndex, uint _quantityBought) public {
        wines[_wineIndex].inv_Qty-= _quantityBought;
        //Delete the item completely if inv_Qty = 0;
    }
}
