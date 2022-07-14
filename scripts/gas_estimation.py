from pathlib import Path
from starknet_py.net import AccountClient
from starknet_py.net.client import Client
from starknet_py.net.signer.stark_curve_signer import (StarkCurveSigner,KeyPair)
from starknet_py.contract import Contract
from starknet_py.net.networks import TESTNET
from starknet_py.net.models import StarknetChainId
from starkware.crypto.signature.signature import (pedersen_hash, private_to_stark_key, sign)

private_key = 143500174905254755091859955060282197780
public_key = private_to_stark_key(private_key)
client = AccountClient(net="http://127.0.0.1:5050/", chain=StarknetChainId.TESTNET,n_retries=1,address="0x59af1c39047436311fedccc35d048103b6d63ae6958c10524b24cf5e1c8dd95",key_pair=KeyPair(private_key,public_key))

compiled = Path("../", "build/spf_solver.json").read_text("utf-8")
deployment_result = await Contract.deploy(
    client, compiled_contract=compiled, constructor_args=[]
)
#Deploy Contract
print("Deploying Contract...")
await deployment_result.wait_for_acceptance()
contract = deployment_result.deployed_contract
print(contract.address)
contractAddress = contract.address  

address = "0x00178130dd6286a9a0e031e4c73b2bd04ffa92804264a25c1c08c1612559f458"

client = Client(TESTNET)
contract = await Contract.from_address(address, client)

# Using only positional arguments
invocation = await contract.functions["transferFrom"].invoke(
    sender, recipient, 10000, max_fee=0
)

# Using only keyword arguments
invocation = await contract.functions["transferFrom"].invoke(
    sender=sender, recipient=recipient, amount=10000, max_fee=0
)

# Mixing positional with keyword arguments
invocation = await contract.functions["transferFrom"].invoke(
    sender, recipient, amount=10000, max_fee=0
)

# Creating a PreparedFunctionCall - creates a function call with arguments - useful for signing transactions and
# specifying additional options
transfer = contract.functions["transferFrom"].prepare(
    sender, recipient, amount=10000, max_fee=0
)
await transfer.invoke()

# Wait for tx
await invocation.wait_for_acceptance()

(balance,) = await contract.functions["balanceOf"].call(recipient)

# You can also use key access, call returns NamedTuple
result = await contract.functions["balanceOf"].call(recipient)
balance = result.balance