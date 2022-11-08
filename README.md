
# Optimism local env

Refs [/saveio/optimism](http://10.0.1.228:3000/saveio/optimism)

## Usage

- l1_chain

```
yarn install && yarn cache clean
yarn start
```

- deployer

```
yarn install --frozen-lockfile && yarn cache clean
yarn build

cd packages/contracts

rm -rvf deployments/local/
rm addresses.json

export CONTRACTS_RPC_URL=http://127.0.0.1:9545
export CONTRACTS_DEPLOYER_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export CONTRACTS_TARGET_NETWORK=local

./deployer.sh 
```

- dtl

```
cd packages/data-transport-layer

export URL=http://127.0.0.1:8081/addresses.json
export DATA_TRANSPORT_LAYER__L1_RPC_ENDPOINT=http://127.0.0.1:9545
export DATA_TRANSPORT_LAYER__L2_RPC_ENDPOINT=http://127.0.0.1:8545
export DATA_TRANSPORT_LAYER__SYNC_FROM_L2=true
export DATA_TRANSPORT_LAYER__L2_CHAIN_ID=17

./dtl.sh
```

- l2geth

```
export ETH1_HTTP=http://127.0.0.1:9545
export ROLLUP_TIMESTAMP_REFRESH=5s
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export BLOCK_SIGNER_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export BLOCK_SIGNER_ADDRESS=0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266
export ROLLUP_ENFORCE_FEES=${ROLLUP_ENFORCE_FEES:-true}
export ROLLUP_FEE_THRESHOLD_DOWN=0.9
export ROLLUP_FEE_THRESHOLD_UP=1.1

./geth.sh
```

- verifier

```
export ETH1_HTTP=http://127.0.0.1:9545
export SEQUENCER_CLIENT_HTTP=http://127.0.0.1:8545
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ROLLUP_BACKEND='l1'
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export RETRIES=60
export ROLLUP_VERIFIER_ENABLE='true'
export BLOCK_SIGNER_KEY=59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
export BLOCK_SIGNER_ADDRESS=0x70997970c51812dc3a010c7d01b50e0d17dc79c8

./geth.sh
```

- replica

```
export ETH1_HTTP=http://127.0.0.1:9545
export SEQUENCER_CLIENT_HTTP=http://127.0.0.1:8545
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ROLLUP_BACKEND='l2'
export ROLLUP_VERIFIER_ENABLE='true'
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export RETRIES=60
export BLOCK_SIGNER_KEY=5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a
export BLOCK_SIGNER_ADDRESS=0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc

./geth.sh
```

- batch_submitter

```
export L1_ETH_RPC=http://127.0.0.1:9545
export L2_ETH_RPC=http://127.0.0.1:8545
export URL=http://127.0.0.1:8081/addresses.json
export BATCH_SUBMITTER_SEQUENCER_PRIVATE_KEY='0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d'
export BATCH_SUBMITTER_PROPOSER_PRIVATE_KEY='0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a'
export BATCH_SUBMITTER_SEQUENCER_BATCH_TYPE=${BATCH_SUBMITTER_SEQUENCER_BATCH_TYPE:-zlib}

export $(cut -d= -f1 batch-submitter.env)

./batch-submitter.sh
```

