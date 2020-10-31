pragma solidity >=0.4.0 <0.7.0;

import "./Context.sol";
import "./Ownable.sol";

contract MyToken is Context, Ownable{
    
    uint256 public totalSupply;
    string public name;
    string public symbol;
    uint256 public decimals;

    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowances;

    constructor (string memory _name, string memory _symbol) public{
        name = _name;
        symbol = _symbol;
        decimals = 18;
        _mint(_msgSender(),1000*10**decimals);
    }
    
    //transfer
    function _mint(address account, uint256 amount) public onlyOwner{
        require(account != address(0), "ERC20: mint to the zero address");
        totalSupply = totalSupply+amount;
        balances[account] = balances[account]+amount;
        emit Transfer(address(0), account, amount);
    }
    
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        balances[_msgSender()] = balances[_msgSender()]-(amount*10**decimals);
        balances[recipient] = balances[recipient]+(amount*10**decimals);
        emit Transfer(_msgSender(), recipient, amount);
        return true;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
    
    //approve
    function approve(address spender, uint256 amount) public returns (bool) {
        require(_msgSender() != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
    
        allowances[_msgSender()][spender] = (amount*10**decimals);
        emit Approval(_msgSender(), spender, (amount*10**decimals));
        return true;
    }
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    //increase, decrease allownace
    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        approve(spender, allowances[_msgSender()][spender]+addedValue);
        return true;
    }
    
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        approve(spender, allowances[_msgSender()][spender]-subtractedValue);
        return true;
    }
    
    //@dev burn
      function _burn(address account, uint256 amount) public onlyOwner {
        require(account != address(0), "ERC20: burn from the zero address");

        balances[account] = balances[account]-amount;
        totalSupply = totalSupply-amount;
        emit Transfer(account, address(0), amount);
    }
}
