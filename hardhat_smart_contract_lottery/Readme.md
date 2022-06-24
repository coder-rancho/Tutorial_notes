# immutable
> refer https://blog.soliditylang.org/2020/05/13/immutable-keyword/

With **version 0.6.5**, Solidity introduced the immutable keyword **for state variables**. Immutable state variables can **only be assigned in constructor()**, but will **remain constant** throughout the life-time of a deployed contract.

**Reading is gas-efficient**. since immutables will **not be stored in storage**, but their values will be directly **inserted into the runtime code.**

# Custom error in Solidity
> refer https://blog.soliditylang.org/2021/04/21/custom-errors/

revert("String message") -- expensive

Custom errors are defined **using error statement**, which can be used **inside and outside of contracts** (including interfaces and libraries).

The **syntax** of errors is **similar to events**. They have to be **used with revert** statement which causes all changes in the current call to be reverted and passes the error data back to the caller

It is also possible to have errors that **take parameters**.
```solidity
error InsufficientBalance(uint256 available, uint256 required);
// some code
if ( some_condition ) {
    revert InsufficientBalance({
                available: balance[msg.sender],
                required: amount
            });
}
```

The error data would be encoded **identically** as the **ABI encoding for function calls**, i.e., `abi.encodeWithSignature("InsufficientBalance(uint256,uint256)", balance[msg.sender], amount)`

> ??????????
> Topic: decoding error data with ether.js
> ??????????

The **compiler** includes all **errors** that a contract can emit in the **contract’s ABI-JSON.**

Please be **careful** when using **error data** since its **origin** is **not tracked**. The error data by default bubbles up through the **chain of external calls**, which means that a **contract** may **forward an error not defined** in any of the **contracts it calls directly**.

Furthermore, any **contract** can **fake any error** by returning data that matches an error signature, **even** if the **error is not defined anywhere.**

**Currently**, there is **no convenient way to catch errors** in Solidity, but this is planned, and progress can be tracked in issue #11278.