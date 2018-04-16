pragma solidity ^0.4.16;

contract Logistics{

    enum goods_type{dairy,vegetable,grain}
    //enum goods_type{};
    struct log_data {
        address logaddress;
        uint lot;
        uint temp;
        address provider;
        uint weight;
        uint quantity;
        uint farmerType;
        address senderAdd;
    }

    mapping(uint => log_data) data;

    Farmer farmer;
    Manufacturer man;
    Warehouse ware;

    function compareStrings (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }

    function setLogData(address add, uint lot1, uint temp1, string id) returns (uint)
    {
    if(compareStrings(id,"farmer")) {
        farmer = Farmer(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = farmer.getAddress(lot1);
        data[lot1].weight = farmer.getWeight(lot1);
        data[lot1].quantity = farmer.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = farmer.getType(lot1);
        return lot1;
        }
    else if(compareStrings(id,"man")) {
        man = Manufacturer(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = man.getAddress(lot1);
        data[lot1].weight = man.getWeight(lot1);
        data[lot1].quantity = man.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = man.getProductId(lot1);
        return lot1;
    }
    else if(compareStrings(id,"ware")) {
        ware = Warehouse(add);
        data[lot1].senderAdd = add;
        data[lot1].logaddress = msg.sender;
        data[lot1].provider = ware.getAddress(lot1);
        data[lot1].weight = ware.getWeight(lot1);
        data[lot1].quantity = ware.getQuantity(lot1);
        data[lot1].temp = temp1;
        data[lot1].farmerType = ware.getProductId(lot1);
        return lot1;
    }
    }

    function getProvider(uint lot) returns(address)
    {
        return data[lot].provider;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].farmerType;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
    function getTemp(uint lot) returns(uint)
    {
        return data[lot].temp;
    }

}
