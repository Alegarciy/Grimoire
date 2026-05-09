# A Wizard's Guide to Numpy (1st Level Spells)

## Believes to cast Numpy spells

+ A Wizard first must give body and soul to array-oriented computing
+ Everything and anything originated form C, we use the serpent as a funnel
+ Type Checking is poison
+ Numpy blessed its people with less memory utilization
+ C algorithms spells avoid overhead 

## Time Casting and Readings
A mage who uses `%timeit` spell book magic [timeit docs](%timeit array_mult_2_spell = array_spell * 2) needs to understand the next symbolisms:

+ μs = microseconds = 0.000001 seconds (10**-6)
+ ms = milliseconds = 0.001 seconds (10**-3)

### Casting Speech for `Timeit`
A mage will module his speech when casting the spell the next way:

+ 199 μs per loop = 0.199ms

Assume a casting time of 27.4 seconds were to be compared with 199 microseconds (or 0.199ms) then:

27.4 / 0.199 = *x138 times 0.199 fits in 27.4 microseconds*

_One loop of 0.199 microseconds is the same as a single loop of 27.4 that means the first one is x138 better_

> Note: Remember wizard, on the path to timely measurements Jitter is a factor, time calculations are averaged through many iterations, randomness magic is derived from chaos itself. Embrace it, live with it, understand it may your travels be not filled with doubt but curiosity.

## Advice for the Wise

+ You will make a habit of that whom use `np` prefix before desiring to cast a NumPy spell, rather to avoid presets conflicts of the Python Wizards.

## Translating NumPy syntax into a Latex syntax
Even though there are similar expression a Latex syntax is easily handy when proposing similar endevours on white paper publications. It is that of a wise man to address this with key importance:

Example (1): Matrix Syntax

```python
array_magic = np.array([[1.5,-0.1,3],[0,-3,6.5]])
```

```latex
\[
\mathrm {data} =
\begin{bmatrix}
1.5 & -0.1 & 3 \\
0 & -3 & 6.5
\end {bmatrix}
\]
```

## NumPy Array Creation Functions

- **`array`**: Convert input data (list, tuple, array, or other sequence type) to an `ndarray`, either by inferring a data type or explicitly specifying one. Copies
the input data by default.

- **`asarray`**: Convert input to an `ndarray`, but do not copy if the input is already an `ndarray`.

- **`arange`**: Like the built-in `range`, but returns an `ndarray` instead of a list.

- **`ones`**, **`zeros`**, **`empty`**, **`full`**: Create new arrays with a given shape and data type. `ones` fills the array with `1`s, `zeros` fills it with `0`s, `empty` allocates memory without initializing the values, and `full` fills the array with a specified value.

- **Suffix `*_like`**: Functions ending in `_like`, such as `ones_like`, `zeros_like`, `empty_like`, and `full_like`, create a new array using another array’s shape and data type.

- **`eye`**, **`identity`**: Create a square `N × N` identity matrix (`1`s on the diagonal and `0`s elsewhere).

## Magic Binaries

8 = 2^3
16 = 2^4
32 = 2^5
64 = 2^6

+ **`int(8,16,32,64)`**: signed integers stored in 8, 16, 32, or 64 bits. Typical ranges: `[-128, 127]`, `[-32_768, 32_767]`, `[-2_147_483_648, 2_147_483_647]`, [...]

+ **`uint(8,16,32,64)`**: unsigned integers stored in 8, 16, 32, or 64 bits. Typical ranges: `[0, 255]`, `[0, 65_535]`, `[0, 4_294_967_295]`, [...]

+ **`float(16,32,64,128)`**: floating-point numbers stored in 16, 32, 64, or 128 bits. Approximate decimal precision: `float16` ≈ 3–4 digits, `float32` ≈ 6–7 digits, `float64` ≈ 15–16 digits, `float128` ≈ 18–19 digits on many systems. Availability and exact precision of `float128` depend on the platform.

+ **`complex(64,128,256)`**: complex numbers whose real and imaginary parts are stored as floating-point values. Higher bit sizes give greater precision.

+ **`bool`**: Boolean values, either `True` or `False`.

+ **`object`**: Python objects stored in the array instead of a fixed numeric type.

+ **`string`**: 1byte per character

## NumPy special wizardy language

In deterministic langueges wizards commonly use `for loops` to re-create mathemmatical expressions that might involve traversal to a particular set of data. Numpy wizards called thme **`vectorization`**. 

## Numpy Reference && Slicing

Despite of the surprising slicing casting techniques, slicing means and does not mean something.

What slicing mean: 
+ Create a vector out of another vector

What slicing does not mean:
+ Create a vector with newly instantiated attributes

NumPy wizards believe that perfomant code required this measured. And if a caster wants to access the magic of instantiation he gotta cast `copy()`

### Slicing Default Behavior
By default the NumPy magic conversta any single row/column into a tuple shape `(dim,)` so despite being on axis 0 or axis 1 it is still consider a tuple.

Firstly we will show a tuple interpretation:
+ a[1, :].shape => (3,)
+ a[:, 1].shape => (2,)

Both shapes are tuples but for a Wizard its sometimes valueable to know if the single dimension preserved is the Axis 0 or the Axis 1. So how to preserve such information when the magic forbids it? You would do:
+ a[1:2, :].shape => (1,3)
+ a[:, 1:2].shape => (3,1)

## The Masks

"Maskharah" from the Arabic origin conceived as the "blackening/covering of onces face", is a pre-conception of the object whose person when used allow us to see what they want to see and hide what they want to hide. Wizards from computation adept in the art of speech stumble with such behavior while parsing through the arcane magic of binaries:

data: 10110110
mask: 11110000
_______________ AND OPERATOR
resu: 10110000

This was conceived as the "bit mask",  a networking concept utilized for the most adept of the programmer, the precursor to those who stumble into magic this days. The true titans. Let it be known that the abstraction is simple, efficient, enginius:

1 = keep / reveal / care about this bit
0 = hide / erase / ignore this bit

And wizards omage this ingenuity with the same respect, as once wizards before us did. In Numpy a mask is:

"A condition you will use with `dtype=Bool` to allow to reveal a part of a numpy array"

```python
mask = (names == "Bob") | (names == "Will)
# [ True, False ... ,True, True]
```
Then if called the mask to perfom a "AND" analogous reference:

```python
data[mask]
# [ value, -eliminate false- , ... , value, value]
```

And this will create **always a new data** it is not required to cast `copy()` upon it.