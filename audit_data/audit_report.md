## Modules and public/entry functions (from on-chain normalized metadata)

### account
- Public fun account::account::account_owner(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (Address)

### calculator
- Public fun calculator::calculator::caculate_utilization(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun calculator::calculator::calculate_amount(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U256,U8) -> (U256)
- Public fun calculator::calculator::calculate_borrow_rate(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun calculator::calculator::calculate_compounded_interest(U256,U256) -> (U256)
- Public fun calculator::calculator::calculate_linear_interest(U256,U256) -> (U256)
- Public fun calculator::calculator::calculate_supply_rate(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> (U256)
- Public fun calculator::calculator::calculate_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U256,U8) -> (U256)

### constants
- Public fun constants::constants::FlashLoanMultiple() -> (U64)
- Public fun constants::constants::max_number_of_reserves() -> (U8)
- Public fun constants::constants::option_type_borrow() -> (U8)
- Public fun constants::constants::option_type_repay() -> (U8)
- Public fun constants::constants::option_type_supply() -> (U8)
- Public fun constants::constants::option_type_withdraw() -> (U8)
- Public fun constants::constants::percentage_benchmark() -> (U64)
- Public fun constants::constants::seconds_per_year() -> (U256)
- Public fun constants::constants::version() -> (U64)

### dynamic_calculator
- Public fun dynamic_calculator::dynamic_calculator::calculate_current_index(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_caculate_utilization(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_calculate_apy<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,U64,Bool) -> (U256,U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_calculate_borrow_rate(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_calculate_supply_rate(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256,U256,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_health_factor<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,Address,U8,U64,U64,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_liquidation_threshold(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,Address,U8,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_collateral_balance(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_collateral_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_health_collateral_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address,U8,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_health_loan_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address,U8,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_loan_balance(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address,U256,Bool) -> (U256)
- Public fun dynamic_calculator::dynamic_calculator::dynamic_user_loan_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address,U256,Bool) -> (U256)

### error
- Public fun error::error::duplicate_config() -> (U64)
- Public fun error::error::duplicate_reserve() -> (U64)
- Public fun error::error::exceeded_maximum_borrow_cap() -> (U64)
- Public fun error::error::exceeded_maximum_deposit_cap() -> (U64)
- Public fun error::error::incorrect_version() -> (U64)
- Public fun error::error::insufficient_balance() -> (U64)
- Public fun error::error::invalid_amount() -> (U64)
- Public fun error::error::invalid_coin_type() -> (U64)
- Public fun error::error::invalid_duration_time() -> (U64)
- Public fun error::error::invalid_funds() -> (U64)
- Public fun error::error::invalid_option() -> (U64)
- Public fun error::error::invalid_pool() -> (U64)
- Public fun error::error::invalid_price() -> (U64)
- Public fun error::error::invalid_user() -> (U64)
- Public fun error::error::invalid_value() -> (U64)
- Public fun error::error::ltv_is_not_enough() -> (U64)
- Public fun error::error::no_more_reserves_allowed() -> (U64)
- Public fun error::error::non_single_value() -> (U64)
- Public fun error::error::not_available_version() -> (U64)
- Public fun error::error::not_owner() -> (U64)
- Public fun error::error::paused() -> (U64)
- Public fun error::error::pool_not_found() -> (U64)
- Public fun error::error::price_feed_not_found() -> (U64)
- Public fun error::error::required_parent_account_cap() -> (U64)
- Public fun error::error::reserve_not_found() -> (U64)
- Public fun error::error::rule_not_found() -> (U64)
- Public fun error::error::user_have_no_collateral() -> (U64)
- Public fun error::error::user_have_no_loan() -> (U64)
- Public fun error::error::user_is_healthy() -> (U64)
- Public fun error::error::user_is_unhealthy() -> (U64)

### flash_loan
- Public fun flash_loan::flash_loan::get_asset<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config) -> (Address,U8,vector<U8>,Address,U64,U64,U64,U64)
- Public fun flash_loan::flash_loan::parsed_receipt<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>) -> (Address,Address,U64,Address,U64,U64)
- Public fun flash_loan::flash_loan::version_migrate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config) -> ()
- Public fun flash_loan::flash_loan::version_verification(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config) -> ()

### incentive
- Public entry [entry] fun incentive::incentive::add_pool<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&0x0x2::clock::Clock,U8,U64,U64,0x0x2::coin::Coin<T0>,U64,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive::incentive::claim_reward<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::IncentiveBal<T0>,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive::incentive::claim_reward_non_entry<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::IncentiveBal<T0>,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive::incentive::claim_reward_with_account_cap<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::IncentiveBal<T0>,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive::incentive::create_and_transfer_ownership(Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive::incentive::earned(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0x2::clock::Clock,U8,Address) -> (vector<0x0x1::ascii::String>,vector<U256>,vector<U8>)
- Public fun incentive::incentive::get_pool_count(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,U8) -> (U64)
- Public fun incentive::incentive::get_pool_info(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,U8,U64) -> (U64,U64,U256,U8)
- Public fun incentive::incentive::set_admin(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,U256,Bool,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive::incentive::set_owner(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,U256,Bool,&mut 0x0x2::tx_context::TxContext) -> ()

### incentive_v2
- Public fun incentive_v2::incentive_v2::add_funds<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::borrow_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::calculate_one_from_pool(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,Address,U64,U256,Address,U256) -> (U256,U256)
- Public fun incentive_v2::incentive_v2::calculate_release_rate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentivePool) -> (U256)
- Public fun incentive_v2::incentive_v2::calculate_user_effective_amount(U8,U256,U256,U256) -> (U256)
- Public entry [entry] fun incentive_v2::incentive_v2::claim_reward<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::claim_reward_non_entry<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U8,&0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::claim_reward_with_account_cap<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U8,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::create_and_transfer_owner(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::create_funds_pool<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,U8,Bool,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::create_incentive(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::create_incentive_pool<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,U64,U64,U64,U64,U64,U8,U8,U256,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::deposit_with_account_cap<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_deposit_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::coin::Coin<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::entry_repay_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v2::incentive_v2::entry_withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::freeze_incentive_pool(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,U64) -> ()
- Public fun incentive_v2::incentive_v2::get_active_pools(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,U8,U8,U64) -> (vector<Address>)
- Public fun incentive_v2::incentive_v2::get_funds_info(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,Address) -> (Address,U8,0x0x1::type_name::TypeName)
- Public fun incentive_v2::incentive_v2::get_funds_value<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>) -> (U64)
- Public fun incentive_v2::incentive_v2::get_inactive_pool_objects(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) -> (vector<Address>)
- Public fun incentive_v2::incentive_v2::get_pool_from_asset_and_option(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,U8,U8) -> (vector<Address>,vector<Address>,vector<Address>)
- Public fun incentive_v2::incentive_v2::get_pool_from_funds_pool<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,U8,U8) -> (vector<Address>)
- Public fun incentive_v2::incentive_v2::get_pool_info(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,Address) -> (Address,U64,Address,U64,U64,U64,U64,U8,U8,U256,U64,U64,U256)
- Public fun incentive_v2::incentive_v2::get_pool_length(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) -> (U64)
- Public fun incentive_v2::incentive_v2::get_pool_objects(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) -> (vector<Address>)
- Public fun incentive_v2::incentive_v2::get_total_claimed_from_user(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,Address,Address) -> (U256)
- Public fun incentive_v2::incentive_v2::liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::balance::Balance<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T1>,0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::option_borrow() -> (U8)
- Public fun incentive_v2::incentive_v2::option_repay() -> (U8)
- Public fun incentive_v2::incentive_v2::option_supply() -> (U8)
- Public fun incentive_v2::incentive_v2::option_withdraw() -> (U8)
- Public fun incentive_v2::incentive_v2::repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::repay_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::version_migrate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) -> ()
- Public fun incentive_v2::incentive_v2::version_verification(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive) -> ()
- Public fun incentive_v2::incentive_v2::withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v2::incentive_v2::withdraw_funds<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v2::incentive_v2::withdraw_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)

### incentive_v3
- Public fun incentive_v3::incentive_v3::borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::borrow_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::claim_reward<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,vector<0x0x1::ascii::String>,vector<Address>,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public entry [entry] fun incentive_v3::incentive_v3::claim_reward_entry<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,vector<0x0x1::ascii::String>,vector<Address>,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v3::incentive_v3::claim_reward_with_account_cap<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,vector<0x0x1::ascii::String>,vector<Address>,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::contains_rule(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool,U8,0x0x1::ascii::String) -> (Bool)
- Public fun incentive_v3::incentive_v3::deposit_with_account_cap<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_deposit_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::coin::Coin<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v3::incentive_v3::entry_repay_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun incentive_v3::incentive_v3::entry_withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun incentive_v3::incentive_v3::get_balance_value_by_reward_fund<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>) -> (U64)
- Public fun incentive_v3::incentive_v3::get_effective_balance(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256,U256,U256,U256)
- Public fun incentive_v3::incentive_v3::get_pool_info(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool) -> (Address,U8,0x0x1::ascii::String,&0x0x2::vec_map::VecMap<Address,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule>)
- Public fun incentive_v3::incentive_v3::get_rule_info(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule) -> (Address,U8,Bool,0x0x1::ascii::String,U256,U64,U256,&0x0x2::table::Table<Address,U256>,&0x0x2::table::Table<Address,U256>,&0x0x2::table::Table<Address,U256>)
- Public fun incentive_v3::incentive_v3::get_user_claimable_rewards(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,Address) -> (vector<0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::ClaimableReward>)
- Public fun incentive_v3::incentive_v3::get_user_index_by_rule(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule,Address) -> (U256)
- Public fun incentive_v3::incentive_v3::get_user_rewards_claimed_by_rule(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule,Address) -> (U256)
- Public fun incentive_v3::incentive_v3::get_user_total_rewards_by_rule(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Rule,Address) -> (U256)
- Public fun incentive_v3::incentive_v3::liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::balance::Balance<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T1>,0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::parse_claimable_rewards(vector<0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::ClaimableReward>) -> (vector<0x0x1::ascii::String>,vector<0x0x1::ascii::String>,vector<U256>,vector<U256>,vector<vector<Address>>)
- Public fun incentive_v3::incentive_v3::pools(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) -> (&0x0x2::vec_map::VecMap<0x0x1::ascii::String,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::AssetPool>)
- Public fun incentive_v3::incentive_v3::repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::repay_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::update_reward_state_by_asset<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> ()
- Public fun incentive_v3::incentive_v3::version(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) -> (U64)
- Public fun incentive_v3::incentive_v3::version_verification(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) -> ()
- Public fun incentive_v3::incentive_v3::withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public fun incentive_v3::incentive_v3::withdraw_with_account_cap<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)

### lending
- Public entry [entry] fun lending::lending::borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun lending::lending::create_account(&mut 0x0x2::tx_context::TxContext) -> (0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap)
- Public fun lending::lending::delete_account(0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> ()
- Public entry [entry] fun lending::lending::deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun lending::lending::flash_loan_with_account_cap<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>)
- Public fun lending::lending::flash_loan_with_ctx<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>)
- Public fun lending::lending::flash_repay_with_account_cap<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>,0x0x2::balance::Balance<T0>,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap) -> (0x0x2::balance::Balance<T0>)
- Public fun lending::lending::flash_repay_with_ctx<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Receipt<T0>,0x0x2::balance::Balance<T0>,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)
- Public entry [entry] fun lending::lending::liquidation_call<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,0x0x2::coin::Coin<T0>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun lending::lending::repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry [entry] fun lending::lending::withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()

