# Dictionaries

Felt252Dict<T>

- collection of key-value pairs where each key is unique and associated with a corresponding value.
- The key type is restricted to felt252
  
## Operations

insert(felt252, T) -> () to write values to a dictionary instance and


get(felt252) -> T to read values from it.

```
fn main() {
    let mut balances: Felt252Dict<u64> = Default::default();

    balances.insert('Alex', 100);
    balances.insert('Maria', 200);

    let alex_balance = balances.get('Alex');
    assert!(alex_balance == 100, "Balance is not 100");

    let maria_balance = balances.get('Maria');
    assert!(maria_balance == 200, "Balance is not 200");
}
```

We can create a new instance of Felt252Dict<u64> by using the default method of the Default trait and add two individuals, each one with their own balance, using the insert method.

- DICS are mutable
```
fn main() {
    let mut balances: Felt252Dict<u64> = Default::default();

    // Insert Alex with 100 balance
    balances.insert('Alex', 100);
    // Check that Alex has indeed 100 associated with him
    let alex_balance = balances.get('Alex');
    assert!(alex_balance == 100, "Alex balance is not 100");

    // Insert Alex again, this time with 200 balance
    balances.insert('Alex', 200);
    // Check the new balance is correct
    let alex_balance_2 = balances.get('Alex');
    assert!(alex_balance_2 == 200, "Alex balance is not 200");
}
```