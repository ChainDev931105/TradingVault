// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.8.6;
pragma experimental ABIEncoderV2;

import { IERC20, SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IWETH } from "./interfaces/IWETH.sol";
import { IVault } from "./interfaces/IVault.sol";
import { VaultState } from "./libraries/VaultState.sol";

contract TradingVault is IVault, Ownable {
    using SafeERC20 for IERC20;

    IWETH internal immutable weth;

    mapping(address => mapping(address => VaultState.VaultData)) public vaults;
    mapping(address => bool) public userPerm;
    mapping(address => bool) public tokenWhiteList;

    constructor(address _weth) {
        weth = IWETH(_weth);
        whitelistToken(_weth);
    }

    modifier isAllowedUser() {
        if (!userPerm[msg.sender]) revert Vault__Not_Allowed_User(msg.sender);
        _;
    }

    modifier whitelisted(address token) {
        if (!tokenWhiteList[token]) revert Vault__Token_Not_Whitelisted(token);
        _;
    }

    modifier isValidAmount(uint256 amount) {
        if (amount == 0) revert Vault__Null_Amount();
        _;
    }

    function whitelistToken(address token) public override onlyOwner {
        tokenWhiteList[token] = true;
    }

    function allowUser(address user) public override onlyOwner {
        userPerm[user] = true;
    }

    function deposit(address token, uint256 amount)
        external
        override
        whitelisted(token)
        isValidAmount(amount)
    {
        IERC20 tkn = IERC20(token);

        tkn.safeTransferFrom(msg.sender, address(this), amount);
        vaults[msg.sender][token].balance += amount;

        emit Deposit(msg.sender, token, amount);
    }

    function withdraw(address token, uint256 amount)
        external
        override
        whitelisted(token)
        isAllowedUser
        isValidAmount(amount)
    {
        IERC20 tkn = IERC20(token);

        uint256 balance = vaults[msg.sender][token].balance;
        if (balance < amount) revert Vault__Insufficient_Balance(msg.sender, token, balance);

        vaults[msg.sender][token].balance -= amount;
        tkn.safeTransfer(msg.sender, amount);

        emit Withdraw(msg.sender, token, amount);
    }
}
