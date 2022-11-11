
# Optimism local env

Refs [/saveio/optimism](http://10.0.1.228:3000/saveio/optimism)

## Usage

- l1_chain

```
yarn install && yarn cache clean
yarn start
```

- packages

```
cd packages
yarn install --frozen-lockfile && yarn cache clean
yarn build
```

- deployer

```
cd packages/contracts

yarn install --frozen-lockfile && yarn cache clean
yarn build

rm -rvf deployments/local/

export CONTRACTS_RPC_URL=http://127.0.0.1:9545
export CONTRACTS_DEPLOYER_KEY=ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
export CONTRACTS_TARGET_NETWORK=local

./deployer.sh
```

- dtl

```
cd packages/data-transport-layer

yarn install --frozen-lockfile && yarn cache clean
yarn build

source dtl.env
export $(cut -d= -f1 dtl.env)

export URL=http://127.0.0.1:8081/addresses.json
export DATA_TRANSPORT_LAYER__L1_RPC_ENDPOINT=http://127.0.0.1:9545
export DATA_TRANSPORT_LAYER__L2_RPC_ENDPOINT=http://127.0.0.1:8545
export DATA_TRANSPORT_LAYER__SYNC_FROM_L2=true
export DATA_TRANSPORT_LAYER__L2_CHAIN_ID=17

./dtl.sh
```

- l2geth

```
source geth.env
export $(cut -d= -f1 geth.env)

export ETH1_HTTP=http://127.0.0.1:9545
export ROLLUP_TIMESTAMP_REFRESH=5s
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export BLOCK_SIGNER_KEY=6587ae678cf4fc9a33000cdbf9f35226b71dcc6a4684a31203241f9bcfd55d27
export BLOCK_SIGNER_ADDRESS=0x00000398232E2064F896018496b4b44b3D62751F
export ROLLUP_ENFORCE_FEES=${ROLLUP_ENFORCE_FEES:-true}
export ROLLUP_FEE_THRESHOLD_DOWN=0.9
export ROLLUP_FEE_THRESHOLD_UP=1.1

./geth.sh
```

- verifier

```
source geth.env
export $(cut -d= -f1 geth.env)

export ETH1_HTTP=http://127.0.0.1:9545
export SEQUENCER_CLIENT_HTTP=http://127.0.0.1:8545
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ROLLUP_BACKEND='l1'
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export RETRIES=60
export ROLLUP_VERIFIER_ENABLE='true'

./geth.sh
```

- replica

```
source geth.env
export $(cut -d= -f1 geth.env)

export ETH1_HTTP=http://127.0.0.1:9545
export SEQUENCER_CLIENT_HTTP=http://127.0.0.1:8545
export ROLLUP_STATE_DUMP_PATH=http://127.0.0.1:8081/state-dump.latest.json
export ROLLUP_CLIENT_HTTP=http://127.0.0.1:7878
export ROLLUP_BACKEND='l2'
export ROLLUP_VERIFIER_ENABLE='true'
export ETH1_CTC_DEPLOYMENT_HEIGHT=8
export RETRIES=60

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

export BUILD_ENV=development
export ETH_NETWORK_NAME=clique
export LOG_LEVEL=debug
export BATCH_SUBMITTER_LOG_LEVEL=debug
export BATCH_SUBMITTER_LOG_TERMINAL=true
export BATCH_SUBMITTER_MIN_L1_TX_SIZE=32
export BATCH_SUBMITTER_MAX_L1_TX_SIZE=90000
export BATCH_SUBMITTER_MAX_PLAINTEXT_BATCH_SIZE=120000
export BATCH_SUBMITTER_MIN_STATE_ROOT_ELEMENTS=1
export BATCH_SUBMITTER_MAX_STATE_ROOT_ELEMENTS=3000
export BATCH_SUBMITTER_MAX_BATCH_SUBMISSION_TIME=0
export BATCH_SUBMITTER_POLL_INTERVAL=500ms
export BATCH_SUBMITTER_NUM_CONFIRMATIONS=1
export BATCH_SUBMITTER_SAFE_ABORT_NONCE_TOO_LOW_COUNT=3
export BATCH_SUBMITTER_RESUBMISSION_TIMEOUT=1s
export BATCH_SUBMITTER_FINALITY_CONFIRMATIONS=0
export BATCH_SUBMITTER_RUN_TX_BATCH_SUBMITTER=true
export BATCH_SUBMITTER_RUN_STATE_BATCH_SUBMITTER=true
export BATCH_SUBMITTER_SAFE_MINIMUM_ETHER_BALANCE=0
export BATCH_SUBMITTER_CLEAR_PENDING_TXS=false

./batch-submitter.sh
```

