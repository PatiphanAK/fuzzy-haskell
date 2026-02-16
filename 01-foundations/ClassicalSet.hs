module ClassicalSet where

newtype ClassicalSet a = ClassicalSet
  { member :: a -> Bool
  }

-- Operations
empty :: ClassicalSet a
empty = ClassicalSet $ \_ -> False

-- สร้างเซตที่มีสมาชิกตัวเดียว
singleton :: Eq a => a -> ClassicalSet a
singleton x = ClassicalSet $ \y -> x == y

-- Union: A ∪ B (ใช้ Logical OR)
union :: ClassicalSet a -> ClassicalSet a -> ClassicalSet a
union (ClassicalSet a) (ClassicalSet b) = ClassicalSet $ \x -> a x || b x

-- Intersection: A ∩ B (ใช้ Logical AND)
intersection :: ClassicalSet a -> ClassicalSet a -> ClassicalSet a
intersection (ClassicalSet a) (ClassicalSet b) = ClassicalSet $ \x -> a x && b x

-- Complement: A^c (ใช้ Logical NOT)
complement :: ClassicalSet a -> ClassicalSet a
complement (ClassicalSet a) = ClassicalSet $ \x -> not (a x)
