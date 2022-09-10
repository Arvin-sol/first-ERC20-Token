// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0 ;

import "./ERC20.sol" ;

contract ERC is ERC20 {

    constructor() ERC20("erecius" , "ERC" , 1000000 * 1e5, 5) {
        _balance[_msgSender()] = 1000000 * 1e5 ;
    }
}