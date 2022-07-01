# Chainlink's VRF -- version 2
VRF -- (Verifiable Random Function)

> refer: https://docs.chain.link/docs/chainlink-vrf/

For each request, Chainlink **VRF generates one or more random values** and cryptographic proof of how those values were determined.

#### Subscription
VRF v2 requests receive funding from **subscription accounts**. The Subscription Manager lets you create an account and pre-pay for VRF v2, so you **don't provide funding each time** your application requests randomness. This **reduces the total gas cost to use VRF v2**. It also provides a simple way to fund your use of Chainlink products from a **single location**, so you **don't have to manage multiple wallets** across several different systems and applications.

#### Create and fund a subscription
> refer: https://docs.chain.link/docs/get-a-random-number/#create-and-fund-a-subscription
1. Open the [Subscription Manager](https://vrf.chain.link/?_ga=2.129387468.1962837791.1656364789-312859173.1656038623) page.
2. Connect wallet --> create subscription --> fund subscription with links
3. Click "add consumer" --> copy subscription id
4. Create and deploy a VRF-V2 compatible contract (consumer contract).
5. add consumer --> add consumer contract address.

#### Request random values
In your VRF-V2 compatible contract, execute **requestRandomWords()** function to **send the request for random values** to Chainlink VRF. Chainlink VRF processes your request. Chainlink **VRF fulfills** the request and returns the random values to your contract **in a callback to the fulfillRandomWords()** function.

VRF-V2 compatible contract include following params
```Solidity
// state variables
uint64 s_subscriptionId
address vrfCoordinator
bytes32 keyHash
uint32 callbackGasLimit
uint16 requestConfirmations
uint32 numWords

// Required functions
requestRandomWords() external
fulfillRandomWords() internal override
```

Q: What is keyHash?
> refer: https://ethereum.stackexchange.com/questions/125997/chainlink-vrfv2-how-is-gas-cost-determined

Q: Why fulfillRandomWords() is internal?
> refer: https://ethereum.stackexchange.com/questions/126455/how-chainlink-vrf-fulfillrandomwords-callback-function-works

#### Subscription Manager Contract
> refer: https://docs.chain.link/docs/chainlink-vrf/example-contracts/#modifying-subscriptions-and-configurations

How you manage the subscription depends on your randomness needs. You can **configure your subscriptions** using the **Subscription Manager**, or **create your subscription and add your consumer contracts programmatically**. You can still view the subscriptions in the Subscription Manager. Any wallet can provide funding to those subscriptions.

#### VRF Security Considerations
> refer: https://docs.chain.link/docs/vrf-security-considerations

* [ ] Use `requestId` to match randomness requests with their fulfillment in order
* [ ] Choose a safe block confirmation time, which will vary between blockchains
* [ ] Do not re-request randomness, even if you don't get an answer right away
* [ ] Don't accept bids/bets/inputs after you have made a randomness request
* [ ] The `fulfillRandomWords` function must not revert
* [ ] Use `VRFConsumerBaseV2` in your contract to interact with the VRF service

#### Configurations
> [Rinkeby Testnet Configuration](https://docs.chain.link/docs/vrf-contracts/#rinkeby-testnet) for VRF-V2.

