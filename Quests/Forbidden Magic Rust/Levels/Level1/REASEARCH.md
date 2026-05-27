# Chapter 1: Prolog

The wizards starts, but basic magic is no challenge for him, he finds an appealing line of the though:

```text
If you’re more familiar with a dynamic language, such as Ruby, Python, or JavaScript, you might not be used to compiling and running a program as separate steps. Rust is an _ahead-of-time compiled_ language, meaning you can compile a program and give the executable to someone else, and they can run it even without having Rust installed. If you give someone a _.rb_, _.py_, or _.js_ file, they need to have a Ruby, Python, or JavaScript implementation installed (respectively). But in those languages, you only need one command to compile and run your program. Everything is a trade-off in language design.
```

He recalls the forgotten art of the `dynamic language`. The mage encounters an item on a chest:

```text
Cargo is Rust’s build system and package manager. Most Rustaceans use this tool to manage their Rust projects because Cargo handles a lot of tasks for you, such as building your code, downloading the libraries your code depends on, and building those libraries. (We call the libraries that your code needs dependencies.)
```

~ I see that the `Cargo` has created more than I was expecting. 
The mage commented when he opened the folder look up with `ls -a`. I see that the files they have been created with version control magic:

```text
It has also initialized a new Git repository along with a .gitignore file. Git files won’t be generated if you run cargo new within an existing Git repository; you can override this behavior by using cargo new --vcs=git.
```