### logic
- Public fun logic::logic::calculate_avg_ltv(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (U256)
- Public fun logic::logic::calculate_avg_threshold(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (U256)
- Public fun logic::logic::dynamic_liquidation_threshold(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,Address) -> (U256)
- Public fun logic::logic::is_collateral(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (Bool)
- Public fun logic::logic::is_health(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (Bool)
- Public fun logic::logic::is_loan(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (Bool)
- Public fun logic::logic::user_collateral_balance(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256)
- Public fun logic::logic::user_collateral_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256)
- Public fun logic::logic::user_health_collateral_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (U256)
- Public fun logic::logic::user_health_factor(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,Address) -> (U256)
- Public fun logic::logic::user_health_factor_batch(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,vector<Address>) -> (vector<U256>)
- Public fun logic::logic::user_health_loan_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (U256)
- Public fun logic::logic::user_loan_balance(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256)
- Public fun logic::logic::user_loan_value(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256)

### manage
- Public fun manage::manage::create_flash_loan_asset<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,U64,U64,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::create_flash_loan_config(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::create_incentive_v3(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::create_incentive_v3_pool<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::create_incentive_v3_reward_fund<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::create_incentive_v3_rule<T0,T1>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::deposit_incentive_v3_reward_fund<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::disable_incentive_v3_by_rule_id<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::enable_incentive_v3_by_rule_id<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::incentive_v3_version_migrate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) -> ()
- Public fun manage::manage::set_flash_loan_asset_max<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,U64) -> ()
- Public fun manage::manage::set_flash_loan_asset_min<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,U64) -> ()
- Public fun manage::manage::set_flash_loan_asset_rate_to_supplier<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,U64) -> ()
- Public fun manage::manage::set_flash_loan_asset_rate_to_treasury<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config,U64) -> ()
- Public fun manage::manage::set_incentive_v3_borrow_fee_rate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::set_incentive_v3_max_reward_rate_by_rule_id<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,Address,U64,U64) -> ()
- Public fun manage::manage::set_incentive_v3_reward_rate_by_rule_id<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::OwnerCap,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address,U64,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::withdraw_borrow_fee<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,U64,Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun manage::manage::withdraw_incentive_v3_reward_fund<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,U64,Address,&mut 0x0x2::tx_context::TxContext) -> ()

