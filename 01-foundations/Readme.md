# Introduction to Fuzzy Sets

In daily life, we constantly classify, evaluate, and judge situations in ways that can be modeled mathematically through set-theoretic thinking. Many ordinary activities — determining whether something is “hot,” “tall,” or “expensive” — implicitly involve membership in conceptual sets.

## Example

Consider the following everyday classifications:

* **Height**: When we say “John is tall,” we implicitly reference a set of *tall people*. Yet there is no universally sharp boundary at which a person suddenly becomes tall. Is 179 cm not tall while 180 cm is tall? The distinction is gradual rather than absolute.

* **Price**: When we describe a product as “expensive,” we compare it against an implicit set of *expensive items*. The threshold varies by context, income level, and social norms.

* **Weather**: When we claim “Today is hot,” we implicitly refer to the set of *hot days*. However, temperature perception changes continuously rather than discretely.

In each case, we are performing a classification task. Classical set theory requires a precise boundary separating members from non-members. Human reasoning, however, typically operates with gradual transitions rather than strict cutoffs.

This motivates a framework capable of modeling **degrees of membership** rather than binary inclusion — leading naturally to fuzzy set theory.

---

In high school mathematics and later in discrete mathematics courses, set theory is introduced under **classical (crisp) logic**. Formally, modern set theory is grounded in **Zermelo–Fraenkel set theory with the Axiom of Choice (ZFC)**. Within this framework, sets are sharply defined collections and membership is strictly binary.

Before introducing fuzzy sets, we briefly recap classical set theory.

---

## Transition Question

In classical set theory, a set $A \subseteq X$ is defined by its characteristic function:

$$
\chi_A : X \to \\{0,1\\}
$$

What happens if we relax the codomain?

$$
\mu_A : X \to [0,1]
$$

If membership is no longer restricted to two values, what algebraic structure replaces Boolean algebra?

---

## Example: "Is it Hot?"

Imagine defining the set of “Hot Weather” in Bangkok.

### Crisp (Classical) Definition

Suppose we define:

> "30°C and above is hot."

Then:

* 29.9°C → $0$ (Not Hot)
* 30.0°C → $1$ (Hot)

Does a $0.1^\circ$C difference truly change the qualitative experience from “not hot” to “hot”? In most practical contexts, it does not.

### Fuzzy Perspective

Instead of imposing a sharp threshold, we allow gradual membership:

* 25°C → low membership
* 30°C → moderate membership
* 35°C → high membership
* 40°C → full membership

Here, “hot” becomes a matter of degree rather than a binary classification.

---

# Classical Set Theory

## 1. Crisp Membership

Let $X$ be a universe of discourse. A classical set $A \subseteq X$ is defined by its characteristic function:

$$
\chi_A : X \to \\{0,1\\}
$$

with

$$
\chi_A(x) =
\begin{cases}
1 & \text{if } x \in A \
0 & \text{if } x \notin A
\end{cases}
$$

An element either belongs to a set or it does not. There is no intermediate value.

This binary membership is fundamentally tied to classical two-valued logic.

---

## 2. Logical Foundation

Classical set theory relies on:

* **Law of Excluded Middle**: $P \lor \neg P$
* **Law of Non-Contradiction**: $\neg (P \land \neg P)$

Thus, membership is **bivalent**.

---

## 3. Set Operations (Crisp Algebra)

Given $A, B \subseteq X$:

**Union**

$$
\chi_{A \cup B}(x) = \max(\chi_A(x), \chi_B(x))
$$

**Intersection**

$$
\chi_{A \cap B}(x) = \min(\chi_A(x), \chi_B(x))
$$

**Complement**

$$
\chi_{A^c}(x) = 1 - \chi_A(x)
$$

Although expressed using $\min$, $\max$, and subtraction, these reduce to Boolean operations because values are restricted to ${0,1}$.

This observation is crucial: classical set operations already suggest a structure that can be generalized beyond binary values.

---

## 4. Algebraic Structure

The set of truth values in classical logic is

$$
\mathbf{2} = {0,1}
$$

with operations:

* $\land$ (AND)
* $\lor$ (OR)
* $\neg$ (NOT)

This structure forms a **Boolean algebra**.

Thus, classical set theory can be viewed as membership represented by a Boolean-valued function:

$$
\chi_A : X \to \mathbf{2}
$$

---

## 5. Implementation View (Haskell Perspective)

In functional programming, a classical set can be represented as a predicate:

```haskell
newtype Set a = Set
  { characteristic :: a -> Bool
  }
```

This reveals an important conceptual insight:

> A set is a predicate.

This representation generalizes naturally when membership values are no longer restricted to `Bool`.

---

# Limitation of Classical Sets

Consider the statement:

> "The temperature is hot."

In classical logic:

* Either it is hot ($1$),
* Or it is not hot ($0$).

However:

* 29°C may be “somewhat hot,”
* 35°C may be “very hot,”
* 22°C may be “not hot.”

Classical sets assume sharp boundaries. Many real-world concepts do not.

---

# Entering the World of Fuzzy Sets

Returning to our earlier question: what happens if we relax the codomain from ${0,1}$ to $[0,1]$?

In fuzzy set theory, we replace the characteristic function $\chi_A$ with a **membership function**:

$$
\mu_A : X \to [0,1]
$$

where:

* $\mu_A(x) = 1$ indicates full membership
* $\mu_A(x) = 0$ indicates non-membership
* $0 < \mu_A(x) < 1$ indicates partial membership

Instead of asking:

> “Is $x \in A$?”

we now ask:

> “To what degree does $x$ belong to $A$?”

This shift replaces binary classification with graded membership while preserving formal mathematical structure.
