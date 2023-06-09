cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

utxoin="7e48a6f4f4ec6d0da1081064f534673e62d13113daf717fa2c1b0d4b92475476#0"
address=$(cat redeemer11.addr) 
output="500000000"
PREVIEW="--testnet-magic 2"
nami="addr_test1qqrhqn8q3ees5zgerdnhvp745xjhem8m5r66k4m7hdjzgl7s4xjx5a9gt9c7u5eefmw9h89m94vapr8xsm49eh653l9s78kv49" 


cardano-cli transaction build \
  --babbage-era \
  $PREVIEW \
  --tx-in $utxoin \
  --tx-out $address+$output \
  --tx-out-datum-hash-file value11.json \
  --change-address $nami \
  --protocol-params-file protocol.params \
  --out-file give.unsigned

cardano-cli transaction sign \
    --tx-body-file give.unsigned \
    --signing-key-file test01.skey \
    $PREVIEW \
    --out-file give.signed

 cardano-cli transaction submit \
    $PREVIEW \
    --tx-file give.signed