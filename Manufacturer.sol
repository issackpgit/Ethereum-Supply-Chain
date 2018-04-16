pragma solidity ^0.4.16;

contract Manufacturer {

    struct man_data {
        address manAdd;
        uint prodId;
        uint weight;
        uint quantity;
        uint location;
        uint oldLot;
        address senderAdd;
        uint oldProdId;
    }

    mapping(uint => man_data) data;

    Logistics log;
    uint nLot = 1000;
    uint prodIdnew = 12300;
    uint nLotRich = 10000;
    uint prodIdRich = 34500;

    function compareStrings (string a, string b) view returns (bool){
       return keccak256(a) == keccak256(b);
   }

    function setManData(address logadd, uint lot, uint loc, string id) returns (uint){
        if(compareStrings(id,"local")) {
            log = Logistics(logadd);
            data[nLot].senderAdd = logadd;
            data[nLot].manAdd = msg.sender;
            data[nLot].oldProdId = log.getProductId(lot);
            data[nLot].prodId = prodIdnew;
            data[nLot].weight = log.getWeight(lot);
            data[nLot].quantity = log.getQuantity(lot);
            data[nLot].location = loc;
            data[nLot].oldLot = lot;
            return nLot;
            nLot= nLot + 1;
            prodIdnew = prodIdnew + 1;
        }
        else if(compareStrings(id,"rich")) {

            log = Logistics(logadd);
            data[nLotRich].senderAdd = logadd;
            data[nLotRich].manAdd = msg.sender;
            data[nLotRich].oldProdId = log.getProductId(lot);
            data[nLot].prodId = prodIdRich;
            data[nLotRich].weight = log.getWeight(lot);
            data[nLotRich].quantity = log.getQuantity(lot);
            data[nLotRich].location = loc;
            data[nLotRich].oldLot = lot;
            return nLotRich;
            nLotRich= nLotRich +1;
        }
    }

    function modifyWeight(uint lot, uint weight) returns(uint){
        data[lot].weight = weight;
        return lot;
    }
    function getAddress(uint lot) returns(address)
    {
        return data[lot].manAdd;
    }
    function getProductId(uint lot) returns(uint)
    {
        return data[lot].prodId;
    }
    function getOldProductId(uint lot) returns(uint)
    {
        return data[lot].oldProdId;
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
