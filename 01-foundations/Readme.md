# Introduction to Fuzzy

In high school mathematics and later in discrete mathematics courses, set theory is introduced under classical (crisp) logic. Formally, modern set theory is grounded in the Zermelo–Fraenkel set theory with the Axiom of Choice (Zermelo–Fraenkel set theory), commonly abbreviated as **ZFC**. Before introducing fuzzy sets, we briefly recap classical set theory and its underlying assumptions.

## Classical Set Theory

### 1. Crisp Membership

Let $X$ be a universe of discourse. A classical set $A \subseteq X$ is defined by its **characteristic function**:

$$\chi_A : X \to \{0,1\}$$

where:

$$
\chi_A(x) =
\begin{cases}
1 & \text{if } x \in A \\
0 & \text{if } x \notin A
\end{cases}
$$



In other words:
> An element either belongs to a set or does not belong to it. There is no intermediate value.

This binary membership is fundamentally tied to classical (two-valued) logic.

---

### 2. Logical Foundation

Classical set theory relies on:

* **Law of Excluded Middle**: $P \lor \neg P$
* **Law of Non-Contradiction**: $\neg (P \land \neg P)$

Thus, membership is **bivalent**.

---

### 3. Set Operations (Crisp Algebra)

Given $A, B \subseteq X$:

**Union:**
$$\chi_{A \cup B}(x) = \max(\chi_A(x), \chi_B(x))$$

**Intersection:**
$$\chi_{A \cap B}(x) = \min(\chi_A(x), \chi_B(x))$$

**Complement:**
$$\chi_{A^c}(x) = 1 - \chi_A(x)$$

Notice something important: Even in classical set theory, operations can be written using `min`, `max`, and `1 - x`. But since values are restricted to $\{0,1\}$, these reduce to Boolean logic. This observation will later generalize naturally to fuzzy sets.

---

### 4. Algebraic Structure

The set of truth values in classical logic is $\mathbf{2} = \{0,1\}$ with operations:
* $\land$ (AND)
* $\lor$ (OR)
* $\neg$ (NOT)

This structure forms a **Boolean algebra**. Thus, classical set theory is essentially a set membership represented as a Boolean-valued function:

$$\chi_A : X \to \mathbf{2}$$

---

### 5. Implementation View (Haskell Perspective)

In functional programming terms, a classical set can be represented as a predicate:

```haskell
newtype Set a = Set
  { characteristic :: a -> Bool
  }
```
This makes an important conceptual shift:
> A set is a predicate.
This functional representation will generalize beautifully when we move to fuzzy sets.
## Limitation of Classical Sets
Consider the statement:

> "The temperature is hot."

In classical logic:

* Either it is hot (1)
* Or it is not hot (0)

But in real-world reasoning:

* 29°C may be “somewhat hot”
* 35°C is “very hot”
* 22°C is “not hot”

Classical sets cannot express gradual membership.

They assume sharp boundaries.

Reality often does not.

## Transition Question

If classical sets are:

χ_A : X → {0,1}

What happens if we relax the codomain?

μ_A : X → [0,1]

What algebraic structure replaces Boolean algebra?
