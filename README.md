# PGF Testing
PGF steward/funding script(s) to automate testing its mechanisms and verify correctness.

---

## Getting started

### [config.json](config.json)

Make sure to configure this file before calling any of the scripts.

```json
{
  "service": "namadad",
  "lines": 20000
}
```
> `service`: your service name _[default: "namadad"]_.
> 
> `lines`: the amount of lines the script is able to traverse back in your node's log _[default: 20000]_. A higher value will make scripts like [log-epoch.sh](./log-epoch.sh) less performant. 

## [log-epoch.sh](log-epoch.sh)

Logs relevant information for the current or given epoch.

### Command
```sh
bash log-epoch.sh [epoch]
```
> [epoch] is _optional_ [default: the current epoch].

#### Output
```log
2024-07-17T16:59:53.124590Z  INFO namada_state::wl_state: Began a new epoch 1664
2024-07-17T16:59:53.124622Z  INFO namada_state::wl_state: Began a new masp epoch 832
2024-07-17T16:59:53.124628Z  INFO namada_node::shell::finalize_block: Block height: 52350, epoch: 1664, is new epoch: true, is masp new epoch: true.
2024-07-17T16:59:53.282678Z  INFO namada_proof_of_stake::rewards: Minting tokens for PoS rewards distribution into the PoS account. Amount: 952.792145. Total inflation: 952.792148. Total native supply: 1001575106.370084. Number of blocks in the last epoch: 31. Reward accumulators sum: 30.999999999783.
2024-07-17T16:59:53.282715Z  INFO namada_proof_of_stake::rewards: Minting tokens remaining from PoS rewards distribution into the Governance account. Amount: 0.000003.
2024-07-17T16:59:53.282897Z  INFO namada_governance::pgf::inflation: Minting 952.793054 tokens for PGF rewards distribution into the PGF account (total supply 1001576059.162229)
```

## [total-supply.sh](total-supply.sh)

Logs the current total supply or the total supply for a given epoch.

### Command
```sh
bash total-supply.sh [epoch]
```
> [epoch] is _optional_ [default: the current epoch].

#### Output
```log
1001576059.162229 (epoch 1664)
```
