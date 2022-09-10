// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0 ;

import "./IERC20.sol" ;
import "./Context.sol" ;
import "./Ownable.sol" ;
import "./SafeMath.sol" ;

contract ERC20 is Context , Ownable , IERC20 {
    
    using SafeMath for uint256 ;



    mapping (address => uint256) _balance ;

    mapping (address => mapping(address => uint256)) _allowance ;

    uint private _totalSupply ;
    uint private decimal ;

    string private name_ ;
    string private symbol ;


    constructor (string memory _name , string memory _symbol , uint totalSupply_ , uint _decimal ){
        name_ = _name ;
        symbol = _symbol ;
        _totalSupply = totalSupply_ ;
        decimal = _decimal ;    
    }


    function name () 
    public view virtual returns(string memory){
        return name_ ;
    }

    function symbol_ ()
    public view virtual returns(string memory){
        return symbol ;
    }

    function decimal_ () 
    public view virtual returns(uint256){
        return decimal ;
    }

    function totalSupply() 
    external view returns(uint256){
        return _totalSupply ;
    }




    function _transfer(address from , address to , uint256 amount)
    internal virtual {
        require(from != address(0), "ERC20: transfer from 0 address" );
        require(to != address(0), "ERC20: transfer to 0 address");

        uint256 fromBalance = _balance[from] ;
        require(fromBalance >= amount , "ERC20: Insufficient Balance");

        _balance[from] = _balance[from].sub(amount) ;
        _balance[to] = _balance[to].add(amount) ;

        emit Transfer(from, to, amount);
    }

    
    function _approve(address owner ,address spender ,uint256 amount)  
    internal virtual {
        require(owner != address(0), "ERC20: owner from zero address");
        require(spender != address(0), "ERC20: spender from zero address");

        _allowance[owner][spender] = amount ;

        emit Approval(owner, spender, amount);
    }



    function balanceOf(address account) 
    public view virtual override returns(uint256){

        return _balance[account] ;
    }


    function transfer(address to , uint256 amount ) 
    public virtual override returns(bool){

        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true ;
    }

    function allowance(address owner , address spender) 
    public virtual override view returns(uint256){
        
        return _allowance[owner][spender];
    }

    function approve(address spender , uint256 amount) 
    public virtual override returns(bool){

        address owner = _msgSender();
        _approve(owner, spender, amount);

        return true ;

    }

    function trasferFrom(address from , address to , uint256 amount) 
    public virtual override returns (bool){
        
        address spender = _msgSender();
        require(amount <= _allowance[from][spender] );
        _allowance[from][spender] = _allowance[from][spender].sub(amount) ;

        _transfer(from, to, amount);
        
        return true ;
    }
    
    function _beforeTokenTransfer(address from,address to,uint256 amount) 
    internal virtual {}

    function _afterTokenTransfer(address from,address to,uint256 amount) 
    internal virtual {}
    
    function _burn(address account, uint256 amount) internal virtual {
        
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balance[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balance[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

}