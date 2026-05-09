# ML Python Cheatsheet — 02451

Quick reference for common functions used in the Introduction to Machine Learning exercises.

---

## NumPy

### Array Creation & Loading

| Function | What it does |
|---|---|
| `np.array(x)` / `np.asarray(x)` | Create or convert to array |
| `np.load("file.npy")` | Load `.npy` file |
| `np.loadtxt("file.txt")` | Load text file |
| `np.linspace(a, b, n)` | `n` evenly spaced values from `a` to `b` |
| `np.zeros(shape)` | Array of zeros |
| `np.concatenate([a, b])` | Join arrays |
| `np.meshgrid(x, y)` | Coordinate matrices from vectors |

### Statistics

| Function | What it does |
|---|---|
| `np.mean(x)` | Mean |
| `np.median(x)` | Median |
| `np.std(x, ddof=0)` | Std dev (`ddof=1` for unbiased) |
| `np.sum(x)` / `np.nansum(x)` | Sum (ignoring NaNs) |
| `np.nanmedian(x)` | Median ignoring NaNs |
| `np.min(x)` / `np.max(x)` | Min / Max |
| `np.corrcoef(X)` | Correlation matrix |

### Math & Linear Algebra

| Function | What it does |
|---|---|
| `np.dot(a, b)` | Dot product |
| `np.sqrt(x)` | Element-wise square root |
| `np.power(x, n)` | Element-wise exponentiation |
| `np.linalg.norm(x)` | Vector/matrix norm (magnitude) |
| `np.linalg.svd(X)` | Singular Value Decomposition |
| `np.linalg.eigh(X)` | Eigenvalues/vectors (symmetric) |
| `np.asmatrix(X)` | View as matrix |

### Indexing & Sorting

| Function | What it does |
|---|---|
| `np.argsort(x)` | Indices that would sort the array |
| `np.unique(x)` | Unique elements |
| `np.where(cond)` | Indices where condition is true |
| `np.isclose(a, b)` | Element-wise approximate equality |
| `np.isin(a, values)` | Element-wise membership test |

### Random

| Function | What it does |
|---|---|
| `np.random.seed(s)` | Set seed for reproducibility |
| `np.random.rand(shape)` | Uniform [0, 1) |
| `np.random.randn(shape)` | Standard normal |
| `np.random.normal(mu, sigma, n)` | Normal distribution |
| `np.random.uniform(lo, hi, n)` | Uniform distribution |
| `np.random.binomial(n, p, size)` | Binomial distribution |
| `np.random.multivariate_normal(mu, cov, n)` | Multivariate normal |

---

## Pandas

### Loading Data

| Function | What it does |
|---|---|
| `pd.read_csv("file.csv")` | Load CSV |
| `pd.read_excel("file.xlsx")` | Load Excel |
| `pd.DataFrame(data)` | Create DataFrame |
| `pd.Categorical(labels)` | Categorical labels |
| `pd.cut(x, bins)` | Bin continuous values |

### DataFrame Operations

| Method | What it does |
|---|---|
| `.head(n)` | First `n` rows |
| `.drop(cols, axis=1)` | Remove columns |
| `.groupby(col)` | Split by category |
| `.query("col > 5")` | Filter rows |
| `.replace(old, new)` | Replace values |
| `.astype(dtype)` | Cast types |
| `.values` | Underlying NumPy array |

### Missing Data

| Method | What it does |
|---|---|
| `.isna()` | Boolean mask of NaNs |
| `.dropna()` | Remove rows with NaNs |
| `.fillna(value)` | Fill NaNs |

### Quick Stats & Plotting

| Method | What it does |
|---|---|
| `.mean()` | Column means |
| `.std()` | Column std devs |
| `.plot()` | Quick plot |

---

## Scikit-learn

### Classification

```python
from sklearn.neighbors import KNeighborsClassifier

knn = KNeighborsClassifier(n_neighbors=k)
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)
```

```python
from sklearn.naive_bayes import MultinomialNB, BernoulliNB

clf = MultinomialNB()
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
```

### Preprocessing

