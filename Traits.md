# Traits

A trait defines a set of methods that can be implemented by a type. 



Note: Traits are similar to a feature often called interfaces in other languages, although with some differences.


Implementing a trait on a type is similar to implementing regular methods. The difference is that after impl, we put a name for the implementation, then use the of keyword

```
mod aggregator {
    pub trait Summary<T> {
        fn summarize(self: @T) -> ByteArray;
    }

    #[derive(Drop)]
    pub struct NewsArticle {
        pub headline: ByteArray,
        pub location: ByteArray,
        pub author: ByteArray,
        pub content: ByteArray,
    }

    impl NewsArticleSummary of Summary<NewsArticle> {
        fn summarize(self: @NewsArticle) -> ByteArray {
            format!("{} by {} ({})", self.headline, self.author, self.location)
        }
    }

    #[derive(Drop)]
    pub struct Tweet {
        pub username: ByteArray,
        pub content: ByteArray,
        pub reply: bool,
        pub retweet: bool,
    }

    impl TweetSummary of Summary<Tweet> {
        fn summarize(self: @Tweet) -> ByteArray {
            format!("{}: {}", self.username, self.content)
        }
    }
}

use aggregator::{Summary, NewsArticle, Tweet};

fn main() {
    let news = NewsArticle {
        headline: "Cairo has become the most popular language for developers",
        location: "Worldwide",
        author: "Cairo Digger",
        content: "Cairo is a new programming language for zero-knowledge proofs",
    };

    let tweet = Tweet {
        username: "EliBenSasson",
        content: "Crypto is full of short-term maximizing projects. \n @Starknet and @StarkWareLtd are about long-term vision maximization.",
        reply: false,
        retweet: false
    }; // Tweet instantiation

    println!("New article available! {}", news.summarize());
    println!("New tweet! {}", tweet.summarize());
}
```

https://book.cairo-lang.org/ch08-02-traits-in-cairo.html#implementing-a-trait-on-a-type




### Managing and Using External Trait


To use traits methods, you need to make sure the correct traits/implementation(s) are imported. In some cases you might need to import not only the trait but also the implementation if they are declared in separate modules. 

```
// Here T is an alias type which will be provided during implementation
pub trait ShapeGeometry<T> {
    fn boundary(self: T) -> u64;
    fn area(self: T) -> u64;
}

mod rectangle {
    // Importing ShapeGeometry is required to implement this trait for Rectangle
    use super::ShapeGeometry;

    #[derive(Copy, Drop)]
    pub struct Rectangle {
        pub height: u64,
        pub width: u64,
    }

    // Implementation RectangleGeometry passes in <Rectangle>
    // to implement the trait for that type
    impl RectangleGeometry of ShapeGeometry<Rectangle> {
        fn boundary(self: Rectangle) -> u64 {
            2 * (self.height + self.width)
        }
        fn area(self: Rectangle) -> u64 {
            self.height * self.width
        }
    }
}

mod circle {
    // Importing ShapeGeometry is required to implement this trait for Circle
    use super::ShapeGeometry;

    #[derive(Copy, Drop)]
    pub struct Circle {
        pub radius: u64
    }

    // Implementation CircleGeometry passes in <Circle>
    // to implement the imported trait for that type
    impl CircleGeometry of ShapeGeometry<Circle> {
        fn boundary(self: Circle) -> u64 {
            (2 * 314 * self.radius) / 100
        }
        fn area(self: Circle) -> u64 {
            (314 * self.radius * self.radius) / 100
        }
    }
}

use rectangle::Rectangle;
use circle::Circle;

fn main() {
    let rect = Rectangle { height: 5, width: 7 };
    println!("Rectangle area: {}", ShapeGeometry::area(rect)); //35
    println!("Rectangle boundary: {}", ShapeGeometry::boundary(rect)); //24

    let circ = Circle { radius: 5 };
    println!("Circle area: {}", ShapeGeometry::area(circ)); //78
    println!("Circle boundary: {}", ShapeGeometry::boundary(circ)); //31
}
```

### Impl Aliases

Implementations can be aliased when imported. This is most useful when you want to instantiate generic implementations with concrete types. For example, let's say we define a trait Two that is used to return the value 2 for a type T. We can write a trivial generic implementation of Two for all types that implement the One trait, simply by adding twice the value of one and returning it. However, in our public API, we may only want to expose the Two implementation for the u8 and u128 types.

```
trait Two<T> {
    fn two() -> T;
}

mod one_based {
    pub impl TwoImpl<
        T, +Copy<T>, +Drop<T>, +Add<T>, impl One: core::num::traits::One<T>
    > of super::Two<T> {
        fn two() -> T {
            One::one() + One::one()
        }
    }
}

pub impl U8Two = one_based::TwoImpl<u8>;
pub impl U128Two = one_based::TwoImpl<u128>;
```



### Negative Impls

Note: This is still an experimental feature and can only be used if experimental-features = ["negative_impls"] is enabled in your Scarb.toml file, under the [package] section.


are a mechanism that allows you to express that a type does not implement a certain trait when defining the implementation of a trait over a generic type. Negative impls enable you to write implementations that are applicable only when another implementation does not exist in the current scope.


For example, let's say we have a trait Producer and a trait Consumer, and we want to define a generic behavior where all types implement the Consumer trait by default. However, we want to ensure that no type can be both a Consumer and a Producer. We can use negative impls to express this restriction.

```
#[derive(Drop)]
struct ProducerType {}

#[derive(Drop, Debug)]
struct AnotherType {}

#[derive(Drop, Debug)]
struct AThirdType {}

trait Producer<T> {
    fn produce(self: T) -> u32;
}

trait Consumer<T> {
    fn consume(self: T, input: u32);
}

impl ProducerImpl of Producer<ProducerType> {
    fn produce(self: ProducerType) -> u32 {
        42
    }
}

impl TConsumerImpl<T, +core::fmt::Debug<T>, +Drop<T>, -Producer<T>> of Consumer<T> {
    fn consume(self: T, input: u32) {
        println!("{:?} consumed value: {}", self, input);
    }
}

fn main() {
    let producer = ProducerType {};
    let another_type = AnotherType {};
    let third_type = AThirdType {};
    let production = producer.produce();

    // producer.consumer(production); Invalid: ProducerType does not implement Consumer
    another_type.consume(production);
    third_type.consume(production);
}
```