#!/bin/sh

# FIXME: Cannot use set -e since bash is not installed in Dockerfile
# set -e

RETRIES=${RETRIES:-40}
VERBOSITY=${VERBOSITY:-6}

# get the genesis file from the deployer
curl \
    --fail \
    --show-error \
    --silent \
    --retry-connrefused \
    --retry-all-errors \
    --retry $RETRIES \
    --retry-delay 5 \
    $ROLLUP_STATE_DUMP_PATH \
    -o genesis.json

# wait for the dtl to be up, else geth will crash if it cannot connect
curl \
    --fail \
    --show-error \
    --silent \
    --output /dev/null \
    --retry-connrefused \
    --retry $RETRIES \
    --retry-delay 1 \
    $ROLLUP_CLIENT_HTTP

# import the key that will be used to locally sign blocks
# this key does not have to be kept secret in order to be secure
# we use an insecure password ("pwd") to lock/unlock the password
echo "Importing private key"
echo $BLOCK_SIGNER_KEY > key.prv
echo "pwd" > password
geth --datadir data account import --password ./password ./key.prv

# initialize the geth node with the genesis file
echo "Initializing Geth node"
geth --datadir data --verbosity="$VERBOSITY" "$@" init genesis.json

# start the geth node
echo "Starting Geth node"
exec geth \
  --datadir data \
  --networkid 17 \
  --port 31303 \
  --authrpc.port 8651  \
  --http --http.port 8645 --http.addr 0.0.0.0  \
  --http.corsdomain '*'  --http.api personal,web3,eth,net \
  --ws --ws.port 8646 --ws.origins="*"  \
  --password ./password \
  --allow-insecure-unlock \
  --unlock $BLOCK_SIGNER_ADDRESS \
  --mine \
  --miner.etherbase $BLOCK_SIGNER_ADDRESS \
  --bootnodes enode://388dc232b559fbd1fcbbfe45d0e8f9e741fe8a08c33b05f5b75df00c3dd78ce0e39ee8cb9a3c94d8a2f204255c47e9d4a51339fa45cae69772fdf636d98875de@127.0.0.1:30303 \
  "$@"
