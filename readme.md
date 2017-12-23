# nanobox-parity

Компонент parity в виде data сервиса nanobox.

## Usage

```yml
data.parity:
  image: comocapital/parity:latest
  config:
    chain: kovan
    rpcapi:
      - eth
      - net
      - personal
      - web3
    logging: info
    mode: last
    pruning: fast
    port: 30303
```

## Publish

Для публикации новой версии выполнить оба шага.

* Опубликовать новую версию под своей версией
```sh
docker push comocapital/parity:$VERSION
```

* Опубликовать новую версию под версией `latest`
```sh
docker push comocapital/parity:latest
```

## Test

```sh
docker build -t comocapital/parity:{VERSION} .
test/run_all.sh $VERSION
```