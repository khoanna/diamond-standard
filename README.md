# Diamond Storage

A Solidity smart contract implementing advanced storage patterns using diamond storage (EIP-2535) principles with Foundry.

## Overview

Diamond Storage is a sophisticated approach to managing state in Solidity smart contracts. This project demonstrates how to use assembly-level storage manipulation to store complex data structures (including mappings) at specific storage slots, enabling better modularity and upgradability for smart contract systems.

## Features

- **Diamond Storage Pattern**: Implement struct-based storage at arbitrary storage slots using assembly
- **Complex Storage Support**: Store nested data structures including mappings within structs
- **Type-Safe Access**: Leverage Solidity's type system for safe storage access
- **Modular Design**: Easily extend and organize contract state across multiple logical components

## Project Structure

```
├── src/
│   └── Storage.sol          # Core storage contract implementation
├── test/
│   └── Storage.t.sol        # Contract tests
├── script/
│   └── Storage.s.sol        # Deployment script
└── foundry.toml             # Foundry configuration
```

## How It Works

The `Storage` contract uses Solidity assembly to access a specific storage slot for managing the `WalletStorage` struct:

```solidity
bytes32 constant STRUCT_SLOT = keccak256("storage.slot");

struct WalletStorage {
    string name;
    string symbol;
    uint256 totalSupply;
    mapping(address => uint256) balances;
}

function _getStorage() internal pure returns (WalletStorage storage ws) {
    bytes32 slot = STRUCT_SLOT;
    assembly {
        ws.slot := slot
    }
}
```

This approach allows storing all wallet-related data in a deterministic location, making it ideal for:
- Facet-based diamond contracts
- Proxy upgrade patterns
- Multi-facet state management

## Installation

Install [Foundry](https://book.getfoundry.sh/getting-started/installation):

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Usage

### Build

```bash
forge build
```

Compiles the Solidity contracts.

### Test

```bash
forge test
```

Runs all tests in the `test/` directory.

### Format

```bash
forge fmt
```

Formats all Solidity files according to Foundry's style guide.

### Gas Snapshots

```bash
forge snapshot
```

Generates a gas usage report for contract functions.

### Deploy

```bash
forge script script/Storage.s.sol:StorageScript \
  --rpc-url <your_rpc_url> \
  --private-key <your_private_key> \
  --broadcast
```

Replace `<your_rpc_url>` with your network's RPC endpoint and `<your_private_key>` with your wallet's private key.

### Local Testing

Start a local Ethereum node:

```bash
anvil
```

Deploy to the local network:

```bash
forge script script/Storage.s.sol:StorageScript \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <your_private_key> \
  --broadcast
```

## Documentation

- **Foundry Book**: https://book.getfoundry.sh/
- **EIP-2535 Diamond Standard**: https://eips.ethereum.org/EIPS/eip-2535
- **Diamond Storage Pattern**: Learn more about advanced Solidity storage patterns

## License

UNLICENSED

## Contributing

Contributions are welcome! Feel free to submit issues and pull requests.
