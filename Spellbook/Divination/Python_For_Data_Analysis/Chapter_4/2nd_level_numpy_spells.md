# A Wizard's Guide to Numpy (2nd Level Spells)

## Fancy Indexing

As a well formed wizard, the lore of the syntax opens up to you. You see beyond the basic construction of magic and you tap into more powerful and complex concepts of the Spellbook of NumPy.

`Fancy indexing` is a term adpted by the NumPy school that referce to emiting cast spells with notations like `arr[[row_4, row_3, row_0, row_6]]`

## Advanced Array Manipuation Magic 

### Reshapeing Arrays

One of the most powerful casting spells is the reshaping spell. It allows you to reshape and existing array from on shape to another **without copying any of the data**.

```python
arr = np.arange(8)
# Out [1]: array([0, 1, 2, 3, 4, 5, 6, 7])

arr.reshape((4, 2))
# array([
# [0, 1],
# [2, 3],
# [4, 5],
# [6, 7]
# ])
```