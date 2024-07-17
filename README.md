# PGF Testing
PGF steward/funding script(s) for Namada to help testing its mechanisms and verify correctness.

---

## Getting started

### [config.json](config.json)

Make sure to configure this file before calling any of the scripts.

```json
{
  "service": "namadad",
  "lines": 20000,
  "monitor_interval": 2
}
```
> `service`: your service name _[default: "namadad"]_.
> 
> `lines`: the amount of lines the script is able to traverse back in your node's log _[default: 20000]_. A higher value will make scripts like [log-epoch.sh](./log-epoch.sh) less performant.
>
> `monitor_interval`: the amount of seconds to sleep in between every check when one monitors epoch and address balance changes using [monitor.sh](./monitor.sh).

## Scripts

### [log-epoch.sh](log-epoch.sh)

Logs relevant information for the current or given epoch.

#### Command
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

### [total-supply.sh](total-supply.sh)

Logs the current total supply, the total supply for a given epoch or compares two total supplies from two different epochs.

#### Command
```sh
bash total-supply.sh [epoch] [epoch2]
```
> [epoch] is _optional_ [default: the current epoch].
> 
> [epoch2] is _optional_. If you decide to add a second epoch, the difference in supply will be calculated.

#### Output
```log
Epoch 1664: 1001576059.162229 (epoch 1664)
```

-OR-

```log
Epoch 1686: 1001597020.818731 nam
Epoch 1687: 1001597973.631723 nam
Difference: +952.812992 nam
```

### [monitor.sh](monitor.sh)

> [!TIP]
>
> This will create and append to a log file located in: `logs/monitor_{owner}.log`.

This will monitor the given owner address' balance and shows whenever an epoch change occurs.

#### Command
```sh
bash monitor.sh <owner>
```
> <owner> can either be an _alias_ or _address_.

#### Output
```log
[2024-07-17 18:48:47] Monitor for anodeofzen started.
[2024-07-17 18:48:47] Last committed epoch: 1684
[2024-07-17 18:48:47] nam: 995.5
[2024-07-17 18:49:32] balance change: +1.504242 nam (epoch 1684)
[2024-07-17 18:49:32] nam: 997.004242
[2024-07-17 18:51:06] balance change: -7.004242 nam (epoch 1684)
[2024-07-17 18:51:06] nam: 990
[2024-07-17 18:51:47] balance change: -1 nam (epoch 1684)
[2024-07-17 18:51:47] nam: 989
[2024-07-17 18:54:02] epoch change: 1685
[2024-07-17 18:55:46] balance change: +343000000 nam (epoch 1685)
[2024-07-17 18:55:46] nam: 343000989
```

</br>

<p align="right">— ZEN</p>
<p align="right">Copyright (c) 2024 ZENODE</p>
