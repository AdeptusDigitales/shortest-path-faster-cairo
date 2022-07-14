%lang starknet

from starkware.cairo.common.uint256 import (Uint256, uint256_add,uint256_unsigned_div_rem,uint256_mul)
from starkware.starknet.common.syscalls import (get_caller_address, get_contract_address)
from starkware.cairo.common.cairo_builtins import HashBuiltin

#from src.interfaces.IERC20 import IERC20

struct Pair:
    member token_1 : felt
    member token_2 : felt
end

struct Reserves:
    member reserve_1 : Uint256
    member reserve_2 : Uint256
end

@storage_var
func reserves(pair: Pair)->(reserves: Reserves):
end

#@external
#func exchange_exact_token_for_token{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
#    _amount_in: Uint256,_token_in: felt,_token_out: felt,min_amount_out: Uint256):
#    alloc_locals
#    let (amount_out: Uint256) = get_amount_out(_amount_in,_token_in,_token_out)
#    let (caller_address) = get_caller_address()
#    let (this_address) = get_contract_address()
#    IERC20.transferFrom(_token_in,caller_address,this_address,amount_out)
#    IERC20.transfer(_token_out,caller_address,amount_out)
#    return()
#end

@view
func get_amount_out{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _amount_in: Uint256,_token_in: felt,_token_out: felt) -> (amount_out:Uint256):
    alloc_locals
    let (reserve_1:Uint256,reserve_2:Uint256) = get_reserves(_token_in,_token_out)
    
    if reserve_1.low == 0 :
        return(Uint256(0,0))
    else:
        let (feed_amount:Uint256,_) = uint256_mul(_amount_in,Uint256(997,0))
        let (numerator,_) = uint256_mul(feed_amount,reserve_2)
        let (feed_reserve,_) = uint256_mul(reserve_1,Uint256(1000,0))
        let (denominator,_) = uint256_add(feed_reserve,feed_amount)
        let (amount_out,_) = uint256_unsigned_div_rem(numerator,denominator)
        return(amount_out)
    end
end

@view 
func get_reserves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _token_in: felt,_token_out: felt) -> (reserve1:Uint256,reserve2:Uint256):
    
    let (token_reserves: Reserves) = reserves.read(Pair(_token_in,_token_out))
    
    return(token_reserves.reserve_1,token_reserves.reserve_2)
end

@external
func set_reserves{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _token_in: felt, _token_out: felt, _reserve_1: Uint256, _reserve_2: Uint256):
    reserves.write(Pair(_token_in,_token_out),Reserves(_reserve_1,_reserve_2))
    reserves.write(Pair(_token_out,_token_in),Reserves(_reserve_2,_reserve_1))
    return()
end
