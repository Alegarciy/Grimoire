# PySpark — Applying Functions (Pandas UDFs & mapInPandas)

## Source
PySpark DataFrame Quick Start — "Applying a Function" section

---

## The Core Problem

PySpark distributes data across **multiple machines (nodes)** in a cluster. The data lives in the JVM (Java Virtual Machine), not in Python memory. When you want to run Python logic on that data, there's a **translation cost** — Spark has to serialize data, send it to Python, run it, and send results back.

Historically, doing this with plain Python UDFs was **very slow** because it moved data **row by row**.

---

## What Pandas UDFs Solve

### `pandas_udf` — Vectorized Operations

```python
import pandas as pd
from pyspark.sql.functions import pandas_udf

@pandas_udf('long')
def pandas_plus_one(series: pd.Series) -> pd.Series:
    # Simply plus one by using pandas Series.
    return series + 1

df.select(pandas_plus_one(df.a)).show()
```

Instead of processing **one row at a time**, Spark sends an entire **batch/chunk** of data as a Pandas Series to your function. This means:

- ✅ You get the **full power of Pandas** (vectorized math, string ops, etc.)
- ✅ It uses **Apache Arrow** under the hood for fast serialization (columnar format, very efficient)
- ✅ Dramatically **faster than a regular Python UDF**
- ✅ The function signature tells Spark exactly the **input/output types** so it can optimize

> Think of it like the difference between handing a cashier items one at a time vs. handing them the whole basket at once.

---

## What `mapInPandas` Solves

```python
def pandas_filter_func(iterator):
    for pandas_df in iterator:
        yield pandas_df[pandas_df.a == 1]

df.mapInPandas(pandas_filter_func, schema=df.schema).show()
```

This goes a step further — instead of a single column (Series), you get the **entire partition as a full Pandas DataFrame**.

| Feature | `pandas_udf` | `mapInPandas` |
|---|---|---|
| Input | A column (Series) | Full DataFrame |
| Output length | Must match input | **Can be different** (filter, explode, etc.) |
| Use case | Column transforms | Complex row-level logic |

The `yield` keyword means it works as a **generator**, processing one partition/batch at a time without loading everything into memory at once.

---

## Why You Rarely See This in Companies

1. **Most companies use SQL or built-in Spark functions** — if Spark already has a built-in function (`pyspark.sql.functions`), you should always prefer it. UDFs are a **last resort**
2. **Complexity** — debugging distributed Python functions is painful
3. **Data Engineers often aren't Pandas experts** — they think in SQL
4. **Overhead still exists** — even with Arrow, crossing the JVM-Python boundary has a cost
5. **Small data companies** — if your data fits in memory, you might not even need Spark at all

---

## When You WOULD Use This

- Custom **ML model inference** on each row (e.g., run a scikit-learn model on every record)
- Complex **string parsing** logic that has no Spark equivalent
- **Domain-specific calculations** (finance, science) already written in Python/Pandas
- Need to **filter or reshape** data in ways that change the row count mid-pipeline (`mapInPandas`)

---

## Key Takeaway

This feature bridges the gap between Spark's distributed power and Python's rich ecosystem, solving the row-by-row UDF slowness problem that existed in earlier Spark versions. It matters most at **large scale** with **custom logic** that can't be expressed in native Spark SQL functions.
