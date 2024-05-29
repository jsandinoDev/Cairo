# Functions


fn Keyword to declare new functions


Expressions do not include ending semicolons. If you add a semicolon to the end of an expression, you turn it into a statement, and it will then not return a value.
```
let y = {
        let x = 3;
        x + 1
    };
``` 

#### Named Parameters

```
fn foo(x: u8, y: u8) {}

fn main() {
    let first_arg = 3;
    let second_arg = 4;
    foo(x: first_arg, y: second_arg);
    let x = 1;
    let y = 2;
    foo(:x, :y)
}
```


### Statements and Expressions
(Declaraion/expresion)

for a declareation need the ;

- Statements are instructions that perform some action and do not return a value.
- Expressions evaluate to a resultant value. Let’s look at some examples.
- 
#### Functions with Return Values

```
fn five() -> u32 {
    5
} 
```