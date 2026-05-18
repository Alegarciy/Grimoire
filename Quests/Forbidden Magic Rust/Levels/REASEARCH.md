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

