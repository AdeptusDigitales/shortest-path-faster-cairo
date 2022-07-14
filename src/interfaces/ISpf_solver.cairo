%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace ISpf_solver:
    func get_results(
        _amount_in: Uint256,
        _token_in: felt,
        _token_out: felt)
        -> (path_len: felt, path: felt*):
    end

    func set_router_aggregator(_new_router_aggregator_address: felt):
    end
end