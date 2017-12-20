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

## Test

```sh
docker build -t comocapital/parity:{VERSION} .
test\run_all.sh $VERSION
```