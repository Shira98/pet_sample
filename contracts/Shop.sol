// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

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
 
    //Mapping -
    mapping (uint => WineList) public wines;
    mapping(address => WineCart[]) public cart;
    mapping(address => uint) public subtotal;
    mapping(address => uint) balance;

    //Variable definitions -
    uint public wineCount;
    uint public cartitemCount;
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
}