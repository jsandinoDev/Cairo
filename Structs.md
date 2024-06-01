### Structs


```
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}
```

To use a struct after we’ve defined it, we create an instance of that struct by specifying concrete values for each of the fields. 

```
#[derive(Drop)]
struct User {
    active: bool,
    username: ByteArray,
    email: ByteArray,
    sign_in_count: u64,
}

fn main() {
    let mut user1 = User {
        active: true, username: "someusername123", email: "someone@example.com", sign_in_count: 1
    };

    user1.email = "anotheremail@example.com";

    let user2 = User {
        sign_in_count: 1, username: "someusername123", active: true, email: "someone@example.com"
    };
}

```

## build method

```
fn build_user(email: ByteArray, username: ByteArray) -> User {
    User { active: true, username: username, email: email, sign_in_count: 1, }
}

fn build_user(email: ByteArray, username: ByteArray) -> User {
    User { active: true, username: username, email: email, sign_in_count: 1, }
}

```

### Creating Instances from Other Instances with Struct Update Syntax


struct update syntax.

```
fn main() {
    // --snip--

    let user2 = User {
        active: user1.active,
        username: user1.username,
        email: "another@example.com",
        sign_in_count: user1.sign_in_count,
    };

    fn main() {
    // --snip--

    let user2 = User { email: "another@example.com", ..user1 };
}

}

```