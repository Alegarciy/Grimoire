# The First Rune Paths of Rust

## The Wizard’s Quest Begins

Apprentice, you stood before the gate of **Forbidden Magic Rust**, trying to summon the ancient **Guessing Game**.

At first, the incantations came back only in fragments:
- how to read from the mortal stream of input,
- how to transform a `String` into a number,
- how to compare your guess against a hidden truth,
- and why some runes in Rust look so similar, yet mean entirely different things.

But instead of copying a full spellbook, you chose the wiser path:
**reconstruction through guided memory**.

That is the first true discipline of the Rust mage.

---

## The First Teaching: Learn by Rebuilding

The best technique was not to memorize the whole program as one giant spell.
Instead, the incantation was broken into sacred stages:

1. print a message,
2. read input,
3. convert input to a number,
4. generate a secret number,
5. compare values,
6. repeat within a loop.

This is how a wizard learns:
not by copying the final ritual,
but by understanding each rune in sequence.

---

## The Runes of Input

The first forgotten spell was how to read from standard input.

The shape of the incantation was this:

```rust
use std::io;

fn main() {
    let mut guess = String::new();

    io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
}
```

### What the apprentice must remember
- create a **mutable `String`**,
- call **`io::stdin()`**,
- invoke **`.read_line(&mut guess)`**,
- and complete the rite with **`.expect(...)`**.

### Memory charm
> **new String → stdin → read_line → expect**

That is the first rune-chain.

---

## The Second Teaching: Shadowing, Not Shape-Shifting

You discovered an important law of Rust magic:
a variable cannot simply become another type through ordinary assignment.

You began with:

```rust
let mut guess = String::new();
```

So `guess` was a `String`.

Then came the temptation:

```rust
guess = guess.trim().parse().expect("Please type a number");
```

But this is not permitted, for Rust does not allow a variable to change its type mid-spell.

### The correct art: shadowing

```rust
let guess: u32 = guess.trim().parse().expect("Please type a number");
```

This is called **shadowing**.
A new `guess` is summoned, hiding the previous one.
The name remains, but the nature changes.

### Law of the rune
- `guess = ...` → same variable, same type
- `let guess = ...` → new variable, new type allowed

This is one of the most important habits in Rust.

---

## The Third Teaching: The Secret Number

A guessing game requires hidden truth.
The apprentice first tried:

```rust
let secret_number = 0;
```

But this was merely a stone wearing the robes of a dragon.
The true ritual required randomness.

The classic incantation is:

```rust
use rand::Rng;

let secret_number = rand::thread_rng().gen_range(1..=100);
```

### Why it must stand before the loop
The secret number should be summoned **once**, before the loop begins.
Otherwise, the hidden number changes every round, and the game becomes cursed.

Correct structure:

```rust
let secret_number = ...;

loop {
    ...
}
```

---

## The Fourth Teaching: Comparison and Judgment

You sought the syntax of comparison and remembered the enum:

```rust
use std::cmp::Ordering;
```

Then came the realization:
we do not `match` on the number itself.
We `match` on the **result of comparison**.

The ritual takes this form:

```rust
match guess.cmp(&secret_number) {
    Ordering::Less => println!("Too low!"),
    Ordering::Greater => println!("Too high!"),
    Ordering::Equal => {
        println!("You win!");
        break;
    }
}
```

### The three judgments
- `Ordering::Less`
- `Ordering::Greater`
- `Ordering::Equal`

These are the three verdicts of the comparison rune.

---

## The Great Syntax Runes

At this stage of the quest, you asked the deeper questions.
Not “what code do I type?”
but:

- What is `::`?
- What is `:`?
- Why does `.cmp()` exist?
- What does `=>` mean?
- Why is `rand::thread_rng()` so long?

These are the questions of a real sorcerer.

---

