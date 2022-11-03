
## Optimism local env

Refs [/saveio/optimism](http://10.0.1.228:3000/saveio/optimism)

## Usage

### l1_chain

```
yarn install && yarn cache clean
yarn start
```

## deployer

```
yarn install --frozen-lockfile && yarn cache clean
yarn build

export CONTRACTS_RPC_URL=http://127.0.0.1:8545
export CONTRACTS_DEPLOYER_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export CONTRACTS_TARGET_NETWORK=local

cd packages/contracts
./deployer.sh 

cd packages/contracts-bedrock

```

