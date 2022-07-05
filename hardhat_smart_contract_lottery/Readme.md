# Chainlink keepers (Automate contracts)
> refer: https://docs.chain.link/docs/chainlink-keepers/introduction

Automate your smart contracts using Chainlink Keepers, Relying on Chainlink Keepers will help you **save gas by offloading expensive on-chain automation logic to our decentralized Keepers Network**.

In order to use keepers, you need to **select a trigger**: 1) **Time Based** trigger or 2) **Custom logic** trigger.

Steps to register Time based trigger:
>refer: https://docs.chain.link/docs/chainlink-keepers/introduction/#time-based-trigger

Steps to register Custom logic trigger
>refer: https://docs.chain.link/docs/chainlink-keepers/introduction/#custom-logic-trigger

#### keeper compatible contract
Keepers-compatible contracts must meet the following requirements:

* Import `KeepersCompatible.sol`. 
* Use the `KeepersCompatibleInterface` from the library to ensure your `checkUpkeep` and `performUpkeepfunction` definitions match the definitions expected by the Keepers Network.
* Include a `checkUpkeep` function that contains the logic that will be executed off-chain to see if `performUpkeep` should be executed. `checkUpkeep` can use on-chain data and a specified `checkData` parameter to perform complex calculations off-chain and then send the result to `performUpkeep` as `performData`.
* Include a `performUpkeep` function that will be executed on-chain when `checkUpkeep` returns true. Because `performUpkeep` is external, users are advised to revalidate conditions and performData.


#### enum datatype

```Solidity
enum myTypeName {
    value1,
    value2
}

// declare variables
myTypeName public myVar;

// define
myVar = myTypeName.value1       // or myTypeName(0)
```

#### new keyword
```Solidity
s_players = new address payable[](0)    // new type[](size)
```
Not recomming this approach because it doesn't clear-up the garbage values. Instead delete the array.

#### Design Pattern Solidity**
>refer: https://soliditydeveloper.com/design-pattern-solidity-free-up-unused-storage

There is **no Garbage collector** in solidity. Even if there was a similar concept, you would still be better off managing state data yourself. Only you as a programmer can know exactly which data will not be used in the future anymore.

**Gas Cost:** You can receive gas refunds for releasing unused storage. **SSTORE costs 20,000 gas** per instruction. On the contrary, if you look at **R_sclear: 15,000 gas refund** given **when the storage value is set to zero** from non-zero.

**How to free up unused data :-**
Solidity provides `delete` keyword for freeing up unused data.

**Simple Types**
```Solidity
delete myInterger;
// or
myInteger = 0
```
**Arrays:** Automatically create an array of length 0 for dynamic arrays or set each item of the array to 0 for static arrays.
```Solidity
// delete array
delete myArray;

// delete an item
delete myArray[index]; // NOT RECOMMENDED, it'll create a gap in array

// delete an item (RECOMMENDED)
// NOTE: if order doesn't matter.
myArray[index] = myArray[ myArray.length - 1 ];
myArray.pop();
// Pop removes the last element and also implicitly calls delete on the removed element.
```
**Structs:** Automatically clear out each entry of your struct with one exception:
```Solidity
delete myStruct;
```
**Mapping**  Solidity cannot delete a mapping, because it does not know the keys for the mapping. Since the keys are arbitrary and not stored along, the only way to delete structs is to know the key for each stored value. A value can then be deleted by delete `myMapping[myKey]`.
``` Solidity
// delete myMapping;    Error

// delete an item in mapping
delete myMpping[myKey];
```

#### block.timestamp
it returns the timestamp of the block being created as a uint256 (secs since epoch)
```Solidity
uint currentTime = block.timestamp;
```
#### Double-Check perform upkeep
Since **`performUpKeep`** is an external function and **anyone can call the function**, we **need to double-check** if we really need to perform upkeep or not. 
In order to check that we ***need to call `checkUpKeep`*** inside `performUpkeep`. 

> Q ?????????
can I change the access modifier of an function while overriding it?

```Solidity
function performUpKeep(...) ... {
    (bool upKeepNeeded, ) = this.checkUpKeep( abi.encode("") );
}

function checkUpkeep(bytes calldata /*checkData*/ ) public ... {
    ...
}
```
Notice `this.checkUpKeep()`

#### How to pass parameters in callData?
use `this` keyword if you want to pass parameters in callData otherwise they'll be passed to memory.
**Note:** we've not changed access modifier of checkUpKeep() from external to public because using `this` keyword we're calling it externally.