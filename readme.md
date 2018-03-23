# nanobox-parity

Nanobox data service [Parity](https://github.com/paritytech/parity) component with [UNFS](https://docs.nanobox.io/app-config/network-storage/) (User-Space Network File System).

## Usage

```yml
data.parity:
  image: comocapital/nanobox-parity:latest
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
    basepath: parity/db
    min_peers: 10
    max_peers: 25
    max_pending_peers: 64

web.backend:
  network_dirs:
    data.parity:
      - parity/db
```

## UI

* To connect to UI, start two terminals and typo:

```sh
# typo in first terminal
nanobox tunnel data.parity -p 8546:8546

# typo in second one
nanobox tunnel data.parity -p 8180:8180
```

* Open the browser and typo `localhost:8180`.

Also, you can use this rule for Makefile:

```sh
# Required GNU Parallel
# Install: sudo apt install parallel
parity:
	@(echo nanobox tunnel data.parity -p 8546:8546; \
	echo nanobox tunnel data.parity -p 8180:8180) | parallel
```

## Errors

#### Unable to make a connection to the Parity Secure API

You need to generate your own auth code for the browser.

* Connect to the parity container:

```sh
nanobox console data.parity
```

* Launch signer with a path to the parity db:

```sh
# replace basepath with your actual basepath described in boxfile.yml
/data/bin/parity signer new-token --base-path /app/${basepath} --chain kovan
# `/app` is a symbolic link to `/data/var/db/unfs`
```

The app will output the code and it will be saved to the file `/app/${basepath}/signer/authcodes`. Put the code into the offered input field.
