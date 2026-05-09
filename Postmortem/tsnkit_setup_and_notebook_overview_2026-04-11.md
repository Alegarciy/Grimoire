# TSNKit setup and onboarding notebook overview

Date: 2026-04-11
Project: `/home/gandalf/Documents/Storm/Vox_Populi/tsnkit`

## What was done

### 1. Created a uv virtual environment
Created:
- `/home/gandalf/Documents/Storm/Vox_Populi/tsnkit/.venv`

Installed core dependencies needed for local use:
- `cython`
- `z3-solver`
- `docplex`
- `networkx`
- `numpy`
- `pandas`
- `psutil`
- `tqdm`
- local editable package: `tsnkit`

Skipped for now:
- `gurobipy`

Reason:
- Gurobi may require licensing / academic access
- not all algorithms in TSNKit need Gurobi

Verified:
- imports succeeded in the environment

Activation command:
```bash
source /home/gandalf/Documents/Storm/Vox_Populi/tsnkit/.venv/bin/activate
```

---

### 2. Checked whether the RTSS'25 notebook uses Gurobi-dependent algorithms
Inspected notebooks related to RTSS'25.

Found:
- `doc/rtss25.ipynb` exists, but local content is only a Git LFS pointer, so it was not inspectable directly
- `notebooks/rtss25_wip.ipynb` was inspectable

Algorithms referenced in `notebooks/rtss25_wip.ipynb`:
- `tsnkit.algorithms.ls`
- `tsnkit.algorithms.smt_wa`
- `tsnkit.algorithms.ls_tb`
- `tsnkit.algorithms.jrs_wa`

Important result:
- `jrs_wa` is one of the algorithms that requires Gurobi
- therefore the RTSS'25 WIP notebook does include a Gurobi-dependent algorithm

User noted that not all algorithms require Gurobi and planned to document that.

---

### 3. Created a much simpler onboarding notebook
Created:
- `/home/gandalf/Documents/Storm/Vox_Populi/tsnkit/notebooks/tsn_onboarding_simple.ipynb`

Purpose:
- provide a dead-simple, beginner-friendly introduction to TSNKit and TSN concepts
- feel like onboarding / invitation to exploration
- use only one algorithm

Design choices:
- uses a tiny generated dataset
- uses only `ls`
- avoids Gurobi
- walks through:
  1. generating a tiny TSN instance
  2. reading the task and topology CSVs
  3. drawing a simple topology diagram
  4. running `tsnkit.algorithms.ls`
  5. inspecting route / offset / queue / GCL / delay outputs
  6. validating with `tsnkit.simulation.tas`

Also created helper script used to generate the notebook:
- `/home/gandalf/Documents/Storm/Vox_Populi/tsnkit/scripts/create_simple_tsn_notebook.py`

---

### 4. Added notebook / plotting dependencies
Installed into `.venv`:
- `matplotlib`
- `seaborn`
- `ipykernel`
- `notebook`

Reason:
- simulation drawing required plotting packages
- notebook execution required Jupyter packages

---

### 5. Validated the simple notebook end-to-end
Executed successfully with nbconvert.

Validation included:
- tiny dataset generation
- schedule computation with `ls`
- simulation run
- no reported potential errors in the validated run

Generated working files under:
- `/home/gandalf/Documents/Storm/Vox_Populi/tsnkit/notebooks/_generated/simple_intro/`

---

## Key practical outcomes

### Environment ready
The project now has a usable local Python environment without Gurobi.

### Notebook ready
There is now a simple runnable notebook for learning TSNKit:
- `notebooks/tsn_onboarding_simple.ipynb`

### Important note on Gurobi
Algorithms requiring Gurobi, as discussed:
- `i_ilp`
- `jrs_mc`
- `jrs_nw`
- `jrs_wa`
- `smt_nw`

The simplified onboarding notebook does **not** depend on those.

---

## Suggested next steps

Possible follow-ups mentioned:
1. make an even more visual version of the simple notebook
2. create a second notebook comparing `ls` with another non-Gurobi algorithm
3. document clearly which algorithms require Gurobi and which do not

---

## Quick commands
Run the notebook:
```bash
cd /home/gandalf/Documents/Storm/Vox_Populi/tsnkit
source .venv/bin/activate
jupyter notebook
```

Open:
- `notebooks/tsn_onboarding_simple.ipynb`
