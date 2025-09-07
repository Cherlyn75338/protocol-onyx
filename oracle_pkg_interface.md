Package: oracle_pkg_modules

## module oracle
- structs:
  - OracleAdminCap [abilities]: id: 0x2::object::UID
  - OracleFeederCap [abilities]: id: 0x2::object::UID
  - Price [abilities]: value: U256; decimal: U8; timestamp: U64
  - PriceOracle [abilities]: id: 0x2::object::UID; version: U64; update_interval: U64; price_oracles: 0x2::table::Table<U8,0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::Price>
- functions:
  - Public fn get_token_price(&0x2::clock::Clock, &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, U8) -> (Bool, U256, U8)
  - Public entry fn register_token_price(&0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap, &0x2::clock::Clock, &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, U8, U256, U8) -> ()
  - Public entry fn set_update_interval(&0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap, &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, U64) -> ()
  - Public entry fn update_token_price(&0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, &0x2::clock::Clock, &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, U8, U256) -> ()
  - Public entry fn update_token_price_batch(&0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap, &0x2::clock::Clock, &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, vector<U8>, vector<U256>) -> ()
  - Private entry fn version_migrate(&0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap, &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) -> ()