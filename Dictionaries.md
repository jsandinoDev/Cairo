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



### Dictionaries underneath

1. A key field that identifies the key for this key-value pair of the dictionary.
2. A previous_value field that indicates which previous value was held at key.
3. A new_value field that indicates the new value that is held at key.

```
struct Entry<T> {
    key: felt252,
    previous_value: T,
    new_value: T,
}
```

Example
```
    balances.insert('Alex', 100_u64);
    balances.insert('Maria', 50_u64);
    balances.insert('Alex', 200_u64);
    balances.get('Maria');

```

|  key  | previous | new |
|:-----:|:--------:|:---:|
|  Alex | 0        | 100 |
| Maria | 0        | 50  |
|  Alex | 100      | 200 |
| Maria | 50       | 50  |



### Squashing Dictionaries

squash_dict ()


The process of squashing is as follows: given all entries with certain key k, taken in the same order as they were inserted, verify that the ith entry new_value is equal to the ith + 1 entry previous_value.

||   key   	| previous 	| new 	|
|:-------:	|:--------:	|:---:	|
|   Alex  	| 0        	| 150 	|
|  Maria  	| 0        	| 100 	|
| Charles 	| 0        	| 70  	|
|  Maria  	| 100      	| 250 	|
|   Alex  	| 150      	| 40  	|
|   Alex  	| 40       	| 300 	|
|  Maria  	| 250      	| 190 	|
|   Alex  	| 300      	| 90  	|

After Squashing

|  key  | previous | new |
|:-----:|:--------:|:---:|
|  Alex | 0        | 90 |
| Maria | 0        | 190 |
|Charles| 0        | 70  |


### Dictionary Destruction

There is a call to squas dic via the behind implementation of Destruct<T>


Destruct<T> is another way of removing instances out of scope apart from Drop<T>


### Entry and finalize

The entry method comes as part of Felt252DictTrait<T> with the purpose of creating a new entry given a certain key. Once called, this method takes ownership of the dictionary and returns the entry to update. The method signature is as follows:

```
fn entry(self: Felt252Dict<T>, key: felt252) -> (Felt252DictEntry<T>, T) nopanic
```

The next thing to do is to update the entry with the new value. For this, we use the finalize method which inserts the entry and returns ownership of the dictionary:

```
fn finalize(self: Felt252DictEntry<T>, new_value: T) -> Felt252Dict<T>
```

Example:


Implementation of own version of get Method

1. Create the new entry to add using the entry method.
2. Insert back the entry where the new_value equals the previous_value.
3. Return the value.


```
use core::dict::Felt252DictEntryTrait;

fn custom_get<T, +Felt252DictValue<T>, +Drop<T>, +Copy<T>>(
    ref dict: Felt252Dict<T>, key: felt252
) -> T {
    // Get the new entry and the previous value held at `key`
    let (entry, prev_value) = dict.entry(key);

    // Store the value to return
    let return_value = prev_value;

    // Update the entry with `prev_value` and get back ownership of the dictionary
    dict = entry.finalize(prev_value);

    // Return the read value
    return_value
}
```

The ref keyword means that the ownership of the variable will be given back at the end of the function.


Implementing insert
```
use core::dict::Felt252DictEntryTrait;

fn custom_insert<T, +Felt252DictValue<T>, +Destruct<T>, +Drop<T>>(
    ref dict: Felt252Dict<T>, key: felt252, value: T
) {
    // Get the last entry associated with `key`
    // Notice that if `key` does not exist, `_prev_value` will
    // be the default value of T.
    let (entry, _prev_value) = dict.entry(key);

    // Insert `entry` back in the dictionary with the updated value,
    // and receive ownership of the dictionary
    dict = entry.finalize(value);
}
```

### Dictionaries of Types not Supported Natively

Felt252DictValue<T> -> defines the zero_default method which is the one that gets called when a value does not exist in the dictionary.

This means that making a dictionary of types not natively supported is not a straightforward task, because you would need to write a couple of trait implementations in order to make the data type a valid dictionary value type. To compensate this, you can wrap your type inside a Nullable<T>.

Nullable<T> is a smart pointer type that can either point to a value or be null in the absence of value.

The Box<T> type is a smart pointer that allows us to use a dedicated boxed_segment memory segment for our data, and access this segment using a pointer that can only be manipulated in one place at a time

We will try to store a Span<felt252> inside a dictionary. For that, we will use Nullable<T> and Box<T>. Also, we are storing a Span<T> and not an Array<T> because the latter does not implement the Copy<T> trait which is required for reading from a dictionary.



```
use core::nullable::{NullableTrait, match_nullable, FromNullableResult};

fn main() {
    // Create the dictionary
    let mut d: Felt252Dict<Nullable<Span<felt252>>> = Default::default();

    // Create the array to insert
    let a = array![8, 9, 10];

    // Insert it as a `Span`
    d.insert(0, NullableTrait::new(a.span()));

//...

```

The last step is inserting the array as a span inside the dictionary. Notice that we do this using the new function of the NullableTrait.

Once the element is inside the dictionary, and we want to get it, we follow the same steps but in reverse order. The following code shows how to achieve that:

```
//...

    // Get value back
    let val = d.get(0);

    // Search the value and assert it is not null
    let span = match match_nullable(val) {
        FromNullableResult::Null => panic!("No value found"),
        FromNullableResult::NotNull(val) => val.unbox(),
    };

    // Verify we are having the right values
    assert!(*span.at(0) == 8, "Expecting 8");
    assert!(*span.at(1) == 9, "Expecting 9");
    assert!(*span.at(2) == 10, "Expecting 10");
}

```

Here we:

1. Read the value using get.
2. Verified it is non-null using the match_nullable function.
3. Unwrapped the value inside the box and asserted it was correct.


Complete script

```
use core::nullable::{NullableTrait, match_nullable, FromNullableResult};

fn main() {
    // Create the dictionary
    let mut d: Felt252Dict<Nullable<Span<felt252>>> = Default::default();

    // Create the array to insert
    let a = array![8, 9, 10];

    // Insert it as a `Span`
    d.insert(0, NullableTrait::new(a.span()));

    // Get value back
    let val = d.get(0);

    // Search the value and assert it is not null
    let span = match match_nullable(val) {
        FromNullableResult::Null => panic!("No value found"),
        FromNullableResult::NotNull(val) => val.unbox(),
    };

    // Verify we are having the right values
    assert!(*span.at(0) == 8, "Expecting 8");
    assert!(*span.at(1) == 9, "Expecting 9");
    assert!(*span.at(2) == 10, "Expecting 10");
}

```