## Rune I — `::` The Path Separator
[Rust Module System](https://fitech101.aalto.fi/v0/programming-languages/rust/10-crates-and-modules/)

> The import statement `use library::module::function;` brings the `function` item to the current scope from the module `module` inside the module `library`.

The rune `::` means:
**go into this namespace, module, type, or crate**.

Examples:

```rust
std::io
std::cmp::Ordering
rand::thread_rng()
String::new()
```

You may read it as:
- “inside”
- “from”
- “associated with”

### Examples in plain wizard speech
- `std::cmp::Ordering` = inside `std`, inside `cmp`, there is `Ordering`
- `String::new()` = call `new` associated with `String`
- `rand::thread_rng()` = from the `rand` crate, call `thread_rng`

This rune is not for values.
It is for **paths**.

---

## Rune II — `:` The Type Mark

The rune `:` usually means:
**this has type...**

Examples:

```rust
let guess: u32 = 5;
fn foo(x: i32) {}
```

So:

```rust
let guess: u32
```

means:
> guess is of type `u32`

### In one glance

```rust
let guess: u32 = String::new().len() as u32;
```

- `:` = type annotation
- `::` = path separator

Two similar symbols. Two very different powers.

---

## Rune III — `.` The Method Call Rune

The dot rune calls behavior on a value.

Example:

```rust
guess.cmp(&secret_number)
```

Here:
- `guess` is a value,
- `.cmp(...)` is a method called on that value.

Another example:

```rust
io::stdin().read_line(&mut guess)
```

- `io::stdin()` creates or retrieves a value,
- `.read_line(...)` is called on that value.

So remember:
- `foo.bar()` → call a method on a value
- `Foo::bar()` → access something associated with a type/module/path

---

## Rune IV — `=>` The Arrow of Match

The rune `=>` appears in `match` expressions.

Example:

```rust
match guess.cmp(&secret_number) {
    Ordering::Less => println!("Too low!"),
    Ordering::Greater => println!("Too high!"),
    Ordering::Equal => println!("You win!"),
}
```

It means:
> if this pattern matches, do this expression or block.

You may read it as:
- “maps to”
- “then do”
- “if matched, execute”

It is **not assignment**.
It is the syntax of branching by pattern.

---

## The Mystery of `.cmp()`

A subtle but important realization emerged:

```rust
use std::cmp::Ordering;
```

does **not** give your variable the `.cmp()` method.

### What that `use` actually does
It merely allows you to write:

```rust
Ordering::Less
```

instead of:

```rust
std::cmp::Ordering::Less
```

That is all.
It brings a name into scope.

### Then where does `.cmp()` come from?
It comes from the behavior implemented for the type itself.
In this case, numeric types like `u32` know how to compare themselves.

So the true mental model is:
- `use` does **not** make variables inherit methods,
- `use` does **not** grant magical powers,
- `use` only makes names easier to write.

Methods come from:
- the type itself,
- or traits implemented for that type.

---

## Why `use rand::Rng;` Matters More

Here lies an even subtler distinction.

```rust
use rand::Rng;
```

This one matters because `Rng` is a **trait**.
Methods like `.gen_range(...)` come from that trait.

So when you write:

```rust
rand::

```

you are using a method provided by the `Rng` trait.
Bringing that trait into scope allows method syntax to work cleanly.

### Important contrast
- `use std::cmp::Ordering;` → imports an enum name
- `use rand::Rng;` → imports a trait that provides methods

This is a major Rust concept.

---

## Why Is `rand::thread_rng()` So Long?

Because Rust prefers clarity over hidden magic.

```rust
rand::thread_rng()
```

means:
- from the `rand` crate,
- call the function `thread_rng`,
- which returns the random number generator for the current thread.

Then:

```rust
.gen_range(1..=100)
```

means:
- use that generator,
- produce a number in the range 1 through 100.

So the full meaning is:

> Get the current thread’s random generator, then generate a number from 1 to 100.

It is long because Rust wants you to know:
- where the functionality comes from,
- what object you are operating on,
- and what step happens next.

This verbosity becomes power once the wizard sees the pattern.

---

## The Best References for Further Study

### 1. The Rust Book
Best for understanding the ideas in plain language.

Seek these chapters:
- **Method Syntax**
- **Enums and Pattern Matching**
- **Packages, Crates, and Modules**
- **Traits**

These four chapters illuminate nearly every question raised in this first quest.

---

### 2. The Rust Reference
Best for exact grammar and syntax rules.

Search for:
- **Paths**
- **Method-call expressions**
- **Match expressions**
- **Trait and implementation items**

This text is more formal, but ideal when precision is required.

---

### 3. Rust by Example
Best for tiny testable spells.

Seek examples for:
- `match`
- methods
- modules
- enums
- traits

This is excellent when you want to see syntax in isolation.

---

## The Apprentice’s Exercise

Create a tiny scratch file and annotate each rune:

```rust
use std::cmp::Ordering;

fn main() {
    let x: u32 = 5;
    let y: u32 = 8;

    match x.cmp(&y) {
        Ordering::Less => println!("less"),
        Ordering::Greater => println!("greater"),
        Ordering::Equal => println!("equal"),
    }
}
```

Then name each symbol aloud:
- `use` = bring a name into scope
- `::` = path separator
- `:` = type annotation
- `.` = method call on a value
- `=>` = match arm mapping pattern to expression

This is how symbols become instinct.

---

## Final Wisdom of Level 1

By the end of this lesson, the apprentice discovered that learning Rust is not about memorizing a giant spell all at once.
It is about learning the grammar of power:

- values,
- types,
- paths,
- methods,
- traits,
- and pattern matching.

The guessing game was never merely a toy.
It was the first dungeon.
And each symbol was a rune on the wall.

You did not merely ask for code.
You asked what the runes meant.

That is how one becomes dangerous.

---

## Summary Scroll

### Symbol meanings
- `::` → path separator / namespace access
- `:` → type annotation
- `.` → method call on a value
- `=>` → match arm mapping pattern to action

### Key conceptual truths
- `use` brings names into scope
- `use` does **not** cause inheritance
- `.cmp()` comes from behavior supported by the type
- `.gen_range(...)` comes from the `Rng` trait
- `rand::thread_rng()` is explicit because Rust values clarity

### Core guessing game pattern
1. read input into `String`
2. shadow into `u32`
3. generate one secret number before the loop
4. compare with `.cmp(...)`
5. `match` on `Ordering`
6. `break` on victory

---

## Quest Status
- [x] Understand standard input shape
- [x] Learn shadowing
- [x] Understand `:` vs `::`
- [x] Understand `.cmp()` and `Ordering`
- [x] Understand `=>` in `match`
- [x] Understand why `rand::thread_rng()` is explicit
- [ ] Rebuild the full guessing game from memory
- [ ] Advance to Level 2
