# shortest-path-faster-cairo

Cairo implementation of the *Shortest Path Faster* algorithm.

The best way to understand the algorithm is to understand *Bellman-Ford* as a prerequisit:</br> 
https://www.geeksforgeeks.org/bellman-ford-algorithm-dp-23/

and from there have a look at the improvements made to create the *SPF* algorithm:</br> 
https://www.geeksforgeeks.org/shortest-path-faster-algorithm/

The code is not actually a pure implementation of the SPF-algorithm as it has been adjusted to simulate it's usage as a solver within a DEX aggregator.</br>
An assumption is being made that the highest liquidity pairing for every shitcoin is with one of 4 different tokens. On Ethereum mainnet these would be: </br> 
1) ETH
2) USDC
3) DAI
4) USDT

Therefore we only search for a route from **Shitcoin1** via **ETH/USDC/DAI/USDT** to **Shitcoin2**

### To run the test (Linux/Mac only):

Install protostar:

`curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash`

then run:

`prototstar test ./tests`