~ Tom... how I missed you. You find friends on unexpected places, the [TOML](https://toml.io/en/) good old standard. Nothing less, nothing more.
~ I remember the days... https://github.com/toml-lang/toml/wiki 

The mage re-encounters his old friend's magic:
```toml
[package]
name = "hello_cargo"
version = "0.1.0"
edition = "2024"

[dependencies]
```

The mages with satisfaction of understanding Tom's wizardry manufacturing casts another spell `cargo build`:
```text
This command creates an executable file in target/debug/hello_cargo (or target\debug\hello_cargo.exe on Windows) rather than in your current directory. Because the default build is a debug build, Cargo puts the binary in a directory named debug. You can run the executable with this command:
```

```bash
> ./target/debug/hello_cargo
> Hello, world!
```

(Cargo lock spawned)
```text
This file keeps track of the exact versions of dependencies in your project. This project doesn’t have dependencies, so the file is a bit sparse. You won’t ever need to change this file manually; Cargo manages its contents for you.
```

# Chapter 2: Building with Magic

The wizard has en-devour in the speech of the Rustaceans.  It is a speech with is puzzling and foreign to him, but if he remembers the old domes of the C library he will crack the magic alphabet. He notices on the dome some notes form an wise wizard:

```text
By default, Rust has a set of items defined in the standard library that it brings into the scope of every program. This set is called the prelude, and you can see everything in it in the standard library documentation.
```

~ They call the `std::` the _prelude_

He casts a spell to tap into the inner knowledge of the [prelude](https://doc.rust-lang.org/stable/std/prelude/index.html) and a citation struck his mind:

```text
Rust comes with a variety of things in its standard library. However, if you had to manually import every single thing that you used, it would be very verbose. But importing a lot of things that a program never uses isn’t good either. A balance needs to be struck.

The prelude is the list of things that Rust automatically imports into every Rust program. It’s kept as small as possible, and is focused on things, particularly traits, which are used in almost every single Rust program.

Preludes can be seen as a pattern to make using multiple types more convenient. As such, you’ll find other preludes in the standard library, such as std::io::prelude. Various libraries in the Rust ecosystem may also define their own preludes.
```

Now turning the page, he discovers a quintessential piece of the magic of rust:

```text
The :: syntax in the ::new line indicates that new is an associated function of the String type. An associated function is a function that’s implemented on a type, in this case String. This new function creates a new, empty string. You’ll find a new function on many types because it’s a common name for a function that makes a new value of some kind.

In full, the let mut guess = String::new(); line has created a mutable variable that is currently bound to a new, empty instance of a String. Whew!
```

~ Once again old friend... I remember your teaching (just three years ago, I was still using this magic).

Nostalgia might have struck the wizard in his journey through he piles of forbidden knowledge, his soul is fragile because of the memories and he reads as his hands melts in the letter of the page:

```text
The & indicates that this argument is a reference, which gives you a way to let multiple parts of your code access one piece of data without needing to copy that data into memory multiple times. References are a complex feature, and one of Rust’s major advantages is how safe and easy it is to use references. You don’t need to know a lot of those details to finish this program. For now, all you need to know is that, like variables, references are immutable by default. Hence, you need to write &mut guess rather than &guess to make it mutable. (Chapter 4 will explain references more thoroughly.)
```

The mage needs to keep moving forward, he steps on a new room and he notices that the spell he is crafting contains an `.expect` he doesn't understand what is going on? Does Rustaceans use expect after every method call he wonder. Somehow an idea flashes through his brain:

```text
Result’s variants are Ok and Err. The Ok variant indicates the operation was successful, and it contains the successfully generated value. The Err variant means the operation failed, and it contains information about how or why the operation failed.
```

Finally, he through his discovery of the `rand` library he ran `cargo add rand`, but now he realized that something else existed. He discovered the place of the Rustaceans:

```text
When we include an external dependency, Cargo fetches the latest versions of everything that dependency needs from the registry, which is a copy of data from Crates.io. Crates.io is where people in the Rust ecosystem post their open source Rust projects for others to use.
```

>Note to Self: You won’t just know which traits to use and which methods and functions to call from a crate, so each crate has documentation with instructions for using it. Another neat feature of Cargo is that running the `cargo doc --open` command will build documentation provided by all your dependencies locally and open it in your browser. If you’re interested in other functionality in the rand crate, for example, run `cargo doc --open` and click rand in the sidebar on the left.

The mage is surprised, in the scribes he notes something not seen before the so called `arms` pattern, apparently there is something about this deep magic that is hidden of the information. His former background would is `if statemetns` or `swtich` but apparently is something bigger:

```text
A match expression is made up of arms. An arm consists of a pattern to match against, and the code that should be run if the value given to match fits that arm’s pattern. Rust takes the value given to match and looks through each arm’s pattern in turn. Patterns and the match construct are powerful Rust features: They let you express a variety of situations your code might encounter, and they make sure you handle them all. These features will be covered in detail in Chapter 6 and Chapter 19, respectively.
```

A brief glimpse of a variable with the same variable name but different type, the wizard show how the projection magic casted a shadow of the same object twice:

```text
We create a variable named guess. But wait, doesn’t the program already have a variable named guess? It does, but helpfully Rust allows us to shadow the previous value of guess with a new one. Shadowing lets us reuse the guess variable name rather than forcing us to create two unique variables, such as guess_str and guess, for example. We’ll cover this in more detail in Chapter 3, but for now, know that this feature is often used when you want to convert a value from one type to another type.
```

>  The import statement `use library::module::function;` brings the `function` item to the current scope from the module `module` inside the module `library`.

# Chapter 3: Instantiations (Variables)

The mage, had been tired of all this wonder lately about rustanceans. He had to take a long-rest, after three days of wondering about the strange formulas of such magic, he cleared his mind and on the comfort of his home, he continue reading the book of Rust. 

## Variables and Mutability

The third chapter of such book describe how to build instantiations:

```text
Adding `mut` also conveys intent to future readers of the code by indicating that other parts of the code will be changing this variable’s value.
```

He was surprised about the restrictive nature of this magic, by `default` things wouldn't change unless commanded to. The wizard had already use `constants` as immutable variables but for Rustaceans `constants` mean something different:

```text
Constants can be declared in any scope, including the global scope, which makes them useful for values that many parts of code need to know about.

The last difference is that constants may be set only to a constant expression, not the result of a value that could only be computed at runtime.
```

The magic of **shadowing** is not something the wizard has ever encounter before. I is a dangerous magic, many mistakes can be done through abusing this magic. The only remedy is to state what happens in detail:

```text
Rustaceans say that the first variable is shadowed by the second, which means that the second variable is what the compiler will see when you use the name of the variable.
```

The following are two rules that apply to this technique:

+ First
```text
The second variable (the shadow) overshadows the first (the shadowed), taking any uses of the variable name to itself until either it itself is shadowed or the scope ends.
```
+ Second
```text
We can shadow a variable by using the same variable’s name and repeating the use of the let keyword
```

>[!info] 
>Shadowing is different from marking a variable as `mut` because we’ll get a compile-time error if we accidentally try to reassign to this variable without using the `let` keyword. By using `let`, we can perform a few transformations on a value but have the variable be immutable after those transformations have completed.

## Data Types

A voice whispers through the bool:
~ Keep in mind that Rust is a _statically typed_ language, which means that it must know the types of all variables at compile time.

His minds wonders, and recalls that compilation time is when the binary file i being created. He also links this knowledge with the [[#Chapter 1 Prolog]] and the `cargo --biary`. He also recalled the [[Guessing_Game#Rune I — ` ` The Path Separator | Module Golem Conversation]]. And then he begins understanding...

### Scalar Types

There are four scalar types: integers, floating-points, booleans and characters.

|**Length**|**Signed (i)**|**Unsigned (u)**|**Range Formula (for n bits)**|
|---|---|---|---|
|**8-bit**|`i8` (-128 to 127)|`u8` (0 to 255)||
|**16-bit**|`i16` (~32k)|`u16` (~65k)||
|**32-bit**|`i32` (~2.1B)|`u32` (~4.2B)|**Unsigned:** 0 to $2^n - 1$|
|**64-bit**|`i64` (9 quintillion)|`u64` (18 quintillion)||
|**128-bit**|`i128`|`u128`|**Signed:** -$2^{n-1}$ to $2^{n-1} - 1$|
|**Arch**|`isize`|`usize`|Target CPU dependent (32 or 64-bit)|

> **Wisdom:** Use `i32` as your default integer type in Rust unless you have a specific reason (like array indexing, which requires `usize`) to use another.

### Writing Literals
As many numeric basis exist in the world of us, the representations on rust of the world are also extensive:

| Number literals  | Example       |
| ---------------- | ------------- |
| Decimal          | `98_222`      |
| Hex              | `0xff`        |
| Octal            | `0o77`        |
| Binary           | `0b1111_0000` |
| Byte (`u8` only) | `b'A'`        |

>[!Error] Failed to Cast: Integer Overflow
>When a mage scroll have a variable of type `u8` that can hold values between 0 and 255. If you try to change the variable to a value outside that range, such as 256, _integer overflow_ will occur, which can result in one of two behaviors. When you’re compiling in debug mode, Rust includes checks for integer overflow that cause your program to _panic_ at runtime if this behavior occurs.

### Floating Types
Remember that mages also need precision floating types:

| **Type** | **Size** | **Precision**                            | **Standard** | **Usage Default**                                                                     |
| -------- | -------- | ---------------------------------------- | ------------ | ------------------------------------------------------------------------------------- |
| `f32`    | 32-bit   | Single precision (~7 decimal digits)     | IEEE-754     | Use when memory is tight or for specialized hardware/3D graphics.                     |
| `f64`    | 64-bit   | Double precision (~15-17 decimal digits) | IEEE-754     | **Default.** Offers high precision at roughly the same speed as `f32` on modern CPUs. |
### Compound Types
As a wizard who had spoken the language of the serpent he never know the `compound types` the Rustaceans spoke. This is not common speech within the boundaries of the mage's knowledge. Not even in C, the wisdom wizards mention something like compound types. The book had wrote on a blank page:

```text
Compound types can group multiple values into one type. Rust has two primitive compound types: tuples and arrays.
```

The first description appeared on the first page:
```text
A tuple is a general way of grouping together a number of values with a variety of types into one compound type. Tuples have a fixed length: Once declared, they cannot grow or shrink in size.

We create a tuple by writing a comma-separated list of values inside parentheses. Each position in the tuple has a type, and the types of the different values in the tuple don’t have to be the same.
```

And then the book show the signs of a basic casting:
```rust
fn main() { let tup: (i32, f64, u8) = (500, 6.4, 1); }
```

```text
You wizards can also access a tuple element directly by using a period (`.`) followed by the index of the value you want to access.
```

