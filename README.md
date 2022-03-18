# TradingVault

TradingVault that user can deposit/withdraw his asset to trade.

## Deploy to Ropsten

You need `.secret` file to deploy to testnet with your mnemonic.

```bash
# Deploy
truffle deploy --network ropsten

# Interact
truffle console --network ropsten --verbose-rpc
```

- MockWETH Contract Address: https://ropsten.etherscan.io/address/0x095629E092e3b12a62C6A5c9Face6049D4B15834

- TradingVault Contract Address : https://ropsten.etherscan.io/address/0x4988E32C7F4C48Ab528BdF001103B0d7B889F8da

## Deploy to Mumbai testnet (MATIC)

```bash
# Deploy
truffle deploy --network matic
```

## Unit Test

```bash
truffle test
```