```python
from sklearn.preprocessing import OneHotEncoder

enc = OneHotEncoder()
X_encoded = enc.fit_transform(X)
```

### Evaluation

| Function | What it does |
|---|---|
| `confusion_matrix(y_true, y_pred)` | Confusion matrix |
| `jaccard_score(y_true, y_pred)` | Jaccard similarity |
| `cosine_similarity(X)` | Cosine similarity (from `sklearn.metrics.pairwise`) |

### Train/Test Split

```python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
```

---

## SciPy

| Function | What it does |
|---|---|
| `scipy.io.loadmat("file.mat")` | Load MATLAB `.mat` file |
| `scipy.stats.pearsonr(x, y)` | Pearson correlation + p-value |
| `scipy.stats.norm.pdf(x, mu, sigma)` | Normal PDF |
| `scipy.spatial.distance.pdist(X)` | Pairwise distances (condensed) |
| `scipy.spatial.distance.squareform(D)` | Condensed → square distance matrix |
| `scipy.special.logsumexp(x)` | Log-sum-exp (numerically stable) |

---

## Matplotlib

### Basics

```python
fig, ax = plt.subplots(1, 2, figsize=(10, 4))
plt.show()
```

### Common Plots

| Function | What it does |
|---|---|
| `plt.scatter(x, y)` | Scatter plot |
| `plt.hist(x, bins=n)` | Histogram |
| `plt.boxplot(data)` | Box plot |
| `plt.imshow(matrix)` | Display matrix as image |

### 3D Subplot

```python
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
```

### Formatting

| Function | What it does |
|---|---|
| `plt.xticks(vals, labels)` | Set x-axis ticks |
| `plt.yticks(vals, labels)` | Set y-axis ticks |

---

## Seaborn

```python
sns.set_style("whitegrid")
sns.set_theme()
```

---

## Common Recipes

### Subplots in a Loop

```python
# One row, one plot per class/feature
fig, axes = plt.subplots(1, 3, figsize=(15, 4))

for i, ax in enumerate(axes):
    ax.hist(X[:, i], bins=20)
    ax.set_title(f"Feature {i}")
    ax.set_xlabel("Value")
    ax.set_ylabel("Count")

plt.tight_layout()
plt.show()
```

```python
# Grid of subplots (e.g. 2x3)
nrows, ncols = 2, 3
fig, axes = plt.subplots(nrows, ncols, figsize=(15, 8))

for idx in range(nrows * ncols):
    ax = axes[idx // ncols, idx % ncols]   # index into 2D array
    ax.plot(data[idx])
    ax.set_title(f"Plot {idx}")

plt.tight_layout()
plt.show()
```

### Plotting Lines

```python
# Simple line
x = np.linspace(-5, 5, 100)
y = 2 * x + 1
plt.plot(x, y, label="y = 2x + 1")

# Multiple lines
plt.plot(x, np.sin(x), label="sin", linestyle="--")
plt.plot(x, np.cos(x), label="cos", linestyle="-.")

plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.title("Lines")
plt.show()
```

### Regression Line Over Scatter

```python
plt.scatter(X, y, alpha=0.5, label="Data")
plt.plot(X_sorted, y_pred_sorted, color="red", linewidth=2, label="Fit")
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.show()
```

### Decision Boundary (2D)

```python
# Create a grid over feature space
x1 = np.linspace(X[:, 0].min() - 1, X[:, 0].max() + 1, 200)
x2 = np.linspace(X[:, 1].min() - 1, X[:, 1].max() + 1, 200)
XX1, XX2 = np.meshgrid(x1, x2)
grid = np.c_[XX1.ravel(), XX2.ravel()]

# Predict on every grid point
Z = clf.predict(grid).reshape(XX1.shape)

plt.contourf(XX1, XX2, Z, alpha=0.3, cmap="coolwarm")
plt.scatter(X[:, 0], X[:, 1], c=y, cmap="coolwarm", edgecolors="k", s=30)
plt.xlabel("Feature 1")
plt.ylabel("Feature 2")
plt.title("Decision Boundary")
plt.show()
```

---

## Gaussian / Normal Data

### Generate Samples

