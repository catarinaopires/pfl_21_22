import Data.Char (isLetter)
-- 3.1
-- [f x | x ← xs, p x]
-- map (f) filter (p x) xs

-- 3.2
dec2int :: [Int] -> Int
dec2int x = foldl ((+).(*10)) 0 x

-- ou
-- dec2int x = foldl (\x y -> x*10+y) 0 x
-- ou
-- dec2int x = foldl (+) 0 [ a*10^i | (a, i) <- zip (reverse x) [0..length x]]


-- 3.3
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
--zipWith f xs ys = [f x y | (x, y) <- zip xs ys]           -- Usando Listas em compreensão
zipWith' f (x:xs) (y:ys) = f x y :  zipWith' f xs ys        -- Usando Recursão

-- 3.4
myinsert :: Ord a => a -> [a] -> [a]
myinsert a [] = [a]
myinsert a (x:xs) | a > x = x : myinsert a xs
                  | otherwise = a : (x:xs) 

isort :: Ord a => [a] -> [a]
isort a = foldr myinsert [] a

-- 3.5
-- a)
-- with foldl
-- maximum'' :: Ord a => [a] -> a
-- maximum'' l = foldl (max) (head l) l

-- minimum'' :: Ord a => [a] -> a
-- minimum'' l = foldl (min) (head l) l

-- with foldl1
maximum' :: Ord a => [a] -> a
maximum' l = foldl1 (max) l

minimum' :: Ord a => [a] -> a
minimum' l = foldl1 (min) l

-- b)
-- 3.6

-- 3.7*
-- a)
-- aux function used in a) and c)
aux :: a -> [a] -> [a]
aux a l = l ++ [a]

(+++) :: [a] -> [a] -> [a]
(+++) x y = foldr aux x y

-- b)
myconcat :: [[a]] -> [a]
myconcat l = foldl (++) [] l

-- c)
myreverse :: [a] -> [a]
myreverse l = foldr (aux) [] l

-- d)
aux' :: [a] -> a -> [a]
aux' l a = [a] ++ l

myreverse' :: [a] -> [a]
myreverse' l = foldl (aux') [] l

-- e)
myelem :: Eq a => a -> [a] -> Bool
myelem a l = any (\n -> n == a) l

-- 3.8*
isSpace :: Char -> Bool 
isSpace c = c == ' '

palavras' :: String -> [String]
palavras' [] = [] 
palavras' s = takeWhile (not.isSpace) s : palavras' (dropWhile isSpace (dropWhile (not.isSpace) s))
                

-- 3.9
