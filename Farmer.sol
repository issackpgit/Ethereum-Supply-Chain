pragma solidity ^0.4.16;

contract Farmer{
    enum farmer_type{dairy,vegetable,grain}
    struct farmer_data {
        address farmer_address;
        uint farmer_type;
        uint weight;
        uint quantity;
        uint256 timestamp;
        string location;
    }

    event Order_Created(address from, uint lot);

    uint guestlot = 1000;

    mapping(uint => farmer_data) public data;

    function setData(uint farmer_type1,uint weight1,uint quantity1,string location1,uint lot1) returns (uint)
    {
        data[lot1].farmer_address=msg.sender;
        data[lot1].farmer_type=farmer_type1;
        data[lot1].weight=weight1;
        data[lot1].quantity=quantity1;
        data[lot1].timestamp=now;
        data[lot1].location=location1;

        return lot1;
        Order_Created(data[lot1].farmer_address,lot1);
    }


    function getAddress(uint lot) returns(address)
    {
        return data[lot].farmer_address;
    }
    function getType(uint lot) returns(uint)
    {
        return data[lot].farmer_type;
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
