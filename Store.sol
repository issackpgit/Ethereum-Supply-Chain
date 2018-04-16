pragma solidity ^0.4.16;

contract Store {

    struct store_data {
        address storename;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        address senderAdd;
    }

    Logistics log;
    Farmer farmer;
    Manufacturer man;
    Warehouse ware;
    mapping(uint => store_data) data;

    function setStoreData(address add, uint lot, uint location) returns (uint){
        log = Logistics(add);
        data[lot].senderAdd = add;
        data[lot].storename = msg.sender;
        data[lot].prodId = log.getProductId(lot);
        data[lot].weight = log.getWeight(lot);
        data[lot].quantity = log.getQuantity(lot);
        data[lot].location = location;
        return lot;
    }

    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].storename;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].prodId;
    }
    function getWeight(uint lot) returns(uint)
    {
        return data[lot].weight;
    }
    function getQuantity(uint lot) returns(uint)
    {
        return data[lot].quantity;
    }
}
