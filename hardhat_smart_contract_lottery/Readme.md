# Events
> refer: https://docs.soliditylang.org/en/latest/contracts.html#events

Solidity events give an abstraction on top of the EVM’s logging functionality. **Applications can subscribe and listen** to these events through the RPC interface of an Ethereum client.

**Events are inheritable** members of contracts. **When you call** them, they cause the **arguments** to be **stored in the transaction’s log** - a special data structure in the blockchain. These **logs are associated with the address of the contract**, are incorporated into the blockchain, and stay there as long as a block is accessible

You can add the **attribute indexed to up to three parameters** which adds them to a special data structure known as **“topics”** instead of the data part of the log. A topic can only hold a single word (32 bytes) so if you use a reference type for an indexed argument, the Keccak-256 hash of the value is stored as a topic instead.

All **parameters without** the **indexed** attribute are **ABI-encoded into the data part of the log.**

**Topics** allow you to **search for events**, for example when filtering a sequence of blocks for certain events. You can also **filter events by the address of the contract** that emitted the event.

```Solidity
contract myContract {
    event myEvent(address indexed myIndexedVariable, uint myNum);
    /*
    * some code
    */
    emit myEvent(msg.sender, 96);
}
```