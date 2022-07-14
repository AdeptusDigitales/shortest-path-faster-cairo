%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace IUni_router:

    func exchange_exact_token_for_token(_amount_in: Uint256, _token_in: felt, _token_out: felt, min_amount_out: felt):
    end

    func get_pool_stats(token1: felt,token2: felt) -> (reserve1:Uint256, reserve2: Uint256, fee: felt):
    end

    func get_reserves(_token_in: felt, _token_out: felt) -> (reserve1:Uint256, reserve2: Uint256):
    end

    func get_amount_out(_amount_in: Uint256, token1: felt, token2: felt) -> (amount_out: Uint256): 
    end

    func set_reserves(_token_in: felt, _token_out: felt, _reserve_1: Uint256, _reserve_2: Uint256):
    end

end

