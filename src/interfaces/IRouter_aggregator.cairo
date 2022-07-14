%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin

@contract_interface
namespace IRouter_aggregator:
    func get_single_best_pool(
        in_amount: Uint256, 
        token_in: felt, 
        token_out: felt
            )->(
        amount_out: Uint256,
        router_address: felt, 
        router_type:felt):
    end

    func get_weight(
        _amount_in: Uint256, 
        in_token: felt, 
        out_token: felt,
        _router_address: felt, 
        _router_type: felt
        ) -> (weight: felt):  
    end

    func get_global_price(token: felt)->(price: Uint256):
    end

    func get_liquidity_weight(
        _amount_in : Uint256, 
        _src: felt, 
        _dst: felt, 
        _router_address: felt, 
        _router_type: felt)->(weight:felt):
    end

    func add_router(_router_address: felt, _router_type: felt):
    end 
end
