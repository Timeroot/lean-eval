import Mathlib
import EvalTools.Markers

namespace LeanEval
namespace Dynamics

/-!
# Poincaré–Bendixson theorem (Poincaré 1881–1886; Bendixson 1901)

§63 of Knill's *Some Fundamental Theorems in Mathematics*. For a `C¹`
autonomous vector field `F : ℝ² → ℝ²` and a forward integral curve `γ`
on `[0, ∞)`, one of three alternatives holds for `γ '' [0, ∞)`: it is
unbounded; its ω-limit set `⋂ s, closure (γ '' [s, ∞))` contains an
equilibrium of `F`; or its ω-limit set equals the range of a
non-constant periodic integral curve of `F`.

Case 2 is the rigorous form "ω-limit contains an equilibrium" rather
than "γ converges to an equilibrium"; this is the standard
formulation of the bounded branch, since planar orbits in a bounded
forward-invariant region may accumulate on continua of equilibria or
polycycles without converging to any single point. Case 3 requires
`F (β 0) ≠ 0` to exclude a constant equilibrium curve vacuously
satisfying the periodic branch.

Mathlib has `IsIntegralCurveOn` and `IsIntegralCurve`, the `omegaLimit`
API on `Dynamics/`, and Picard–Lindelöf local existence. It does not
have the Poincaré–Bendixson theorem, the Jordan curve theorem in `ℝ²`
(used in the classical proof; the same gap is the subject of §48), the
transverse-arc / first-return-map machinery, or global continuation of
`C¹` ODE flows. The Isabelle/HOL/AFP entry by Immler and Tan uses
Harrison's Jordan curve theorem; I did not find a corresponding Lean
formalisation.
-/

open Filter Topology Set

/-- Ambient space: `ℝ²`. -/
abbrev Plane := EuclideanSpace ℝ (Fin 2)

/-- **Poincaré–Bendixson theorem** (planar trichotomy). For a `C¹`
autonomous vector field `F : ℝ² → ℝ²` and a forward integral curve `γ`
defined on `[0, ∞)`, the forward orbit `γ '' [0, ∞)` is either unbounded;
or its ω-limit set contains an equilibrium of `F`; or its ω-limit set
equals the range of a non-constant periodic integral curve of `F`.

The third alternative is a periodic-orbit conclusion; "limit cycle" in
the strict dynamical-systems sense (isolated periodic orbit attracting
nearby trajectories) is not asserted. -/
@[eval_problem]
theorem poincare_bendixson
    (F : Plane → Plane) (_hF : ContDiff ℝ 1 F)
    (γ : ℝ → Plane)
    (_hγ : IsIntegralCurveOn γ (fun _ x => F x) (Set.Ici 0)) :
    ¬ Bornology.IsBounded (γ '' Set.Ici 0)
    ∨ (∃ x₀, F x₀ = 0 ∧ x₀ ∈ ⋂ s : ℝ, closure (γ '' Set.Ici s))
    ∨ (∃ T : ℝ, 0 < T ∧ ∃ β : ℝ → Plane,
        IsIntegralCurve β (fun _ x => F x) ∧
        (∀ t, β (t + T) = β t) ∧
        F (β 0) ≠ 0 ∧
        (⋂ s : ℝ, closure (γ '' Set.Ici s)) = Set.range β) := by
  sorry

end Dynamics
end LeanEval
