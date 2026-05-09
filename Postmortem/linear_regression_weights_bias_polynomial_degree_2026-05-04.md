# Postmortem: Linear regression weights, bias term, and polynomial degree counting

Date: 2026-05-04

## Summary
This note clarifies three linked points that commonly cause confusion in linear regression:

1. whether the solved vector `w` includes the bias term,
2. how to encode the bias using an augmented design matrix, and
3. why a polynomial of degree `d` in one variable has `d + 1` weights.

The key conclusion is:

> If the design matrix is augmented with a leading column of ones, then the learned parameter vector contains the bias term as its first entry. For a 1D polynomial of degree `d`, the full parameter vector has `d + 1` entries because it contains one coefficient for each power from `x^0` through `x^d`.

---

## Core setup
Given data matrix `X` and target vector `y`, linear regression solves for weights that minimize squared error.

If the model is written as:

$$
\hat{y} = Xw + b
$$

then the bias/intercept `b` can be absorbed into the matrix form by defining:

```python
Xi = np.c_[np.ones(X.shape[0]), X]
```

Now the model becomes:

$$
\hat{y} = X_i \theta
$$

where:

$$
\theta =
\begin{bmatrix}
b \\
w_1 \\
w_2 \\
\vdots
\end{bmatrix}
$$

So the first element is the bias, and the rest are ordinary feature weights.

---

## Normal equation interpretation
The closed-form least-squares solution is:

$$
\theta = (X_i^T X_i)^{-1} X_i^T y
$$

In NumPy:

```python
theta = np.linalg.inv(Xi.T @ Xi) @ Xi.T @ y
```

More numerically stable alternatives are:

```python
theta = np.linalg.solve(Xi.T @ Xi, Xi.T @ y)
```

or:

```python
theta = np.linalg.lstsq(Xi, y, rcond=None)[0]
```

Interpretation:
- `theta[0]` = bias/intercept
- `theta[1:]` = learned weights for the columns of `X`

---

## Main clarification: does `w` include the bias?
Yes — if the first column of the design matrix is all ones, then the solved vector includes the bias term.

In other words, if:

```python
Xi = np.c_[np.ones(X.shape[0]), X]
```

then the parameter vector is conceptually:

```python
w = [w0, w1, w2, ...]
```

with:
- `w0` = bias
- `w1`, `w2`, ... = feature weights

Prediction can be written either as:

```python
y_pred = Xi @ w
```

or equivalently:

```python
y_pred = w[0] + X @ w[1:]
```

These are the same model.

---

## Polynomial form in one variable
For a single scalar input `x`, a polynomial regression model of degree `d` is:

$$
f(x) = w_0 + w_1 x + w_2 x^2 + \cdots + w_d x^d
$$

This is still linear regression because it is linear in the coefficients `w_0, ..., w_d`, even though it is nonlinear in `x`.

The corresponding transformed row for one sample is:

$$
[1, x, x^2, \dots, x^d]
$$

So the design matrix has one column per polynomial basis term.

---

## Why the number of weights is degree + 1
This was the central counting question.

For degree `d`, the polynomial includes all powers:

- `x^0` which is the constant term,
- `x^1`,
- `x^2`,
- ...
- `x^d`.

That is a total of:

$$
d + 1
$$

terms.

Therefore:

> For a 1D polynomial of degree `d`, the number of weights is exactly `d + 1`.

Examples:

### Degree 1
$$
f(x) = w_0 + w_1 x
$$
- weights: 2
- formula: `degree + 1 = 1 + 1 = 2`

### Degree 2
$$
f(x) = w_0 + w_1 x + w_2 x^2
$$
- weights: 3
- formula: `degree + 1 = 2 + 1 = 3`

### Degree 5
$$
f(x) = w_0 + w_1 x + w_2 x^2 + w_3 x^3 + w_4 x^4 + w_5 x^5
$$
- weights: 6
- formula: `degree + 1 = 5 + 1 = 6`

---

## GeoGebra mapping
If the model is to be entered into GeoGebra, it can be written directly in coefficient form.

### Linear
```text
f(x) = w0 + w1 x
```

### Quadratic
```text
f(x) = w0 + w1 x + w2 x^2
```

### Cubic
```text
f(x) = w0 + w1 x + w2 x^2 + w3 x^3
```

General degree `d`:

```text
f(x) = w0 + w1 x + w2 x^2 + ... + wd x^d
```

So if GeoGebra is showing a polynomial of degree `d`, the coefficient count is still `d + 1`.

---

## Regularization note
A ridge-regularized version modifies the normal equation to:

$$
\theta = (X_i^T X_i + \lambda I)^{-1} X_i^T y
$$

In NumPy:

```python
lambd = 0.1
I = np.eye(Xi.shape[1])
theta = np.linalg.solve(Xi.T @ Xi + lambd * I, Xi.T @ y)
```

If the first coefficient is the bias term, one often does **not** regularize it:

```python
I[0, 0] = 0
```

Then:
- `theta[0]` remains the bias,
- `theta[1:]` remain the feature weights,
- and only the non-bias terms are penalized.

---

## Common confusion resolved
### Confusion 1
**“Is `w` only the slopes?”**

Not if the input matrix has been augmented with a ones column. In that case `w` is the full parameter vector, including bias.

### Confusion 2
**“Did we forget to calculate the bias?”**

No. Once the ones column is added, the bias is learned automatically as the first coefficient.

### Confusion 3
**“How many weights does a polynomial have?”**

For one variable and degree `d`, it has `d + 1` weights, because the constant term counts as one coefficient.

---

## Final takeaway
The clean mental model is:

1. Add a ones column if you want the bias inside the matrix equation.
2. Solve for one parameter vector.
3. Interpret the first entry as the bias.
4. For a 1D polynomial of degree `d`, use basis terms `[1, x, x^2, ..., x^d]`.
5. Therefore, total weights = `d + 1`.

## One-line conclusion
For polynomial linear regression in one variable, the coefficient vector includes the bias term, and the total number of weights is always **degree + 1**.
