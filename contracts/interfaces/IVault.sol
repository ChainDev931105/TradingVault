// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.8.6;
pragma experimental ABIEncoderV2;

/// @title    Interface of Vault contract
/// @author   Kaito
interface IVault {
    /// @notice
    /// @param token the token to deposit
    /// @param amount the amount of tokens deposited
    function deposit(address token, uint256 amount) external;

    /// @notice
    /// @param token the token to deposit
    /// @param amount the amount of tokens withdrawn
    function withdraw(address token, uint256 amount) external;

    /// @notice adds a new supported token
    /// @param token the token to whitelist
    function whitelistToken(
        address token
    ) external;

    /// @notice adds a user to allowed list
    /// @param user user address
    function allowUser(
        address user
    ) external;

    /// ==== EVENTS ==== ///
    /// @notice Emitted when a deposit has been performed
    event Deposit(address indexed user, address indexed token, uint256 amount);

    /// @notice Emitted when a withdraw has been performed
    event Withdraw(address indexed user, address indexed token, uint256 amount);
    

    /// ==== ERRORS ==== ///

    error Vault__Not_Allowed_User(address);
    error Vault__Locked(address, address);
    error Vault__Token_Not_Whitelisted(address);
    error Vault__Null_Amount();
    error Vault__Insufficient_Balance(address, address, uint256);
}
