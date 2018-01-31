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
    basepath: /data/var/db/parity
```

## Publish

* Собрать 
```
docker build -t  comocapital/parity:latest .
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

## Ошибки

#### Unable to make a connection to the Parity Secure API

Необходимо сгенерировать свой authcode для бравзера.

* Подключаемся к контейнеру парити

```sh
nanobox console data.parity
```

* Запускаем signer с путём до parity db

```sh
/data/bin/parity signer new-token --base-path /app/parity/db --chain kovan
# /app это ссылка до /data/var/db/unfs
```

Программа выдаст код, а также он сохранится в файле `/app/parity/db/signer/authcodes`. Вставить код в предлагаемое поле ввода.