module Hooky
  module Parity

    CONFIG_DEFAULTS = {
       # global settings
       before_deploy:                    {type: :array, of: :string, default: []},
       after_deploy:                     {type: :array, of: :string, default: []},
       hook_ref:                         {type: :string, default: "stable"},
       
       # parity settings
       chain:                              {type: :string, default: 'kovan', from: ["olympic", "frontier", "homestead", "mainnet", "morden", "ropsten", "classic", "expanse", "testnet", "kovan", "dev"]},
       rpcapi:                             {type: :array, of: :string, default: ["eth", "net", "personal", "web3"], from: ["all", "safe", "web3", "eth", "net", "personal", "parity", "parity_set", "traces", "rpc", "parity_accounts"]}
    }

  end
end