```python
# 1D
mu, sigma = 5.0, 2.0
samples = np.random.normal(mu, sigma, size=500)

# 2D multivariate
mu = np.array([1, 3])
cov = np.array([[2, 0.8],
                [0.8, 1]])
samples_2d = np.random.multivariate_normal(mu, cov, size=300)
```

### Plot a Gaussian PDF

```python
from scipy.stats import norm

x = np.linspace(mu - 4*sigma, mu + 4*sigma, 200)

plt.hist(samples, bins=30, density=True, alpha=0.5, label="Samples")
plt.plot(x, norm.pdf(x, mu, sigma), "r-", linewidth=2, label="PDF")
plt.xlabel("x")
plt.ylabel("Density")
plt.legend()
plt.title("Gaussian Distribution")
plt.show()
```

### Scatter + Covariance Ellipse (2D)

```python
from matplotlib.patches import Ellipse

def cov_ellipse(ax, mu, cov, n_std=2, **kwargs):
    """Draw an n_std covariance ellipse."""
    vals, vecs = np.linalg.eigh(cov)
    angle = np.degrees(np.arctan2(vecs[1, 0], vecs[0, 0]))
    w, h = 2 * n_std * np.sqrt(vals)
    ell = Ellipse(xy=mu, width=w, height=h, angle=angle, **kwargs)
    ax.add_patch(ell)

fig, ax = plt.subplots(figsize=(6, 6))
ax.scatter(samples_2d[:, 0], samples_2d[:, 1], alpha=0.4, s=10)
cov_ellipse(ax, mu, cov, n_std=2, edgecolor="red", facecolor="none", linewidth=2)
ax.set_xlabel("x1")
ax.set_ylabel("x2")
ax.set_aspect("equal")
ax.set_title("2D Gaussian + Covariance Ellipse")
plt.show()
```

---

## Quick Data Exploration Workflow

```python
# 1. Load
df = pd.read_csv("data.csv")
X = df.drop("target", axis=1).values
y = df["target"].values

# 2. Overview
print(df.head())
print(df.describe())          # mean, std, min, max, quartiles
print(df.isna().sum())        # missing values per column

# 3. Histograms per feature
fig, axes = plt.subplots(1, X.shape[1], figsize=(4 * X.shape[1], 4))
for i, ax in enumerate(axes):
    ax.hist(X[:, i], bins=25)
    ax.set_title(df.columns[i])
plt.tight_layout()
plt.show()

# 4. Correlation heatmap
corr = np.corrcoef(X, rowvar=False)
plt.imshow(corr, cmap="RdBu_r", vmin=-1, vmax=1)
plt.colorbar(label="Pearson r")
plt.xticks(range(X.shape[1]), df.columns[:-1], rotation=45)
plt.yticks(range(X.shape[1]), df.columns[:-1])
plt.title("Correlation Matrix")
plt.show()

# 5. Scatter matrix (class-colored)
class_names = np.unique(y)
colors = ["tab:blue", "tab:orange", "tab:green"]
for i in range(X.shape[1]):
    for j in range(X.shape[1]):
        if i != j:
            for k, c in enumerate(class_names):
                mask = y == c
                plt.scatter(X[mask, j], X[mask, i], c=colors[k],
                            alpha=0.4, s=10, label=c if i == 1 and j == 0 else "")
plt.legend()
plt.show()

# 6. Boxplots by class
fig, axes = plt.subplots(1, X.shape[1], figsize=(4 * X.shape[1], 4))
for i, ax in enumerate(axes):
    groups = [X[y == c, i] for c in class_names]
    ax.boxplot(groups, labels=class_names)
    ax.set_title(df.columns[i])
plt.tight_layout()
plt.show()
```

### Standardize Data

```python
mu = X.mean(axis=0)
sigma = X.std(axis=0, ddof=1)
X_std = (X - mu) / sigma
```

### PCA (manual with SVD)

```python
X_centered = X - X.mean(axis=0)
U, S, Vt = np.linalg.svd(X_centered, full_matrices=False)
Z = X_centered @ Vt[:k].T          # project onto first k components
explained = S**2 / np.sum(S**2)     # variance explained per component
```
