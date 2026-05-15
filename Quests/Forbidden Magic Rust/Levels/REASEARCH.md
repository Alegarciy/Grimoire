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