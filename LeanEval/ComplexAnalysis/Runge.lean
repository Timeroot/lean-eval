import Mathlib
import EvalTools.Markers

namespace LeanEval
namespace ComplexAnalysis

/-!
# Runge's theorem (Carl Runge, 1885)

§64 (additional statement 3) of Knill's *Some Fundamental Theorems in
Mathematics*. For a compact set `K ⊆ ℂ` and a function `f` holomorphic
on an open neighbourhood `U ⊇ K`, `f` is the uniform limit on `K` of
rational functions whose poles avoid `K`.

The submitted statement is the basic Runge form (rational
approximations with poles in `ℂ \ K`); the sharper pole-control
version (one pole per connected component of `ℂ \ K`) is the standard
strengthening but is harder to phrase without further setup.

Mathlib has Weierstrass / Stone–Weierstrass and the Bernstein
approximation for `C([a, b], ℝ)`, but nothing for compact-set rational
approximation in `ℂ`. `grep -rn 'runge\|Runge'` in mathlib returns no
hits. Aristotle closed the single-ball case `runge_of_subset_ball`
sorry-free; the general "patch ball-by-ball into one rational
function" step needs Cauchy integral over a general cycle or
Hahn–Banach + Riesz, neither in mathlib.
-/

open scoped Polynomial

/-- **Runge's theorem.** For a compact `K ⊆ ℂ` and `f` analytic on an
open neighbourhood `U` of `K`, every `ε > 0` admits a rational function
`p/q` with `q` non-vanishing on `K` and `‖f z − p(z)/q(z)‖ < ε` on `K`. -/
@[eval_problem]
theorem runge (K : Set ℂ) (_hK : IsCompact K) (U : Set ℂ) (_hU : IsOpen U)
    (_hKU : K ⊆ U) (f : ℂ → ℂ) (_hf : AnalyticOnNhd ℂ f U)
    (ε : ℝ) (_hε : 0 < ε) :
    ∃ p q : ℂ[X], (∀ z ∈ K, q.eval z ≠ 0) ∧
      (∀ z ∈ K, ‖f z - p.eval z / q.eval z‖ < ε) := by
  sorry

end ComplexAnalysis
end LeanEval
