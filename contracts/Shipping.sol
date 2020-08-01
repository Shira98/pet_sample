// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;

import "./Store.sol";

contract Shipping{

    address shipping;
    Store store;

    enum shippingStatus {
        Released, In_Transit, Delivered
    }

    struct Receipt{
        uint invoiceid;
        uint cartid;
        uint total_price;
        uint payment_method;
        string customer_delivery_address;
        string customer_name;
        address shipper_address;
        address customer_address;
        shippingStatus status;
    }

    mapping(address => Receipt[]) public customerOrderReceipt;

    mapping(address => shippingStatus) public status;

    constructor(address _storeContractAddress) public {
        shipping = msg.sender;
        store = Store(_storeContractAddress);
    }

    function setReceiptDetails(uint _invoiceid, uint _cartid, uint _total_price,
    uint _payment_method, string memory _customer_name, string memory _delivery_address, address _shipper_address, address _customer_address) public{
        Receipt memory newReceipt;
        newReceipt.invoiceid = _invoiceid;
        newReceipt.cartid = _cartid;
        newReceipt.total_price = _total_price;
        newReceipt.payment_method = _payment_method;
        newReceipt.customer_name = _customer_name;
        newReceipt.customer_delivery_address = _delivery_address;
        newReceipt.shipper_address = _shipper_address;
        newReceipt.customer_address = _customer_address;
        newReceipt.status = shippingStatus.Released;

        customerOrderReceipt[_customer_address].push(newReceipt);
    }

    function changeStatusToTransit(address _customer_address, uint _invoice_id) public returns (string memory){

        customerOrderReceipt[_customer_address][_invoice_id].status = shippingStatus.In_Transit;
        return ("Order in transit!");


    }

    function changeStatusToDelivered(address _customer_address, uint _invoice_id) public returns (string memory){

        customerOrderReceipt[_customer_address][_invoice_id].status = shippingStatus.Delivered;

        return ("Order is delivered!");
    }
}
