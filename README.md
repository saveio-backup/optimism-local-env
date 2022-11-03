
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

cd packages/contracts

rm -rvf deployments/local/
rm addresses.json

export CONTRACTS_RPC_URL=http://127.0.0.1:8545
export CONTRACTS_DEPLOYER_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export CONTRACTS_TARGET_NETWORK=local

./deployer.sh 
```

### l2geth

```
export ETH1_HTTP=http://127.0.0.1:8545
export ROLLUP_TIMESTAMP_REFRESH=5s
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export BLOCK_SIGNER_KEY=6587ae678cf4fc9a33000cdbf9f35226b71dcc6a4684a31203241f9bcfd55d27
export BLOCK_SIGNER_ADDRESS=0x00000398232E2064F896018496b4b44b3D62751F
export ROLLUP_ENFORCE_FEES=${ROLLUP_ENFORCE_FEES:-true}
export ROLLUP_FEE_THRESHOLD_DOWN=0.9
export ROLLUP_FEE_THRESHOLD_UP=1.1
```

