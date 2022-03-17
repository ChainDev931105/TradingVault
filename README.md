# TradingVault

TradingVault that user can deposit/withdraw his asset to trade.

It contains two versions - EVM & Solana.

## EVM version

### Deploy to Ropsten

You need `.secret` file to deploy to testnet with your mnemonic.

```bash
cd trading-vault-evm

# Deploy
truffle deploy --network ropsten

# Interact
truffle console --network ropsten --verbose-rpc
```

- Contract Address: 

### Deploy to Mumbai testnet (MATIC)

```bash
cd trading-vault-evm

# Deploy
truffle deploy --network matic
```

### Unit Test

```bash
cd SmartContracts
truffle test
```


## Solana version

