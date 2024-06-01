# Method Syntax


### Defining Methods

Define 

```
trait RectangleTrait {
    fn area(self: @Rectangle) -> u64;
}
```

Then, we implement this trait in RectangleImpl with the impl keyword. In the body of the area method, we can access to the calling instance with the self parameter.

```
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
}

```

Finally, we call this area method on the Rectangle instance rect1 using the <instance_name>.<method_name> syntax. The instance rect1 will be passed to the area method as the self parameter.

```
fn main() {
    let rect1 = Rectangle { width: 30, height: 50, };
    println!("Area is {}", rect1.area());
}

```


### The generate_trait Attribute


- Cairo provides the #[generate_trait] attribute to add above a trait implementation
- tells to the compiler to generate the corresponding trait definition for you, and let's you focus on the implementation only. 

The previous example can also be written as follows:
```
#[derive(Copy, Drop)]
struct Rectangle {
    width: u64,
    height: u64,
}

#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50, };
    println!("Area is {}", rect1.area());
}


```

### Snapshots and References
Let's write a new method scale which resizes a rectangle of a factor given as parameter:


```
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }
    fn scale(ref self: Rectangle, factor: u64) {
        self.width *= factor;
        self.height *= factor;
    }
}

fn main() {
    let mut rect2 = Rectangle { width: 10, height: 20 };
    rect2.scale(2);
    println!("The new size is (width: {}, height: {})", rect2.width, rect2.height);
}
```


### Methods with several parameters

Can hold

```
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        *self.width * *self.height
    }

    fn scale(ref self: Rectangle, factor: u64) {
        self.width *= factor;
        self.height *= factor;
    }

    fn can_hold(self: @Rectangle, other: @Rectangle) -> bool {
        *self.width > *other.width && *self.height > *other.height
    }
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50, };
    let rect2 = Rectangle { width: 10, height: 40, };
    let rect3 = Rectangle { width: 60, height: 45, };

    println!("Can rect1 hold rect2? {}", rect1.can_hold(@rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(@rect3));
}
```


### Methods without self parameter

compare

```
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }

    fn new(width: u64, height: u64) -> Rectangle {
        Rectangle { width, height }
    }

    fn compare(r1: @Rectangle, r2: @Rectangle) -> bool {
        let r1_area = r1.area();
        let r2_area = r2.area();

        return r1_area == r2_area;
    }
}

fn main() {
    let rect1 = RectangleTrait::new(30, 50);
    let rect2 = RectangleTrait::new(10, 40);

    println!("Are rect1 and rect2 equals ? {}", RectangleTrait::compare(@rect1, @rect2));
}
```


### Multiple traits and impl blocks

```
#[generate_trait]
impl RectangleImpl of RectangleTrait {
    fn area(self: @Rectangle) -> u64 {
        (*self.width) * (*self.height)
    }

    fn new(width: u64, height: u64) -> Rectangle {
        Rectangle { width, height }
    }

    fn compare(r1: @Rectangle, r2: @Rectangle) -> bool {
        let r1_area = r1.area();
        let r2_area = r2.area();

        return r1_area == r2_area;
    }
}

fn main() {
    let rect1 = RectangleTrait::new(30, 50);
    let rect2 = RectangleTrait::new(10, 40);

    println!("Are rect1 and rect2 equals ? {}", RectangleTrait::compare(@rect1, @rect2));
}
```

There’s no strong reason to separate these methods into multiple trait and impl blocks here, but this is valid syntax.



### Summary
Structs let you create custom types that are meaningful for your domain. By using structs, you can keep related pieces of data together and name each piece to make your code clear. In trait and impl blocks, you can define methods, which are functions associated with a type, allowing you to specify the behavior that instances of your type have.

But structs aren’t the only way you can create custom types: let’s turn to Cairo’s enum feature to add another tool to your toolbox.