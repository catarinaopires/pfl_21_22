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
divprop a = filter (\n -> a `mod` n == 0) [1..a-1]

-- 2.5

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

-- 2.12

-- 2.13

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

-- 2.18

-- 2.19

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
