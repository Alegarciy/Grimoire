# Linear Regression with Basis Functions: A Formal Review and Extension

## Table of Contents

1. [Purpose of this document](#1-purpose-of-this-document)
2. [The linear regression model](#2-the-linear-regression-model)
3. [Single-output regression and the role of the weight vector](#3-single-output-regression-and-the-role-of-the-weight-vector)
4. [Observations, dimensions, and the design matrix](#4-observations-dimensions-and-the-design-matrix)
5. [Basis functions and feature transformations](#5-basis-functions-and-feature-transformations)
6. [Scalar input with polynomial basis functions](#6-scalar-input-with-polynomial-basis-functions)
7. [Multidimensional input without nonlinear transformations](#7-multidimensional-input-without-nonlinear-transformations)
8. [Multidimensional input with nonlinear basis functions](#8-multidimensional-input-with-nonlinear-basis-functions)
9. [Selective transformations of dimensions](#9-selective-transformations-of-dimensions)
10. [Interaction terms](#10-interaction-terms)
11. [The transformed design matrix](#11-the-transformed-design-matrix)
12. [Why the same feature recipe must be used across observations](#12-why-the-same-feature-recipe-must-be-used-across-observations)
13. [Geometric interpretation](#13-geometric-interpretation)
14. [Summary of the complete line of thought](#14-summary-of-the-complete-line-of-thought)

---

## 1. Purpose of this document

This document formalizes and extends the discussion around linear regression, multidimensional inputs, basis functions, and transformed design matrices.

The motivating notation was:

$$
\tilde{x}_i = \phi(x_i)
$$

and:

$$
\tilde{X}
=
\begin{bmatrix}
\phi(x_1)^T \\
\phi(x_2)^T \\
\vdots \\
\phi(x_N)^T
\end{bmatrix}
$$

The central question is what this notation means when the input may be scalar, multidimensional, polynomially transformed, or selectively transformed by feature.

The main conclusion is:

> A linear regression model is linear in its weights, but the input representation may be nonlinear through the use of basis functions. The transformation function $\phi$ defines the feature representation used by the model.

---

## 2. The linear regression model

A standard linear regression model predicts an output $\hat{y}$ using a weighted sum of features.

For a simple input vector,

$$
x =
\begin{bmatrix}
x_1 \\
x_2 \\
\vdots \\
x_D
\end{bmatrix}
$$

one may write the model as:

$$
\hat{y} = w_0 + w_1x_1 + w_2x_2 + \cdots + w_Dx_D
$$

The term $w_0$ is the intercept or bias term. A common way to include it inside vector notation is to augment the input with a constant value of $1$:

$$
\tilde{x} =
\begin{bmatrix}
1 \\
x_1 \\
x_2 \\
\vdots \\
x_D
\end{bmatrix}
$$

Then:

$$
\hat{y} = \tilde{x}^T w
$$

where:

$$
w =
\begin{bmatrix}
w_0 \\
w_1 \\
w_2 \\
\vdots \\
w_D
\end{bmatrix}
$$

This is the basic vector form of linear regression.

---

## 3. Single-output regression and the role of the weight vector

In the book's notation,

$$
y = f(x,w) = \phi(x)^T w
$$

$w$ is a column vector when the model predicts one scalar output.

If

$$
\phi(x) \in \mathbb{R}^{M}
$$

then

$$
w \in \mathbb{R}^{M}
$$

and

$$
\phi(x)^T w \in \mathbb{R}
$$

Thus, for a single-output regression model, one transformed feature vector is combined with one weight vector to produce one number.

A weight matrix is only needed when the model predicts multiple outputs. For example, if there are $K$ outputs, then one may write:

$$
\hat{y} = \phi(x)^T W
$$

where

$$
W \in \mathbb{R}^{M \times K}
$$

In that case, each column of $W$ corresponds to the weights for one output variable.

---

## 4. Observations, dimensions, and the design matrix

It is useful to separate two types of indices:

| Notation | Meaning |
|---|---|
| $n$ | observation index |
| $j$ | feature or input-dimension index |

A single observation with $D$ original dimensions can be written as:

$$
x^{(n)} =
\begin{bmatrix}
x^{(n)}_1 \\
x^{(n)}_2 \\
\vdots \\
x^{(n)}_D
\end{bmatrix}
$$

Here,

$$
x^{(n)}_j
$$

means: the value of feature $j$ for observation $n$.

For example, if there are three original features, such as size, number of rooms, and distance from the city center, then:

$$
x^{(n)} =
\begin{bmatrix}
\text{size}^{(n)} \\
\text{rooms}^{(n)} \\
\text{distance}^{(n)}
\end{bmatrix}
$$

The full raw design matrix is obtained by stacking observations as rows:

$$
X =
\begin{bmatrix}
x^{(1)}_1 & x^{(1)}_2 & \cdots & x^{(1)}_D \\
x^{(2)}_1 & x^{(2)}_2 & \cdots & x^{(2)}_D \\
\vdots & \vdots & \ddots & \vdots \\
x^{(N)}_1 & x^{(N)}_2 & \cdots & x^{(N)}_D
\end{bmatrix}
$$

where $N$ is the number of observations and $D$ is the number of original input dimensions.

---

## 5. Basis functions and feature transformations

A basis-function transformation is written as:

$$
\phi(x)
$$

It maps the original input into a new feature representation.

For example, if $x$ is scalar, one possible basis transformation is:

$$
\phi(x) =
\begin{bmatrix}
1 \\
x \\
x^2 \\
x^3
\end{bmatrix}
$$

The regression model then becomes:

$$
\hat{y} = \phi(x)^T w
$$

or equivalently,

$$
\hat{y} = w_0 + w_1x + w_2x^2 + w_3x^3
$$

The model is nonlinear in $x$, because of terms like $x^2$ and $x^3$, but it is still linear in the weights:

$$
w_0,\; w_1,\; w_2,\; w_3
$$

This is why it is still considered a linear regression model.

---

## 6. Scalar input with polynomial basis functions

Suppose each observation is a scalar:

$$
x^{(n)} \in \mathbb{R}
$$

A third-degree polynomial basis may be defined as:

$$
\phi\bigl(x^{(n)}\bigr) =
\begin{bmatrix}
1 \\
x^{(n)} \\
\left(x^{(n)}\right)^2 \\
\left(x^{(n)}\right)^3
\end{bmatrix}
$$

Then the transformed design matrix is:

$$
\tilde{X} =
\begin{bmatrix}
1 & x^{(1)} & \left(x^{(1)}\right)^2 & \left(x^{(1)}\right)^3 \\
1 & x^{(2)} & \left(x^{(2)}\right)^2 & \left(x^{(2)}\right)^3 \\
1 & x^{(3)} & \left(x^{(3)}\right)^2 & \left(x^{(3)}\right)^3 \\
\vdots & \vdots & \vdots & \vdots \\
1 & x^{(N)} & \left(x^{(N)}\right)^2 & \left(x^{(N)}\right)^3
\end{bmatrix}
$$

This notation deliberately separates observation indexing from polynomial powers.

- $x^{(n)}$ means observation $n$.
- $\left(x^{(n)}\right)^2$ means observation $n$ after applying the square transformation.

The polynomial degree is not an input-space dimension such as an $\hat{i}$, $\hat{j}$, or $\hat{k}$ coordinate. It is a basis function applied to the scalar input.

---

## 7. Multidimensional input without nonlinear transformations

Now suppose each observation has more than one original dimension:

$$
x^{(n)} =
\begin{bmatrix}
x^{(n)}_1 \\
x^{(n)}_2 \\
x^{(n)}_3
\end{bmatrix}
$$

If no nonlinear feature transformations are used, and only the intercept is added, then:

$$
\phi\bigl(x^{(n)}\bigr) =
\begin{bmatrix}
1 \\
x^{(n)}_1 \\
x^{(n)}_2 \\
x^{(n)}_3
\end{bmatrix}
$$

The transformed design matrix becomes:

$$
\tilde{X} =
\begin{bmatrix}
1 & x^{(1)}_1 & x^{(1)}_2 & x^{(1)}_3 \\
1 & x^{(2)}_1 & x^{(2)}_2 & x^{(2)}_3 \\
1 & x^{(3)}_1 & x^{(3)}_2 & x^{(3)}_3 \\
\vdots & \vdots & \vdots & \vdots \\
1 & x^{(N)}_1 & x^{(N)}_2 & x^{(N)}_3
\end{bmatrix}
$$

The model is:

$$
\hat{y}^{(n)} = w_0 + w_1x^{(n)}_1 + w_2x^{(n)}_2 + w_3x^{(n)}_3
$$

This produces a flat hyperplane with respect to the original input dimensions.

---

## 8. Multidimensional input with nonlinear basis functions

If the original input has two dimensions,

$$
x^{(n)} =
\begin{bmatrix}
x^{(n)}_1 \\
x^{(n)}_2
\end{bmatrix}
$$

then a quadratic basis could be:

$$
\phi\bigl(x^{(n)}\bigr) =
\begin{bmatrix}
1 \\
x^{(n)}_1 \\
x^{(n)}_2 \\
\left(x^{(n)}_1\right)^2 \\
\left(x^{(n)}_2\right)^2 \\
x^{(n)}_1x^{(n)}_2
\end{bmatrix}
$$

The corresponding model is:

$$
\hat{y}^{(n)}
=
w_0
+
w_1x^{(n)}_1
+
w_2x^{(n)}_2
+
w_3\left(x^{(n)}_1\right)^2
+
w_4\left(x^{(n)}_2\right)^2
+
w_5x^{(n)}_1x^{(n)}_2
$$

This model can produce a curved surface over the $(x_1, x_2)$ input plane.

The important idea is that nonlinear basis functions allow the model to represent nonlinear shapes while remaining linear in the weights.

---

## 9. Selective transformations of dimensions

It is not necessary to transform every original dimension in the same way.

For example, one may choose:

$$
\phi(x) =
\begin{bmatrix}
1 \\
x_1 \\
x_2 \\
x_1^2 \\
x_1x_2
\end{bmatrix}
$$

This basis includes $x_1^2$, but it does not include $x_2^2$.

The model becomes:

$$
\hat{y} = w_0 + w_1x_1 + w_2x_2 + w_3x_1^2 + w_4x_1x_2
$$

This means:

- $x_1$ has both a linear effect and a quadratic effect.
- $x_2$ has a linear effect.
- $x_1x_2$ allows the effect of one feature to depend on the value of the other feature.
- There is no independent quadratic effect for $x_2$, because $x_2^2$ was not included in the basis.

Thus, the transformation function $\phi$ may treat different dimensions differently.

A more general example is:

$$
\phi(x) =
\begin{bmatrix}
1 \\
x_1 \\
\log(x_2) \\
x_3^2 \\
x_1x_2
\end{bmatrix}
$$

Here, each original dimension is handled according to the chosen feature recipe. The first feature is used directly, the second is passed through a logarithm, the third is squared, and an interaction term is also included.

The rule is not that every dimension must receive the same transformation. The rule is that the chosen feature representation must be applied consistently to every observation.

---

## 10. Interaction terms

An interaction term combines multiple input dimensions.

For two features, the interaction term is:

$$
x_1x_2
$$

For observation $n$, this is:

$$
x^{(n)}_1x^{(n)}_2
$$

This term allows the model to represent situations where the contribution of $x_1$ depends on the value of $x_2$, or vice versa.

For example:

$$
\hat{y} = w_0 + w_1x_1 + w_2x_2 + w_3x_1x_2
$$

The marginal effect of $x_1$ depends on $x_2$:

$$
\frac{\partial \hat{y}}{\partial x_1} = w_1 + w_3x_2
$$

Thus, interaction terms are not merely extra polynomial terms. They encode relationships between dimensions.

---

## 11. The transformed design matrix

For the selective basis,

$$
\phi(x) =
\begin{bmatrix}
1 \\
x_1 \\
x_2 \\
x_1^2 \\
x_1x_2
\end{bmatrix}
$$

and observations,

$$
x^{(n)} =
\begin{bmatrix}
x^{(n)}_1 \\
x^{(n)}_2
\end{bmatrix}
$$

one obtains:

$$
\tilde{X} =
\begin{bmatrix}
1 & x^{(1)}_1 & x^{(1)}_2 & \left(x^{(1)}_1\right)^2 & x^{(1)}_1x^{(1)}_2 \\
1 & x^{(2)}_1 & x^{(2)}_2 & \left(x^{(2)}_1\right)^2 & x^{(2)}_1x^{(2)}_2 \\
1 & x^{(3)}_1 & x^{(3)}_2 & \left(x^{(3)}_1\right)^2 & x^{(3)}_1x^{(3)}_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
1 & x^{(N)}_1 & x^{(N)}_2 & \left(x^{(N)}_1\right)^2 & x^{(N)}_1x^{(N)}_2
\end{bmatrix}
$$

Each row corresponds to one observation after transformation. Each column corresponds to one selected basis function evaluated across all observations.

Equivalently,

$$
\tilde{X}_{n,j} = \phi_j\bigl(x^{(n)}\bigr)
$$

where:

- $n$ indexes observations.
- $j$ indexes basis functions.

---

## 12. Why the same feature recipe must be used across observations

The transformation $\phi$ is part of the model definition.

Once a feature recipe is chosen, every observation must be transformed using that same recipe.

For example, if

$$
\phi(x) =
\begin{bmatrix}
1 \\
x_1 \\
x_2 \\
x_1^2 \\
x_1x_2
\end{bmatrix}
$$

then every observation must produce a row with exactly these columns:

$$
\begin{bmatrix}
1 & x_1 & x_2 & x_1^2 & x_1x_2
\end{bmatrix}
$$

The reason is that the model learns one shared weight vector:

$$
w =
\begin{bmatrix}
w_0 \\
w_1 \\
w_2 \\
w_3 \\
w_4
\end{bmatrix}
$$

Each weight must correspond to a stable column meaning:

| Weight | Associated basis feature |
|---|---|
| $w_0$ | $1$ |
| $w_1$ | $x_1$ |
| $w_2$ | $x_2$ |
| $w_3$ | $x_1^2$ |
| $w_4$ | $x_1x_2$ |

If the columns changed meaning from one observation to another, then the same weight would no longer have a consistent interpretation. The matrix equation

$$
\hat{y} = \tilde{X}w
$$

would no longer represent a coherent regression model.

Therefore:

> Different dimensions may be transformed differently, but the chosen transformation recipe must be applied consistently across all observations.

---

## 13. Geometric interpretation

The geometry depends on both the original input dimension and the chosen basis functions.

### One original input dimension

If

$$
\hat{y} = w_0 + w_1x
$$

then the model is a line in the $(x, y)$ plane.

If

$$
\hat{y} = w_0 + w_1x + w_2x^2
$$

then the model may be a curve, such as a parabola.

### Two original input dimensions

If

$$
\hat{y} = w_0 + w_1x_1 + w_2x_2
$$

then the model is a plane in $(x_1, x_2, y)$ space.

If

$$
\hat{y}
=
w_0
+
w_1x_1
+
w_2x_2
+
w_3x_1^2
+
w_4x_2^2
+
w_5x_1x_2
$$

then the model may be a curved surface over the $(x_1, x_2)$ input plane.

### Three or more original input dimensions

For three input dimensions and one output, the graph would live in four dimensions:

$$
(x_1, x_2, x_3, \hat{y})
$$

This is no longer easy to visualize directly. The model is usually described as a hyperplane if the features are linear, or as a curved hypersurface if nonlinear basis functions are used.

---

## 14. Summary of the complete line of thought

The full interpretation is as follows.

A raw observation is written as:

$$
x^{(n)}
$$

If the input is multidimensional, then:

$$
x^{(n)} =
\begin{bmatrix}
x^{(n)}_1 \\
x^{(n)}_2 \\
\vdots \\
x^{(n)}_D
\end{bmatrix}
$$

A basis-function transformation defines how this observation is represented for the model:

$$
\tilde{x}^{(n)} = \phi\bigl(x^{(n)}\bigr)
$$

The transformed observations are stacked into a matrix:

$$
\tilde{X} =
\begin{bmatrix}
\phi\bigl(x^{(1)}\bigr)^T \\
\phi\bigl(x^{(2)}\bigr)^T \\
\vdots \\
\phi\bigl(x^{(N)}\bigr)^T
\end{bmatrix}
$$

The prediction for all observations is:

$$
\hat{y} = \tilde{X}w
$$

The prediction for a single observation is:

$$
\hat{y}^{(n)} = \phi\bigl(x^{(n)}\bigr)^T w
$$

The key distinctions are:

| Concept | Meaning |
|---|---|
| Original dimension | A raw input coordinate such as $x_1$ or $x_2$ |
| Observation index | Which data point is being considered |
| Basis function | A selected transformation such as $x_1^2$, $\log(x_2)$, or $x_1x_2$ |
| Weight | A learned coefficient attached to one basis function |
| Design matrix column | One basis function evaluated across all observations |

The final conceptual statement is:

> Linear regression learns weights for a fixed set of basis functions. The basis functions may be raw dimensions, nonlinear transformations of dimensions, or interactions between dimensions. The model remains linear in the weights, even when it is nonlinear in the original inputs.
