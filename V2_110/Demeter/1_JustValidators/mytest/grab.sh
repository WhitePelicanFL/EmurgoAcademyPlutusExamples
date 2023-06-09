utxoin="f4eba75f9b6930a2bf146c0203b782f75de0b905c0a8d8b91d80ae3d00804b10#0"
address=$(cat test01.addr) 
output="450000000"
collateral="f4eba75f9b6930a2bf146c0203b782f75de0b905c0a8d8b91d80ae3d00804b10#1"
signerPKH=$(cat test01.pkh)
nami="addr_test1qqrhqn8q3ees5zgerdnhvp745xjhem8m5r66k4m7hdjzgl7s4xjx5a9gt9c7u5eefmw9h89m94vapr8xsm49eh653l9s78kv49" 
PREVIEW="--testnet-magic 2"

cardano-cli transaction build \
  --babbage-era \
  $PREVIEW \
  --tx-in $utxoin \
  --tx-in-script-file redeemer11.plutus \
  --tx-in-datum-file value11.json \
  --tx-in-redeemer-file value11.json \
  --required-signer-hash $signerPKH \
  --tx-in-collateral $collateral \
  --tx-out $(cat test01.addr)+$output \
  --change-address $nami \
  --protocol-params-file protocol.params \
  --out-file grab.unsigned

cardano-cli transaction sign \
    --tx-body-file grab.unsigned \
    --signing-key-file test01.skey \
    $PREVIEW \
    --out-file grab.signed

 cardano-cli transaction submit \
    $PREVIEW \
    --tx-file grab.signed