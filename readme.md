# nanobox-parity

Nanobox data service Parity component.

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
    min_peers: 10
    max_peers: 25
    max_pending_peers: 64
```

## Publish

* Build 
```
docker build -t  comocapital/parity:latest .
```

*  Publish the new version under the latest version `latest`
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

You need to generate your own auth code for the browser.

* Connection to the parity container

```sh
nanobox console data.parity
```

*  launch signer with path to parity db

```sh
/data/bin/parity signer new-token --base-path /app/parity/db --chain kovan
# /app это ссылка до /data/var/db/unfs
```

The app will output the code and it will be saved to file `/app/parity/db/signer/authcodes`. Put the code into the offered input field.
