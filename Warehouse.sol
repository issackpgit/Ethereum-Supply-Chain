pragma solidity ^0.4.16;

contract Warehouse {
    struct ware_data {
        address warehouse;
        address provider;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        uint temp;
        uint lot;
        address senderAdd;
    }
    Logistics log;
    mapping(uint => ware_data) data;


    function setWareData(address add, uint loc, uint lot) returns(uint){
        log = Logistics(add);
        data[lot].senderAdd = add;
        data[lot].warehouse = msg.sender;
        data[lot].provider = log.getProvider(lot);
        data[lot].prodId = log.getProductId(lot);
        data[lot].weight = log.getWeight(lot);
        data[lot].quantity = log.getQuantity(lot);
        data[lot].location = loc;
        return lot;
    }

    function getAddress(uint lot) returns(address)
    {
        return data[lot].warehouse;
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
    function getSendAddress(uint lot) returns(address)
    {
        return data[lot].senderAdd;
    }

}
