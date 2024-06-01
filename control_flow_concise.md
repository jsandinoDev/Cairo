# IF LET

```
    let number = Option::Some(5);
    if let Option::Some(max) = number {
        println!("The maximum is configured to be {}", max);
    }

```


```
    let coin = Coin::Quarter;
    let mut count = 0;
    match coin {
        Coin::Quarter => println!("You got a quarter!"),
        _ => count += 1,
    }

    // --------------

    let coin = Coin::Quarter;
    let mut count = 0;
    if let Coin::Quarter = coin {
        println!("You got a quarter!");
    } else {
        count += 1;
    }

```



# While let
```
fn main() {
    let mut arr = array![1, 2, 3, 4, 5, 6, 7, 8, 9];
    let mut sum = 0;
    while let Option::Some(value) = arr.pop_front() {
        sum += value;
    };
    println!("{}", sum);
}
```