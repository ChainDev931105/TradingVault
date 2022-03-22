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

- MockWETH Contract Address: https://ropsten.etherscan.io/address/0x0b573A4D668cD6c89A20Ef035bD6A381a23bFD7c

- TradingVault Contract Address : https://ropsten.etherscan.io/address/0x456e0842188214C1AD682BBcF988953C8ed53e30

## Deploy to Mumbai testnet (MATIC)

```bash
# Deploy
truffle deploy --network matic
```

## Unit Test

```bash
truffle test
```