### pool
- Public fun pool::pool::convert_amount(U64,U8,U8) -> (U64)
- Public fun pool::pool::get_coin_decimal<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) -> (U8)
- Public fun pool::pool::normal_amount<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64) -> (U64)
- Public fun pool::pool::uid<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) -> (&0x0x2::object::UID)
- Public fun pool::pool::unnormal_amount<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64) -> (U64)
- Public fun pool::pool::withdraw_treasury<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::PoolAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64,Address,&mut 0x0x2::tx_context::TxContext) -> ()

### ray_math
- Public fun ray_math::ray_math::half_ray() -> (U256)
- Public fun ray_math::ray_math::half_wad() -> (U256)
- Public fun ray_math::ray_math::ray() -> (U256)
- Public fun ray_math::ray_math::ray_div(U256,U256) -> (U256)
- Public fun ray_math::ray_math::ray_mul(U256,U256) -> (U256)
- Public fun ray_math::ray_math::ray_to_wad(U256) -> (U256)
- Public fun ray_math::ray_math::wad() -> (U256)
- Public fun ray_math::ray_math::wad_div(U256,U256) -> (U256)
- Public fun ray_math::ray_math::wad_mul(U256,U256) -> (U256)
- Public fun ray_math::ray_math::wad_to_ray(U256) -> (U256)

### safe_math
- Public fun safe_math::safe_math::add(U256,U256) -> (U256)
- Public fun safe_math::safe_math::div(U256,U256) -> (U256)
- Public fun safe_math::safe_math::min(U256,U256) -> (U256)
- Public fun safe_math::safe_math::mod(U256,U256) -> (U256)
- Public fun safe_math::safe_math::mul(U256,U256) -> (U256)
- Public fun safe_math::safe_math::sub(U256,U256) -> (U256)

