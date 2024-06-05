






// Return the solution of x^3 + y - 2

// fn main() {
//     // test_poly()

//     // let a = bigger(1,2);
//     // println!("{a}");

//     let a = foo_if_fizz('fizz');
//     println!("{a}");

// }

fn foo_if_fizz(fizzish: felt252) -> felt252 {
    // Complete this function using if, else if and/or else blocks.
    // If fizzish is,
    // 'fizz', return 'foo'
    // 'fuzz', return 'bar'
    // anything else, return 'baz'
    let mut res = '';
    if fizzish == 'fizz' {
        res = 'foo';
    } else if  fizzish == 'fuzz'{
        res = 'bar';
    } else {
        res = 'baz';
    }
    res
}

// fn poly(x: usize, y: usize) -> usize {
//     // FILL ME
//     let res1 = x * x * x;
//     let res = res1 + y - 2;
//     println!("{res}");
//     res // Do not change
// }



// fn test_poly() {
//     let res = poly(5, 3);
//     assert(res == 126, 'Error message');
//     assert(res < 300, 'res < 300');
//     assert(res <= 300, 'res <= 300');
//     assert(res > 20, 'res > 20');
//     assert(res >= 2, 'res >= 2');
//     assert(res != 27, 'res != 27');
//     assert(res % 2 == 0, 'res %2 != 0');
// }


// fn bigger(a: usize, b: usize) -> usize {
//     // Do not use:
//     // - another function call
//     // - additional variables
//     let mut res = 0;
//     if a > b {
//         println!("if");
//         res = a;
//     }
//     else {
//         println!("else");
//         res = b;
//     }
//     res
// }

