import Mathlib
import EvalTools.Markers

open scoped Manifold ENNReal ContDiff

namespace LeanEval
namespace Geometry

/-!
# Hopf–Rinow theorem (Hopf–Rinow, 1931)

§93 of Knill's *Some Fundamental Theorems in Mathematics*. For a
connected, locally compact Riemannian manifold `M`, metric
completeness and geodesic completeness are equivalent.

Mathlib (v4.30) has `IsRiemannianManifold` and `riemannianEDist` /
`pathELength` (Sébastien Gouëzel 2025, `Geometry/Manifold/Riemannian/`),
but no `Geodesic` / `expMap` / `IsGeodesicallyComplete`, no
Levi-Civita connection (in-flight via the placeholder PR #36036,
WIP), and no `Hopf–Rinow` theorem (`grep -ri hopf.*rinow` returns no
hits).

The problem ships two helper definitions: `IsGeodesic` (a path with
locally linear `edist` — the constant-speed characterisation,
equivalent to `∇γ̇γ̇ = 0` on a Riemannian manifold but expressible
without the Levi-Civita connection) and `IsGeodesicallyComplete`
(every geodesic on a bounded open interval extends to all of `ℝ`,
Knill's "the exponential map extends to the whole tangent bundle"
re-cast metrically).

Local compactness is essential: Hopf–Rinow fails for infinite-
dimensional Riemannian Hilbert manifolds (Atkin 1975).
-/

/-- A path `γ : ℝ → M` is a **(constant-speed) geodesic** if there is
some speed `c : ℝ≥0` such that at every parameter `t₀ : ℝ`, the
Riemannian distance is locally linear in the parameter. -/
def IsGeodesic {M : Type*} [EMetricSpace M] (γ : ℝ → M) : Prop :=
  ∃ c : NNReal, ∀ t₀ : ℝ, ∃ δ > (0 : ℝ),
    ∀ s t : ℝ, |s - t₀| < δ → |t - t₀| < δ →
      edist (γ s) (γ t) = (c : ℝ≥0∞) * ENNReal.ofReal |t - s|

/-- The Riemannian manifold `M` is **geodesically complete** if every
geodesic defined on a bounded open interval `(a, b) ⊂ ℝ` extends to a
geodesic defined on all of `ℝ`. -/
def IsGeodesicallyComplete (M : Type*) [EMetricSpace M] : Prop :=
  ∀ (a b : ℝ) (γ : ℝ → M), a < b →
    (∃ c : NNReal, ∀ t₀ ∈ Set.Ioo a b, ∃ δ > (0 : ℝ),
      ∀ s t : ℝ,
        s ∈ Set.Ioo (max a (t₀ - δ)) (min b (t₀ + δ)) →
        t ∈ Set.Ioo (max a (t₀ - δ)) (min b (t₀ + δ)) →
        edist (γ s) (γ t) = (c : ℝ≥0∞) * ENNReal.ofReal |t - s|) →
    ∃ γext : ℝ → M, IsGeodesic γext ∧ ∀ t ∈ Set.Ioo a b, γext t = γ t

/-- **Hopf–Rinow theorem.** For a connected, locally compact Riemannian
manifold `M`, metric completeness and geodesic completeness are
equivalent. -/
@[eval_problem]
theorem hopf_rinow
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    {H : Type*} [TopologicalSpace H] (I : ModelWithCorners ℝ E H)
    (M : Type*) [EMetricSpace M] [ChartedSpace H M] [IsManifold I ∞ M]
    [Bundle.RiemannianBundle (fun x : M => TangentSpace I x)]
    [IsRiemannianManifold I M]
    [LocallyCompactSpace M] [ConnectedSpace M] :
    IsGeodesicallyComplete M ↔ CompleteSpace M := by
  sorry

end Geometry
end LeanEval