### storage
- Public fun storage::storage::destory_user(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public fun storage::storage::get_asset_ltv(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun storage::storage::get_borrow_cap_ceiling_ratio(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun storage::storage::get_borrow_rate_factors(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256,U256,U256,U256)
- Public fun storage::storage::get_coin_type(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (0x0x1::ascii::String)
- Public fun storage::storage::get_current_rate(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256)
- Public fun storage::storage::get_index(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256)
- Public fun storage::storage::get_last_update_timestamp(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U64)
- Public fun storage::storage::get_liquidation_factors(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256,U256)
- Public fun storage::storage::get_oracle_id(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U8)
- Public fun storage::storage::get_reserve_for_testing(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::ReserveData)
- Public fun storage::storage::get_reserves_count(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> (U8)
- Public fun storage::storage::get_supply_cap_ceiling(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun storage::storage::get_total_supply(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256,U256)
- Public fun storage::storage::get_treasury_balance(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun storage::storage::get_treasury_factor(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8) -> (U256)
- Public fun storage::storage::get_user_assets(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address) -> (vector<U8>,vector<U8>)
- Public fun storage::storage::get_user_balance(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Address) -> (U256,U256)
- Public entry [entry] fun storage::storage::init_reserve<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::PoolAdminCap,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Bool,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,&0x0x2::coin::CoinMetadata<T0>,&mut 0x0x2::tx_context::TxContext) -> ()
- Public fun storage::storage::pause(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> (Bool)
- Public fun storage::storage::reserve_validation<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public fun storage::storage::set_base_rate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_borrow_cap(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_jump_rate_multiplier(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_liquidation_bonus(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_liquidation_ratio(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_liquidation_threshold(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_ltv(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_multiplier(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_optimal_utilization(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public entry [entry] fun storage::storage::set_pause(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Bool) -> ()
- Public fun storage::storage::set_reserve_factor(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_supply_cap(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun storage::storage::set_treasury_factor(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public entry [entry] fun storage::storage::version_migrate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public fun storage::storage::version_verification(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public fun storage::storage::when_not_paused(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public fun storage::storage::withdraw_treasury<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::PoolAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U64,Address,&mut 0x0x2::tx_context::TxContext) -> ()

### utils
- Public fun utils::utils::split_coin<T0>(0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::coin::Coin<T0>)
- Public fun utils::utils::split_coin_to_balance<T0>(0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> (0x0x2::balance::Balance<T0>)

### validation
- Public fun validation::validation::validate_borrow<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun validation::validation::validate_deposit<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun validation::validation::validate_liquidate<T0,T1>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U8,U256) -> ()
- Public fun validation::validation::validate_repay<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()
- Public fun validation::validation::validate_withdraw<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U256) -> ()

### version
- Public fun version::version::next_version() -> (U64)
- Public fun version::version::pre_check_version(U64) -> ()
- Public fun version::version::this_version() -> (U64)

### oracle
- Public fun oracle::oracle::get_token_price(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U8) -> (Bool,U256,U8)
- Public entry [entry] fun oracle::oracle::register_token_price(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U8,U256,U8) -> ()
- Public entry [entry] fun oracle::oracle::set_update_interval(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U64) -> ()
- Public entry [entry] fun oracle::oracle::update_token_price(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U8,U256) -> ()
- Public entry [entry] fun oracle::oracle::update_token_price_batch(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,vector<U8>,vector<U256>) -> ()
- Private entry [entry] fun oracle::oracle::version_migrate(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle) -> ()

## Capabilities and admin-like structs
- struct account::AccountCap abilities={'abilities': ['Store', 'Key']}
- struct incentive::IncentiveAdminCap abilities={'abilities': ['Store', 'Key']}
- struct incentive::IncentiveOwnerCap abilities={'abilities': ['Store', 'Key']}
- struct incentive_v2::OwnerCap abilities={'abilities': ['Store', 'Key']}
- struct pool::PoolAdminCap abilities={'abilities': ['Store', 'Key']}
- struct storage::OwnerCap abilities={'abilities': ['Store', 'Key']}
- struct storage::StorageAdminCap abilities={'abilities': ['Store', 'Key']}
- struct oracle::OracleAdminCap abilities={'abilities': ['Store', 'Key']}
- struct oracle::OracleFeederCap abilities={'abilities': ['Store', 'Key']}

## Audit findings (skeleton per function)

#### account::account::account_owner
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::caculate_utilization
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_amount
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_borrow_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_compounded_interest
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_linear_interest
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_supply_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### calculator::calculator::calculate_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::FlashLoanMultiple
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::max_number_of_reserves
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::option_type_borrow
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::option_type_repay
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::option_type_supply
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::option_type_withdraw
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::percentage_benchmark
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::seconds_per_year
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### constants::constants::version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::calculate_current_index
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_caculate_utilization
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_calculate_apy<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_calculate_borrow_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_calculate_supply_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_health_factor<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_liquidation_threshold
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_collateral_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_collateral_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_health_collateral_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_health_loan_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_loan_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### dynamic_calculator::dynamic_calculator::dynamic_user_loan_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::duplicate_config
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::duplicate_reserve
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::exceeded_maximum_borrow_cap
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::exceeded_maximum_deposit_cap
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::incorrect_version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::insufficient_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_amount
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_coin_type
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_duration_time
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_funds
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_option
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_pool
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_price
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_user
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::invalid_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::ltv_is_not_enough
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::no_more_reserves_allowed
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::non_single_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::not_available_version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::not_owner
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::paused
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::pool_not_found
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::price_feed_not_found
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::required_parent_account_cap
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::reserve_not_found
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::rule_not_found
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::user_have_no_collateral
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::user_have_no_loan
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::user_is_healthy
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### error::error::user_is_unhealthy
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### flash_loan::flash_loan::get_asset<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### flash_loan::flash_loan::parsed_receipt<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### flash_loan::flash_loan::version_migrate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### flash_loan::flash_loan::version_verification
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::add_pool<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::claim_reward<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::claim_reward_non_entry<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::claim_reward_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::create_and_transfer_ownership
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::earned
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::get_pool_count
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::get_pool_info
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::set_admin
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive::incentive::set_owner
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::add_funds<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::borrow_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::calculate_one_from_pool
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::calculate_release_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::calculate_user_effective_amount
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::claim_reward<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::claim_reward_non_entry<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::claim_reward_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::create_and_transfer_owner
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::create_funds_pool<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::create_incentive
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::create_incentive_pool<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::deposit_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_deposit<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_deposit_on_behalf_of_user<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_liquidation<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_repay_on_behalf_of_user<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::entry_withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::freeze_incentive_pool
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_active_pools
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_funds_info
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_funds_value<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_inactive_pool_objects
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_pool_from_asset_and_option
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_pool_from_funds_pool<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_pool_info
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_pool_length
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_pool_objects
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::get_total_claimed_from_user
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::liquidation<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::option_borrow
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::option_repay
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::option_supply
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::option_withdraw
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::repay_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::version_migrate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::version_verification
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::withdraw_funds<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v2::incentive_v2::withdraw_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::borrow_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::claim_reward<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::claim_reward_entry<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::claim_reward_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::contains_rule
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::deposit_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_deposit<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_deposit_on_behalf_of_user<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_liquidation<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_repay_on_behalf_of_user<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::entry_withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_balance_value_by_reward_fund<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_effective_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_pool_info
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_rule_info
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_user_claimable_rewards
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_user_index_by_rule
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_user_rewards_claimed_by_rule
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::get_user_total_rewards_by_rule
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::liquidation<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::parse_claimable_rewards
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::pools
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::repay_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::update_reward_state_by_asset<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::version_verification
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### incentive_v3::incentive_v3::withdraw_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Critical
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::create_account
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Critical
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::delete_account
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Critical
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::deposit<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::flash_loan_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::flash_loan_with_ctx<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::flash_repay_with_account_cap<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::flash_repay_with_ctx<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::liquidation_call<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Critical
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### lending::lending::withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Critical
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::calculate_avg_ltv
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::calculate_avg_threshold
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::dynamic_liquidation_threshold
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::is_collateral
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::is_health
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::is_loan
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_collateral_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_collateral_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_health_collateral_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_health_factor
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_health_factor_batch
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_health_loan_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_loan_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### logic::logic::user_loan_value
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_flash_loan_asset<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_flash_loan_config
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_incentive_v3
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_incentive_v3_pool<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_incentive_v3_reward_fund<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::create_incentive_v3_rule<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::deposit_incentive_v3_reward_fund<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::disable_incentive_v3_by_rule_id<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::enable_incentive_v3_by_rule_id<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::incentive_v3_version_migrate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_flash_loan_asset_max<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_flash_loan_asset_min<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_flash_loan_asset_rate_to_supplier<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_flash_loan_asset_rate_to_treasury<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_incentive_v3_borrow_fee_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_incentive_v3_max_reward_rate_by_rule_id<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::set_incentive_v3_reward_rate_by_rule_id<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::withdraw_borrow_fee<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### manage::manage::withdraw_incentive_v3_reward_fund<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::convert_amount
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Medium
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::get_coin_decimal<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Medium
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::normal_amount<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Medium
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::uid<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Medium
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::unnormal_amount<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Medium
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### pool::pool::withdraw_treasury<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::half_ray
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::half_wad
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::ray
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::ray_div
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::ray_mul
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::ray_to_wad
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::wad
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::wad_div
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::wad_mul
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### ray_math::ray_math::wad_to_ray
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::add
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::div
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::min
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::mod
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::mul
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### safe_math::safe_math::sub
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::destory_user
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_asset_ltv
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_borrow_cap_ceiling_ratio
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_borrow_rate_factors
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_coin_type
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_current_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_index
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_last_update_timestamp
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_liquidation_factors
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_oracle_id
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_reserve_for_testing
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_reserves_count
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_supply_cap_ceiling
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_total_supply
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_treasury_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_treasury_factor
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_user_assets
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::get_user_balance
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::init_reserve<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::pause
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::reserve_validation<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_base_rate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_borrow_cap
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_jump_rate_multiplier
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_liquidation_bonus
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_liquidation_ratio
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_liquidation_threshold
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_ltv
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_multiplier
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_optimal_utilization
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_pause
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_reserve_factor
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_supply_cap
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::set_treasury_factor
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::version_migrate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::version_verification
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::when_not_paused
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### storage::storage::withdraw_treasury<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### utils::utils::split_coin<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### utils::utils::split_coin_to_balance<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### validation::validation::validate_borrow<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### validation::validation::validate_deposit<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### validation::validation::validate_liquidate<T0,T1>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### validation::validation::validate_repay<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### validation::validation::validate_withdraw<T0>
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### version::version::next_version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### version::version::pre_check_version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### version::version::this_version
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: Low
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::get_token_price
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::register_token_price
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::set_update_interval
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::update_token_price
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::update_token_price_batch
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO

#### oracle::oracle::version_migrate
- Potential vulnerabilities: TODO (analyze math, access control, coin flow)
- Impact category: High
- Exploit path: TODO
- Attack scenario: TODO
- Suggested mitigation: TODO
### Targeted risk notes
- lending::deposit/borrow/repay/withdraw/liquidation_call: Verify price freshness, scaling to pool decimals, accrue-before-action, utilization/rate bounds, rounding direction in collateral checks, and dust handling for Coin splits/merges.
- storage::init_reserve/set_*: Gate by OwnerCap; validate parameter ranges; prevent zero divisors; enforce invariant-compatible updates (e.g., reserve_factor < 1e18).
- oracle::update_token_price/register_token_price/set_update_interval: Enforce Feeder/Admin caps; guard with Clock-based staleness; check decimals/exponent bounds and nonzero prices; monotonic timestamp updates.
- flash_loan::*: Max amount, fee computation precision, repay-in-same-tx guarantee, and handling of unreturned dust.
- math modules (ray_math/safe_math/calculator/dynamic_calculator): Ensure multiply-then-divide with u256 widening, saturating/checked ops, and consistent use of wad/ray scales.
- incentive_v2/v3 entries: Accrual before state transitions, reward index updates are monotonic, and rewards cannot be double-claimed; admin knobs bounded.
- manage/pool withdrawals: Treasury withdrawals gated by PoolAdminCap; event emissions reflect post-state.

## Friend exposures
- account -> ['lending']
- flash_loan -> ['lending', 'manage']
- incentive -> ['incentive_v2', 'lending']
- incentive_v2 -> ['incentive_v3']
- incentive_v3 -> ['manage']
- lending -> ['incentive_v2', 'incentive_v3']
- logic -> ['flash_loan', 'lending']
- pool -> ['flash_loan', 'lending', 'storage']
- storage -> ['flash_loan', 'logic']

## High-risk entry points (priority review)
### lending
### storage
### manage
### oracle
### incentive_v2
### incentive_v3
### flash_loan
### calculator
### dynamic_calculator
### logic
### ray_math
### safe_math
- Public entry fun incentive::add_pool<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&0x0x2::clock::Clock,U8,U64,U64,0x0x2::coin::Coin<T0>,U64,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive::claim_reward<T0>(&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::IncentiveBal<T0>,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Address,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::claim_reward<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,U8,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_deposit_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::coin::Coin<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v2::entry_withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::claim_reward_entry<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>,vector<0x0x1::ascii::String>,vector<Address>,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_deposit_on_behalf_of_user<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_liquidation<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,0x0x2::coin::Coin<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun incentive_v3::entry_withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun lending::borrow<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun lending::deposit<T0>(&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun lending::liquidation_call<T0,T1>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>,0x0x2::coin::Coin<T0>,Address,U64,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun lending::repay<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,0x0x2::coin::Coin<T0>,U64,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun lending::withdraw<T0>(&0x0x2::clock::Clock,&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>,U8,U64,Address,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun storage::init_reserve<T0>(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::PoolAdminCap,&0x0x2::clock::Clock,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,U8,Bool,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,U256,&0x0x2::coin::CoinMetadata<T0>,&mut 0x0x2::tx_context::TxContext) -> ()
- Public entry fun storage::set_pause(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::OwnerCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,Bool) -> ()
- Public entry fun storage::version_migrate(&0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::StorageAdminCap,&mut 0x0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage) -> ()
- Public entry fun oracle::register_token_price(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U8,U256,U8) -> ()
- Public entry fun oracle::set_update_interval(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleAdminCap,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U64) -> ()
- Public entry fun oracle::update_token_price(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,U8,U256) -> ()
- Public entry fun oracle::update_token_price_batch(&0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::OracleFeederCap,&0x0x2::clock::Clock,&mut 0x0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle,vector<U8>,vector<U256>) -> ()


## Detailed adversarial findings (initial pass)

### lending::borrow<T>
- Potential vulnerabilities: No explicit accrue() call in signature; risk of using stale indices. Oracle freshness/decimals not visible at interface; borrow amount may be checked via validation::validate_borrow, but rounding direction on collateral check unknown. U256 math must multiply-then-divide; utilization/rate bounds must be enforced; division-by-zero if totalSupply=0 when computing rates.
- Impact category: Critical
- Exploit path: Borrow immediately after rate spike without accrual, extract underpriced debt; or use manipulated/stale price via oracle if stale not enforced; edge-case borrow when pool totals are zero causing abort/DoS.
- Attack scenario: Price Oracle reports old high collateral price; user calls borrow with minimal collateral; post-price update system insolvent. Alternatively, rounding-up borrowable in ltv calc allows extracting more than intended.
- Suggested mitigation: Force accrue before state-changing ops; enforce oracle freshness and decimals alignment; check nonzero denominators; cap per-tx borrow with close factor-like constraint under volatility; unit tests for rounding.

### lending::repay<T>
- Potential vulnerabilities: Rounding could leave dust debt unrepayable; repay before/after accrue ordering matters for interest consistency; repay of zero or tiny amounts may bypass fee floors.
- Impact category: High
- Exploit path: Split many tiny repays to avoid interest/fees rounding; grief by leaving user in perpetual small debt due to rounding up on interest index.
- Suggested mitigation: Minimum repay amount; deterministic rounding mode; accrue before repay; sweep dust to treasury or zero-out under epsilon with event.

### lending::withdraw<T>
- Potential vulnerabilities: Health check rounding direction could allow withdrawing to unsafe levels; price scale mismatch; not accruing before withdraw allows using outdated lower debt.
- Impact category: Critical
- Exploit path: Front-run price drop with withdraw using stale price; rounding-down collateral value check passes marginally.
- Suggested mitigation: Accrue; strict oracle staleness; use conservative rounding (ceil on debt, floor on collateral).

### lending::deposit<T>
- Potential vulnerabilities: Supply cap enforcement; coin split/merge dust; decimals normalization to pool units; reentrancy via friend modules is low in Move but ensure no callbacks.
- Impact category: Medium
- Suggested mitigation: Enforce supply caps; normalize amount with coin metadata decimals; emit events post-state.

### lending::liquidation_call<T0,T1>
- Potential vulnerabilities: Close factor enforcement; liquidation incentive rounding; seize calculation precision; price staleness. Partial repay rounding could allow value extraction or block liquidation.
- Impact category: Critical
- Exploit path: Liquidator cherry-picks rounding to seize more collateral; or borrow token with low decimals causing mis-seize.
- Suggested mitigation: Multiply-then-divide with u256; ceil repay needed; floor seized collateral; verify incentive bounds; TWAP/staleness checks.

### storage::init_reserve<T>
- Potential vulnerabilities: Many parameters; require strict bounds (ltv<threshold<1, bonus>1, caps nonzero); decimals from CoinMetadata must align. Risk of division-by-zero setting base indices to zero.
- Impact category: High
- Suggested mitigation: Validate ranges; initialize indices to 1e27-style scales; emit versioned event.

### storage::set_* (all setters)
- Potential vulnerabilities: OwnerCap required but also check monotonicity and safe ranges; sudden param spikes can brick positions or open insolvency.
- Impact category: High
- Suggested mitigation: Parameter guards (e.g., 0 <= reserve_factor < 1e18, liquidation_ratio within band); timelock or 2-step change; eventing.

### storage::set_pause
- Potential vulnerabilities: Pause semantics must not block debt repayment or liquidation; ensure only non-critical paths are paused.
- Impact category: High
- Suggested mitigation: Allow repay/liquidation while paused; emit event.

### oracle::update_token_price / update_token_price_batch
- Potential vulnerabilities: FeederCap auth required; enforce minimum update interval using Clock; ensure price>0, decimals within bounds, monotonic timestamp. Batch vector lengths must match. Overflow in scaling.
- Impact category: High
- Suggested mitigation: Require now - last_update >= interval; reject zero/absurd price; cap exponent; emit event per asset; safe u256 math.

### oracle::get_token_price
- Potential vulnerabilities: Returns Bool, U256, U8; callers must reject stale/invalid; ensure unit documentation matches lending expectations.
- Impact category: High
- Suggested mitigation: Provide explicit status enum; expose last_updated timestamp; document scale.

### ray_math/safe_math/calculator/dynamic_calculator
- Potential vulnerabilities: Ensure wad/ray constants are correct; ray_mul/div widen and round toward zero consistently; compounded interest uses exp approximation with bounds; utilization cannot exceed 1e18; no division by zero when total_supply=0.
- Impact category: High
- Suggested mitigation: Use u256 widening; multiply-then-divide; clamp inputs; tests for boundary conditions and large time deltas.

### flash_loan::*
- Potential vulnerabilities: Rate to supplier/treasury computation precision; enforce repay in same tx; max/min per asset; receipt parsing integrity; prevent underpayment via rounding.
- Impact category: High
- Suggested mitigation: Use exact-fee formula with ceil; assert returned balance >= principal+fee; cap amounts.

### incentive_v2/v3 entries
- Potential vulnerabilities: Reward index update order relative to deposit/withdraw/borrow/repay; per-rule caps; freeze logic; double-claim via account cap paths; batch processing gas/DoS.
- Impact category: High
- Suggested mitigation: Update indices before balance changes; non-reentrant pattern; event on claim; cap rules and pools length; min claim amount.

## Protocol invariants and red-flags
- Sum(user_supply) = total_supply + treasury_reserve (per asset).
- Sum(user_debt) = total_debt (per asset); indices monotonic.
- Accrual: debt and indices never decrease with time.
- Oracle: prices fresh (now - last_update <= interval); price>0; decimals consistent.
- Liquidation: close factor <= 1, incentive within bounds, rounding favors safety.
- Access control: all setters gated by OwnerCap/PoolAdminCap; no friend-only bypass grants unintended powers.
- Loops: no unbounded iteration over user-controlled vectors/tables on shared objects.

## Suggested concrete tests
- Extreme decimals: asset with 0/2/6/9 decimals across deposit/borrow/liquidation.
- Zero totals: borrow/supply rate when total supply or debt is zero.
- Large time jumps: accrual with 0, 1, 1e6 seconds; check bounds.
- Rounding adversary: repay in many small chunks; liquidation edge rounding.
- Oracle staleness: attempt borrow/withdraw with stale price; ensure rejection.
- Flash underpay: attempt repay principal+fee-1; ensure abort.


### lending::borrow<T>
- Potential vulnerabilities: Accrual omission; stale price; utilization/rate overflow; rounding-up on borrowable; zero-supply division.
- Impact category: Critical
- Exploit path: 1) Ensure minimal collateral; 2) Borrow just before oracle update; 3) Indices not accrued -> underpriced debt; 4) Withdraw; 5) Oracle updates -> insolvency.
- Attack scenario: Volatile market; oracle interval large; user passes health check due to stale high collateral price.
- Suggested mitigation: Accrue-before-action; enforce price freshness (Clock delta<=interval); ceil debt, floor collateral; guard nonzero totals; cap per-tx borrow.


### lending::withdraw<T>
- Potential vulnerabilities: Health check rounding; stale oracle; decimals mismatch; no accrue-before-withdraw.
- Impact category: Critical
- Exploit path: 1) Deposit; 2) Price falls; 3) Withdraw using stale price/indices; 4) Position becomes insolvent post-update.
- Attack scenario: Close-to-threshold account exploits downward rounding to pass.
- Suggested mitigation: Accrue; check fresh price; floor collateral value; ceil debt; minimum residual collateral.


### lending::liquidation_call<T0,T1>
- Potential vulnerabilities: Close factor unchecked; seize calc rounding; seize more via decimals skew; price staleness.
- Impact category: Critical
- Exploit path: 1) Manipulate amount to trigger rounding in favor of liquidator; 2) Seize > intended; 3) Repeat across assets.
- Attack scenario: Borrow asset 9 decimals, collateral 0 decimals -> precision asymmetry exploited.
- Suggested mitigation: Multiply-then-divide in u256; cap close factor; floor seized collateral; ceil repay; align units explicitly.


### lending::repay<T>
- Potential vulnerabilities: Dust debt due to rounding; fee bypass via micro-repays; ordering with accrual.
- Impact category: High
- Exploit path: Automate many tiny repays so fee/interest rounds to zero each time.
- Attack scenario: Bot splits coin to 1-unit pieces to amortize rounding losses to protocol.
- Suggested mitigation: Minimum repay; aggregate rounding; accrue before repay; epsilon-forgive small residuals sent to treasury.


### lending::deposit<T>
- Potential vulnerabilities: Supply cap missing; decimals normalization errors; dust loss on splits.
- Impact category: Medium
- Exploit path: Deposit exceeds cap or normalizes incorrectly causing accounting drift.
- Attack scenario: Asset with unusual decimals leads to over-credit of supply index.
- Suggested mitigation: Enforce caps; normalize via metadata decimals; emit events and assert invariants.


### storage::init_reserve<T>
- Potential vulnerabilities: Unbounded parameters; zero divisors; mis-set indices; inconsistent scales.
- Impact category: High
- Exploit path: Initialize with base index 0 or denominator 0 -> later math aborts or mis-accrues.
- Attack scenario: Owner sets liquidation_threshold < ltv or bonus < 1.
- Suggested mitigation: Strict bounds; initialize indices to scale (e.g., 1e27); validate relations (ltv<threshold).


### storage::set_*
- Potential vulnerabilities: Param spikes; invariants broken; bypass via friend path.
- Impact category: High
- Exploit path: Set reserve_factor to 1 or liquidation_ratio extreme -> seize/interest math breaks.
- Attack scenario: Admin error or compromised OwnerCap.
- Suggested mitigation: Bounds checks; rate-limit changes; two-step commit; events.


### storage::withdraw_treasury<T>
- Potential vulnerabilities: PoolAdminCap gate but check against treasury balance rounding; event omission.
- Impact category: High
- Exploit path: Withdraw near balance boundary; rounding returns extra.
- Attack scenario: Precision mismatch in treasury share computation.
- Suggested mitigation: Ceil/floor consistently; assert conservation before/after.


### oracle::update_token_price
- Potential vulnerabilities: Feeder auth; freshness interval enforced; price>0; decimals bounds; batch length check.
- Impact category: High
- Exploit path: Feeder front-runs liquidation with absurd price if lack of bounds.
- Attack scenario: Set price to near-zero; enable cheap liquidations.
- Suggested mitigation: Clamp price; enforce min/max bounds; TWAP or observation window; events.


### oracle::register_token_price / set_update_interval
- Potential vulnerabilities: Admin-only but need interval sanity; per-asset decimals mismatch.
- Impact category: High
- Exploit path: Set large interval -> stale prices exploitable.
- Attack scenario: Admin misconfig or compromised AdminCap.
- Suggested mitigation: Upper bound intervals; require gradual changes; emit events.


### ray_math/safe_math/calculator/dynamic_calculator
- Potential vulnerabilities: Rounding mode inconsistent; overflow if not widened; utilization > 1; time delta overflow.
- Impact category: High
- Exploit path: Compute interest with divide-then-multiply causing loss; underflow aborts (DoS).
- Attack scenario: Large compounding horizon; max U64 seconds.
- Suggested mitigation: Multiply-then-divide in u256; clamp inputs; test boundaries.


### flash_loan::*
- Potential vulnerabilities: Underpayment by rounding; fee calc precision; config bounds.
- Impact category: High
- Exploit path: Return principal + fee - 1; if check uses floor, protocol loses.
- Attack scenario: Rational fee produces fractional wei.
- Suggested mitigation: Ceil fee; assert returned >= principal+fee; cap per-asset min/max.


### incentive_v2/v3
- Potential vulnerabilities: Index update ordering; claim rounding; rule table growth DoS.
- Impact category: High
- Exploit path: Claim before updating indices to over-claim.
- Attack scenario: User cycles deposit/withdraw to farm rounding.
- Suggested mitigation: Update indices before balance changes; min claim; cap rules.


### pool::withdraw_treasury<T>
- Potential vulnerabilities: AdminCap gate but precision in convert_amount/unnormal_amount.
- Impact category: Medium
- Exploit path: Decimals conversion overflow/rounding leads to off-by-one.
- Attack scenario: 0-decimal asset conversion.
- Suggested mitigation: Use u256; explicit rounding; test low-decimal assets.


### logic::*
- Potential vulnerabilities: Health factor math: floor on collateral, ceil on debt; stale price risk.
- Impact category: High
- Exploit path: is_health returns true due to rounding; borrow proceeds.
- Attack scenario: Edge thresholds.
- Suggested mitigation: Conservative rounding; require fresh price.
