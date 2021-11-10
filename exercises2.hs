import Data.Char (ord, chr, isNumber)
import GHC.Unicode (isLower, isUpper)
-- 2.1
soma1 :: Int 
soma1 = sum [a^2 | a <- [1..100]]

-- 2.2
-- a)
aprox :: Int -> Double
aprox n = sum [ (-1)**a / (2 * a + 1) | a <- [1.0, 2.0 .. fromIntegral n]]

-- b)
aprox' :: Int -> Double
aprox' n = sum [ (-1)**a / (a + 1)^2 | a <- [1.0, 2.0 .. fromIntegral n]]

-- 2.3
dotprod :: [Float] -> [Float] -> Float
dotprod a b = sum [ x*y | (x, y) <- zip a b]

-- 2.4
divprop :: Integer -> [Integer]
divprop a = [x | x <- [1..a-1], a `mod` x == 0]
--divprop a = filter (\n -> a `mod` n == 0) [1..a-1]

-- 2.5
perfeitos :: Integer -> [Integer]
perfeitos a = [ x | x <- [1..a], x == sum (divprop x)]

-- 2.6*
pitagoricos :: Integer ->[(Integer ,Integer ,Integer)] 
pitagoricos a = filter ( \(x, y, z) -> x^2 + y^2 == z^2 )[(x, y, z) | x <- [1..a], y <- [1..a], z <- [1..a]]

-- 2.7*
primo :: Integer-> Bool
primo a = divprop a == [1]

-- 2.8*
binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

pascal :: Integer -> [[Integer]]
pascal a = [map(binom i)[0..i] | i <- [0..a]]

-- 2.9
cifrar :: Int -> String -> String
cifrar k s = [chr ( ((ord x - ord 'a' + k) `mod` 26) + ord 'a') | x <- s ]

-- 2.10*
-- a)
myand :: [Bool] -> Bool
myand [] = True
myand (x:xs) | x = myand xs
             | otherwise =  False

-- b)
myor :: [Bool] -> Bool
myor [] = False
myor (x:xs) | not x = myor xs
            | otherwise =  True

-- c)
myconcat :: [[a]] -> [a]
myconcat [[xs]] = [xs]
myconcat (x:xs) = x ++ myconcat xs

-- d)
myreplicate :: Int -> a -> [a]
myreplicate 0 a = []
myreplicate n a = a: myreplicate (n-1) a

-- e)
myindex :: [a] -> Int -> a
myindex (x:xs) 0 = x
myindex (x:xs) i = myindex xs (i-1)

-- f)
myelem :: Eq a => a -> [a] -> Bool
myelem n [] = False
myelem n (x:xs) | n == x = True 
                | otherwise = myelem n xs

-- 2.11
myconcat' :: [[a]] -> [a]
myconcat' l = [x | xs <- l, x <- xs]

myreplicate' :: Int -> a -> [a]
myreplicate' n a = [a | _ <- [1..n]]

myindex' :: [a] -> Int -> a
myindex' l i = head ([x | x <- l, n <- [0..length l - 1], n == i])
-- ou
--myindex' l i = head([ x | (x,y) <- zip l [0..length l - 1], y==i]) 

-- 2.12
forte :: String -> Bool
forte x = length x >= 8 && any isLower x && any isUpper x && any isNumber x

-- 2.13
mindiv :: Int -> Int
mindiv 0 = 0
mindiv 1 = 1
mindiv n | null z = n 
         | otherwise = head z
         where z = [ y | y <- [2..(floor . sqrt . fromIntegral) n], n `mod` y == 0]

primo' :: Int -> Bool
primo' n | n <= 1 = False 
         | otherwise = mindiv n == n


-- 2.14*
mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub l = head l : mynub [x | x <- tail l, x /= head l]

-- Explicação:
    -- [x | x <- tail l, x /= head l]
        -- Percorre a lista sem o primeiro elemento e devolve uma lista onde não tem elementos iguais ao primeiro elemento da lista original
    -- head l : mynub [x | x <- tail l, x /= head l]
        -- Percorre lista e remove os elementos a seguir ao current elemento analisado
    

-- 2.15*
myintersperse :: a -> [a] -> [a]
myintersperse a [] = []
myintersperse a [l] = [l]           -- [l] lista com um elemento, neste caso l
myintersperse a (x:xs) = [x, a] ++ myintersperse a xs 

-- 2.16*
algarismosRev :: Int -> [Int]
algarismosRev a | a < 10 = [a]  
                | otherwise = (a `mod` 10) : algarismosRev (a `div` 10)

algarismos :: Int -> [Int]
algarismos a = reverse (algarismosRev a)

-- 2.17
toBitsRev :: Int -> [Int]
toBitsRev a | a < 2 = [a]  
            | otherwise = (a `mod` 2) : toBitsRev (a `div` 2)

toBits :: Int -> [Int]
toBits a = reverse (toBitsRev a)

-- 2.18
fromBits :: [Int] -> Int
fromBits a = fromBitsAux (reverse a)

fromBitsAux :: [Int] -> Int
fromBitsAux [] = 0
fromBitsAux (x:xs) = x + fromBitsAux ([a*2 | a <- xs])

-- 2.19
mdc :: Integer -> Integer -> Integer
mdc a 0 = a
mdc a b = mdc b (a `mod` b)

-- 2.20*
-- a)
{- qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort menores ++ [x] ++ qsort maiores
    where menores = [y | y<-xs, y<=x]
          maiores = [y | y<-xs, y>x]


myinsert :: Ord a => a -> [a] -> [a]
myinsert a l = qsort (a:l) -}


-------------------------

myinsert :: Ord a => a -> [a] -> [a]
myinsert a [] = [a]
myinsert a (x:xs) | a > x = x : myinsert a xs
                  | otherwise = a : (x:xs) 


-- 2.21



-- 2.22

-- 2.23*
