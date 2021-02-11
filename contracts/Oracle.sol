// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.3;

contract Oracle {
    struct Data{
        uint date;
        uint payload;
    }

    address public admin;
    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }

    constructor(address _admin){
        admin = _admin;
    }

    function updateReporter(address _reporter, bool _isReporter) external onlyAdmin{
        reporters[_reporter] = _isReporter;
    }

    function updateData(bytes32 _key, uint _payload) external{
        require(reporters[msg.sender]==true);
        data[_key]= Data(block.timestamp, _payload);
    }

    function getData(bytes32 _key)
        external
        view
        returns (bool result, uint date, uint payload){
           if(data[_key].date == 0) {
               return(false, 0, 0);
           }
           return(true, data[_key].date, data[_key].payload);
        }
}