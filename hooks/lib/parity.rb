module Hooky
  module Parity
    
    CHAIN_TYPES = [
      "olympic",
      "frontier",
      "homestead",
      "mainnet",
      "morden",
      "ropsten",
      "classic",
      "expanse",
      "testnet",
      "kovan",
      "dev"
    ]
    
    JSONRPC_TYPES = [
      "all",
      "safe",
      "web3",
      "eth",
      "net",
      "personal",
      "parity",
      "parity_set",
      "traces",
      "rpc",
      "parity_accounts"
    ]
    
    DEFAULT_JSONRPC_TYPES = [
      "eth",
      "net",
      "personal",
      "web3"
    ]
    
    OPERATING_MODES = [
      'last',
      'active',
      'passive',
      'dark',
      'offline'
    ]
    
    PRUNING_MODES = [
      'auto',
      'archive',
      'fast'
    ]

    CONFIG_DEFAULTS = {
      # global settings
      before_deploy:                    {type: :array, of: :string, default: []},
      after_deploy:                     {type: :array, of: :string, default: []},
      hook_ref:                         {type: :string, default: "stable"},
       
      # parity settings
      chain:                            {type: :string, default: 'kovan', from: CHAIN_TYPES},
      rpcapi:                           {type: :array, of: :string, default: DEFAULT_JSONRPC_TYPES, from: JSONRPC_TYPES},
      logging:                          {type: :string, default: 'info'},
      mode:                             {type: :string, default: 'active', from: OPERATING_MODES},
      pruning:                          {type: :string, default: 'fast', from: PRUNING_MODES},
      basepath:                         {type: :string, default: 'parity'}
    }

  end
end