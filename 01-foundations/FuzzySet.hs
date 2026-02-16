module FuzzySet where

newtype FuzzySet a = FuzzySet
  { membership :: a -> Double
  }

-- Smart constructor: เพื่อกันไม่ให้ค่าทะลุ 0 หรือ 1
mkFuzzySet :: (a -> Double) -> FuzzySet a
mkFuzzySet f = FuzzySet (clamp f)
  where
    clamp g x = max 0.0 (min 1.0 (g x))

-- Operations: ใช้หลักการของ Zadeh
-- Union = Max  (ผ่าน mkFuzzySet เพื่อ guarantee ว่าผล ∈ [0,1] เสมอ)
fuzzyUnion :: FuzzySet a -> FuzzySet a -> FuzzySet a
fuzzyUnion (FuzzySet a) (FuzzySet b) = mkFuzzySet $ \x -> max (a x) (b x)

-- Intersection = Min
fuzzyIntersection :: FuzzySet a -> FuzzySet a -> FuzzySet a
fuzzyIntersection (FuzzySet a) (FuzzySet b) = mkFuzzySet $ \x -> min (a x) (b x)

-- Complement = 1 - μ(x)  (ทฤษฎี Zadeh: μ_{A^c}(x) = 1 - μ_A(x))
fuzzyComplement :: FuzzySet a -> FuzzySet a
fuzzyComplement (FuzzySet a) = mkFuzzySet $ \x -> 1.0 - a x
