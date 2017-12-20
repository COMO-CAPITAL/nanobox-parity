# nanobox-parity

Компонент parity в виде data сервиса nanobox.

## Usage

```yml
data.parity:
  image: comocapital/parity:0.0.0
  config:
    chain: kovan
    rpcapi:
      - eth
      - net
      - personal
      - web3
```