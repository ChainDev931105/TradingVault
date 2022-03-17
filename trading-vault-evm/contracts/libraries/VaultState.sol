// SPDX-License-Identifier: BUSL-1.1
pragma solidity >=0.8.6;
pragma experimental ABIEncoderV2;

/// @title    VaultState library
/// @author   Kaito
/// @notice   A library to stora vault state
library VaultState {
    /// @notice store vault data of such user and token
    /// @param user address of user
    /// @param token address of token(ERC20 or ETH)
    /// @param locked true when it is under processing
    /// @param balance remain amount 
    struct VaultData {
        address user;
        address token;
        bool locked;
        uint256 balance;
    }
}
