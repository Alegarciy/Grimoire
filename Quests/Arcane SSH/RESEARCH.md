# Arcane's Magic Research Log

## Chapter 01: The Candle of Concurrency

Decipher: _A novice believes one program can guard only one gate. A wizard knows a single tower can have many doors, each watches by a different summoned task._

```text
Hint: The Journey begins with the "Tokio Runtime Spellbook"
```

First path: https://tokio.rs/tokio/tutorial
### What is it

Definition:
```text
Tokio is an asynchronous runtime for the Rust programming language. It provides the building blocks needed for writing network applications. It gives the flexibility to target a wide range of systems, from large servers with dozens of cores to small embedded devices.
```

Protects us against:
+ **Unbounded Queues**
+ **Buffer Overflows**
+ **Task starvation**

Purpose:
```text
When you write your application in an asynchronous manner, you enable it to scale much better by reducing the cost of doing many things at the same time. However, asynchronous Rust code does not run on its own, so you must choose a runtime to execute it. The Tokio library is the most widely used runtime, surpassing all other runtimes in usage combined.

Additionally, Tokio provides many useful utilities. When writing asynchronous code, you cannot use the ordinary blocking APIs provided by the Rust standard library, and must instead use asynchronous versions of them. These alternate versions are provided by Tokio, mirroring the API of the Rust standard library where it makes sense.
```

~ Why we need asynchronous code? (Asks the wizard to himself)

He first searches through Wikipedia
```text
Asynchrony, in computer programming, refers to the occurrence of events independent of the main program flow and ways to deal with such events. These may be "outside" events such as the arrival of signals, or actions instigated by a program that take place concurrently with program execution, without the program hanging to wait for results.
- Wikipedia
```

He then keeps investigating in the documentation:
```text
With the async/await language feature, increasing the number of concurrent operations becomes incredibly cheap, allowing you to scale to a large number of concurrent tasks.
```

## Chapter 02: Setup of Tokio Spells

Prolog:
```text
This tutorial will take you step by step through the process of building a Redis client and server. We will start with the basics of asynchronous programming with Rust and build up from there. We will implement a subset of Redis commands but will get a comprehensive tour of Tokio.
```

The wizard will deviate form the path to understand what is `mini-redis`:
```text
mini-redis is an incomplete, idiomatic implementation of a Redis client and server built with Tokio.

The intent of this project is to provide a larger example of writing a Tokio application.

Disclaimer Please don't use mini-redis in production. This project is intended to be a learning resource, and omits various parts of the Redis protocol because implementing them would not introduce any new concepts. We will not add new features because you need them in your project — use one of the fully featured alternatives instead.
```

~ Man, I believe this is the time for me to start with applying the knowledge I have recovered from my previous journey.

> Cast Invocation: `gh repo clone tokio-rs/mini-redis`

Now, that the magic of `mini-redis` is under my power, the wizard can study its secrets, and see you it works. He then proceeds to examine its components:

Tracing Packaging Magic:
```text
Tokio Tracing: tracing is a framework for instrumenting Rust programs to collect structured, event-based diagnostic information. tracing is maintained by the Tokio project, but does not require the tokio runtime to be used.
```

Host to Cloud Log Magic:
```text
OpenTelemetry is an open source observability framework for cloud native software. It provides a single set of APIs, libraries, agents, and collector services to capture distributed traces and metrics from your application.

OpenTelemetry builds upon years of experience from the OpenTracing and OpenCensus projects, combined with best-of-breed ideas and practices from the community.
```

~ I wonder what is necessary open telemetry... (the mage asks himself)
~ I know! I will ask Golem, my trusty companion to answer my question.
~ Golem tell me about: [[Open Telemetry]]

