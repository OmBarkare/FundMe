# FundME
**This is a Funding Contract which can be used to collect funds**
**Dont use this for getting real funds, this is not audited, this was created only for learning purpose**

## Quick Start
```bash
git clone https://github.com/OmBarkare/FundMe
cd FundMe
```
**if ssh key is setup, you can use**
```bash
git clone git@github.com:OmBarkare/FundMe.git
cd FundMe
```

## Tools used:
-    Foundry

### Here is how to install foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
```
This will install foundryup, follow the instructions and run
```bash
foundryup
```
This will install Forge, Cast, Anvil and Chisel.

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
