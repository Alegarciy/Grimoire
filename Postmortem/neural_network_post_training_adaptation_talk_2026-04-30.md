# Postmortem: Talk on Post-Training Adaptation of Neural Networks

## Context
This note captures the main intellectual thread from a talk centered on changing or tuning neural-network behavior **after training**, or at least without full retraining.

The talk seems to sit at the intersection of three nearby but distinct ideas:

1. **Inference-time optimization** of already trained models
2. **Knowledge editing / model editing** of pretrained networks
3. **Parameter or controller tuning** around neural-network-based systems without retraining the core model

That distinction matters, because these are related ideas, but they are not the same problem.

---

## Core insight
The strongest conceptual takeaway is:

> There is a meaningful research space between "train a new model from scratch" and "freeze the model forever."

That middle space includes methods for:
- changing where and how inference runs
- adjusting runtime behavior dynamically
- editing localized knowledge in a pretrained model
- tuning neural-network-based controllers through external or adaptive parameters

So the big theme is not simply "better neural nets," but:

> **How much useful adaptation can be done after the main model has already been trained?**

---

## The three key references

### 1. DynO: Dynamic Onloading of Deep Neural Networks from Cloud to Device
Link: https://arxiv.org/abs/2104.09949

Why it matters:
- focuses on **deployment/runtime optimization** rather than retraining
- changes execution strategy for CNN inference
- relevant dimensions include partition point, precision, and cloud/device allocation

Interpretation:
This is best understood as a **systems and inference optimization** paper, not a model-editing paper in the strict sense.

Main lesson:
- a trained model can become more useful through smarter execution choices
- adaptation is sometimes about the deployment stack, not the weights themselves

---

### 2. A Survey on Knowledge Editing of Neural Networks
Link: https://arxiv.org/abs/2310.19704

Why it matters:
- gives the cleanest umbrella framing for **editing a trained model after the fact**
- formalizes the goal of making targeted changes while preserving unrelated behavior
- likely the best source for terminology and landscape mapping

Interpretation:
This seems like the most important reference if the talk was really about **post hoc modification of learned knowledge**.

Main lesson:
- the desired edit is local, efficient, and minimally destructive
- the challenge is not only changing the answer, but preserving everything else

Useful framing terms:
- locality
- reliability
- specificity
- generalization of the edit
- preservation of non-target behavior

---

### 3. Parameter-Adaptive Approximate MPC: Tuning Neural-Network Controllers without Retraining
Link: https://arxiv.org/abs/2404.05835

Why it matters:
- directly matches the phrase **tuning neural-network controllers without retraining**
- bridges learned models and control-theoretic adaptation
- useful if the talk had a systems, robotics, or control flavor

Interpretation:
This is not general-purpose knowledge editing. It is closer to **adapting a learned controller through tunable parameters or surrounding structure**.

Main lesson:
- a neural network may stay fixed while the broader control policy remains adjustable
- adaptation can happen at the level of controller parameters, constraints, or system context

---

## Important distinction between the three papers
These papers support the same broad intuition, but they belong to different subproblems.

| Source | Main object being changed | Type of adaptation |
|---|---|---|
| DynO | execution strategy | runtime/deployment optimization |
| Knowledge Editing survey | model knowledge/behavior | post-training model editing |
| Parameter-Adaptive MPC | controller tuning around/with NN | adaptive control without retraining |

So if I want to explain the talk clearly, I should avoid collapsing them into one claim.

A better synthesis is:

> The talk concerns methods for improving or modifying the behavior of neural-network-based systems without full retraining, and these methods appear across systems optimization, knowledge editing, and adaptive control.

---

## What I currently think the talk was really about
Most likely thesis:

> Once a neural network has been trained, there are still multiple ways to adapt its practical behavior without redoing the entire learning process.

Possible interpretations of that thesis:
- **systems view:** change execution placement, latency/energy tradeoffs, precision, and partitioning
- **model view:** edit specific stored knowledge while keeping the rest intact
- **control view:** tune behavior of a learned controller through adaptive parameters

This means the talk may have been less about classical training and more about **post-training flexibility**.

---

## Recommended learning path
A useful study order for understanding this space:

1. **Mathematics for Machine Learning** — https://mml-book.com/
2. **Deep Learning** — https://www.deeplearningbook.org/
3. **DynO paper**
4. **Knowledge Editing survey**
5. **Parameter-Adaptive Approximate MPC paper**
6. **Understanding Machine Learning** — https://www.cs.huji.ac.il/~shais/UnderstandingMachineLearning/understanding-machine-learning-theory-algorithms.pdf

Why this order works:
- first build mathematical and deep-learning vocabulary
- then read the systems paper
- then read the editing survey for the conceptual umbrella
- then read the controller-tuning paper as a specialized application
- finally reinforce theory and generalization concepts

---

## Search phrases worth keeping
- model editing
- knowledge editing neural networks
- post-training adaptation
- parameter-efficient tuning
- neural network controller tuning without retraining
- dynamic inference optimization

Additional phrases that may help:
- test-time adaptation
- runtime adaptation of neural networks
- parameter-efficient fine-tuning
- localized model updates
- continual adaptation without full retraining

---

## Open questions for follow-up
1. What exactly counts as **editing the model** versus **editing the system around the model**?
2. How much of post-training adaptation can be done without harming calibration or generalization?
3. When is a lightweight adaptation method better than just fine-tuning?
4. Are knowledge-editing methods robust enough for real deployment, or mostly research-stage?
5. How much of this literature overlaps with PEFT, LoRA, adapters, and test-time adaptation?
6. In control settings, what guarantees can be preserved when tuning around a fixed neural network?

---

## Practical summary
If I had to summarize the talk in one paragraph:

The talk pointed toward a broad and useful idea: trained neural networks are not the end of the story. Their behavior can often be modified, tuned, or operationally improved after training, either by changing runtime execution decisions, editing specific learned knowledge, or adapting controller parameters around the model. The three best starting references for this theme are DynO for deployment/runtime optimization, the knowledge-editing survey for post hoc model modification, and the parameter-adaptive MPC paper for controller tuning without retraining.

---

## One-line takeaway
**The interesting question is not only how to train neural networks, but how to adapt them intelligently after training without paying the full cost of retraining.**
