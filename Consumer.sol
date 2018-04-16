pragma solidity ^0.4.16;

contract consumer {

    struct cons_data {
        uint prodId;
        address consumer;
    }
    mapping(uint => cons_data) data;
    Logistics log;
    Store store;

    function concat(string _base, string _value) internal returns (string) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint i;
        uint j;

        for(i=0; i<_baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for(i=0; i<_valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i++];
        }

        return string(_newValue);
    }


    function getTree(address storeAdd, uint lot) returns (uint p, uint w, uint prodId) {
        store = Store(storeAdd);

        Logistics log ;
        Warehouse ware;

        address storeAddress = store.getAddress(lot);
        // string store_details = store.getQuantity(lot)+":"+store.getWeight(lot)+":"+store.getSendAddress(lot);

        uint weight = store.getWeight(lot);
        uint quantity = store.getQuantity(lot);
        prodId = store.getProductId(lot);
        address log1 = store.getSendAddress(lot);

        log = Logistics(log1);

        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        uint weight1 = log.getWeight(lot);
        (p,w) = getRichNet(lot,logadd1);

    }

    function getRichNet(uint lot,address add) returns (uint p,uint w) {
        Warehouse ware;

        ware = Warehouse(add);
        uint weight = ware.getWeight(lot);
        uint quantity = ware.getQuantity(lot);
        address senderAdd = ware.getSendAddress(lot);

        Logistics log;

        log = Logistics(senderAdd);
        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        getRichNet(lot,logadd1);

        Manufacturer man;

        man = Manufacturer(logadd1);
        address add2 = man.getSendAddress(lot);
        uint prodId =  man.getOldProductId(lot);

        (p,w) = getSupplierNet(prodId, add2);
    }

    function getSupplierNet(uint lot, address add2) returns (uint p, uint w) {
        Logistics log;

        log = Logistics(add2);
        address logadd1 = log.getSendAddress(lot);
        uint temp = log.getTemp(lot);
        uint weight1 = log.getWeight(lot);

        Warehouse ware;

        ware = Warehouse(logadd1);
        uint weight = ware.getWeight(lot);
        uint quantity = ware.getQuantity(lot);
        address senderAdd = ware.getSendAddress(lot);

        log = Logistics(senderAdd);
        address logadd2 = log.getSendAddress(lot);

        (p,w) = getSupplierNet2(logadd2, lot);
    }

    function getSupplierNet2(address add, uint lot) returns (uint prodId, uint weight3){

        Manufacturer man;

        man = Manufacturer(add);
        address add3 = man.getSendAddress(lot);
        prodId =  man.getOldProductId(lot);
        weight3 = man.getWeight(lot);

        Logistics log;

        log = Logistics(add3);
        address logadd1 = log.getSendAddress(prodId);
        uint temp = log.getTemp(prodId);
        uint weight1 = log.getWeight(prodId);

        Farmer farm;
        string output;

        farm = Farmer(logadd1);
        address farmadd = farm.getAddress(prodId);
        uint weight2 = farm.getWeight(prodId);
        uint quantity = farm.getQuantity(prodId);

        // return prodId;
        // return weight3;


    }

}
