module Main where

import qualified Data.Set as S
import Data.List (intercalate)
import ClassicalSet
import FuzzySet

-- ===== Universe of discourse =====
-- เรากำหนดจักรวาลให้ชัดเจน (สำคัญมากใน set theory)
universe :: S.Set Int
universe = S.fromList [0..10]

-- ===== Helper: pretty print set =====
-- ใช้ ", " คั่นสมาชิก ตาม set-builder notation มาตรฐาน เช่น {0, 1, 2}
showSet :: Show a => S.Set a -> String
showSet s = "{" ++ inner ++ "}"
  where
    inner = intercalate ", " (map show (S.toList s))

-- ===== Classical operations (finite explicit set model) =====
unionSet :: Ord a => S.Set a -> S.Set a -> S.Set a
unionSet = S.union

intersectionSet :: Ord a => S.Set a -> S.Set a -> S.Set a
intersectionSet = S.intersection

-- complement ต้องรับ U มาเป็น argument ตาม definition: A^c = U \ A
-- การ hardcode universe ภายในฟังก์ชันทำให้นำไปใช้กับ universe อื่นไม่ได้
complementSet :: Ord a => S.Set a -> S.Set a -> S.Set a
complementSet u s = u `S.difference` s

-- ===== Main =====
main :: IO ()
main = do

    putStrLn "=== Classical Set Theory (Finite Model) ==="

    let setA = S.singleton 5
    let setB = S.singleton 10

    putStrLn $ "Universe U = " ++ showSet universe
    putStrLn $ "A = " ++ showSet setA
    putStrLn $ "B = " ++ showSet setB

    -- Union
    let unionAB = unionSet setA setB
    putStrLn $ "A ∪ B = " ++ showSet unionAB

    -- Intersection
    let interAB = intersectionSet setA setB
    putStrLn $ "A ∩ B = " ++ showSet interAB

    -- Complement: A^c = U \ A
    let compA = complementSet universe setA
    putStrLn $ "Aᶜ = " ++ showSet compA

    -- Membership
    putStrLn $ "5 ∈ A ? " ++ show (S.member 5 setA)
    putStrLn $ "7 ∈ A ? " ++ show (S.member 7 setA)

    ----------------------------------------------------------------
    putStrLn "\n=== Characteristic Function Perspective ==="

    let crispFive :: ClassicalSet Double
        crispFive = singleton 5.0

    -- complement ใน ClassicalSet: χ_{A^c}(x) = 1 - χ_A(x)  (เทียบเท่า NOT)
    let crispFiveC = ClassicalSet.complement crispFive

    putStrLn $ "χ_A(5.0)   = " ++ show (member crispFive  5.0)
    putStrLn $ "χ_A(5.5)   = " ++ show (member crispFive  5.5)
    putStrLn $ "χ_Aᶜ(5.0)  = " ++ show (member crispFiveC 5.0)
    putStrLn $ "χ_Aᶜ(5.5)  = " ++ show (member crispFiveC 5.5)

    ----------------------------------------------------------------
    putStrLn "\n=== Fuzzy Set Theory ==="

    let fuzzyApproxFive :: FuzzySet Double
        fuzzyApproxFive = mkFuzzySet $ \x ->
            max 0 (1 - abs (x - 5.0) * 0.5)

    let fuzzyApproxSix :: FuzzySet Double
        fuzzyApproxSix = mkFuzzySet $ \x ->
            max 0 (1 - abs (x - 6.0) * 0.5)

    let x = 5.5

    putStrLn $ "μ_Around5(" ++ show x ++ ") = "
        ++ show (membership fuzzyApproxFive x)

    let fuzzyU = fuzzyUnion fuzzyApproxFive fuzzyApproxSix
    let fuzzyI = fuzzyIntersection fuzzyApproxFive fuzzyApproxSix

    putStrLn $ "μ_(A ∪ B)(" ++ show x ++ ") = "
        ++ show (membership fuzzyU x)

    putStrLn $ "μ_(A ∩ B)(" ++ show x ++ ") = "
        ++ show (membership fuzzyI x)

    -- Complement: μ_{A^c}(x) = 1 - μ_A(x)  (Zadeh 1965)
    let fuzzyC = fuzzyComplement fuzzyApproxFive
    putStrLn $ "μ_(Aᶜ)(" ++ show x ++ ")    = "
        ++ show (membership fuzzyC x)

    -- ตรวจสอบ Law of Excluded Middle ไม่ hold ใน Fuzzy Logic:
    -- μ_{A ∪ Aᶜ}(x) ไม่จำเป็นต้องเท่ากับ 1
    let fuzzyExcMid = fuzzyUnion fuzzyApproxFive fuzzyC
    putStrLn $ "\n[Fuzzy: Law of Excluded Middle ไม่ hold]"
    putStrLn $ "μ_(A ∪ Aᶜ)(" ++ show x ++ ") = "
        ++ show (membership fuzzyExcMid x) ++ "  (ไม่เท่ากับ 1)"
