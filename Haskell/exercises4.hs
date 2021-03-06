import Data.Char (ord, chr)
-- 4.1
primos :: [Int]
primos = crivo [2..]

crivo :: [Int] -> [Int]
crivo (p:xs) = p : crivo [x | x<-xs, x`mod`p/=0]

factores :: Int -> [Int]
factores n = fact n primos

fact :: Int -> [Int] -> [Int]
fact 1 p = []
fact n p = if n `mod` head p == 0 then head p : fact (n `div` head p) p
            else fact n (tail p)

-- 4.2*
sinal :: [Double]
sinal = 1.0 : (-1.0) : sinal

nom = map (*4) sinal -- cycle [4, -4] -- faz um ciclo da lista
denom = [1, 3 ..]

calcPi1 :: Int -> Double
calcPi1 n = sum (zipWith (/) (take n nom) (take n denom))

denom' = [ x*y*z | x <- [2, 4..], y <- [3, 5 ..], z <- [4, 6 ..]]

calcPi2 :: Int -> Double
calcPi2 n = 3 + sum (zipWith (/) (take n nom) (take n denom'))

-- 4.3*
intercalar :: a -> [a] -> [[a]]
intercalar a l = (a:l) : [ take i l ++ [a] ++ drop i l | i <- [1.. length l]]

intercalar' :: a -> [a] -> [[a]]
intercalar' x [] = [[x]]
intercalar' x ys = (ys ++ [x]) : [i ++ [last ys] | i <- intercalar' x (init ys)]

-- 4.4*

unique :: (Eq a) => [a] -> [a]
unique [] = []
unique (x : xs)
  | x `elem` xs = unique xs
  | otherwise = x : unique xs

perms :: Eq a => [a] -> [[a]]
perms [a] = [[a]]
perms l = unique (concat [intercalar (l!!i) perm | i <- [0..length l - 1], perm <- perms (take i l ++ drop (i+1) l)]) 

-- 4.5*
cifrar :: Int -> Char -> Char
cifrar k s = chr ( ((ord s - ord 'a' + k) `mod` 26) + ord 'a')

cifraChave :: String -> String -> String
cifraChave p s = [cifrar k xs | (k, xs) <- zipList]
    where 
        zipList = [(x,y) | (x,y) <- zip cycleList s]
        cycleList = cycle list
        list = [ ord x - ord 'a' | x <- p]

-- 4.6*
-- a)
binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

pascal :: [[Integer]]
pascal  = [[ binom n k| k <- [0..n]] | n <- [0, 1..]]
 
-- b)
pascal' :: [[Integer]]
pascal' = [1] : [[if k == 0 || k == n then 1 else (pascal' !! (n - 1) !! (k - 1) + pascal' !! (n - 1) !! k) | k <- [0 .. n]] | n <- [1,2 ..]]

-- árvores de pesquisa
data Arv a = Vazia | No a (Arv a) (Arv a)

-- 4.7*
sumArv :: Num a => Arv a -> a
sumArv Vazia = 0 
sumArv (No a av1 av2) = sum [a, sumArv av1, sumArv av2] 

-- 4.8
listar :: Arv a -> [a]
listar Vazia = []
listar (No x esq dir) = listar esq ++ [x] ++ listar dir

listardec :: Arv a -> [a]
listardec Vazia = []
listardec (No x esq dir) = listar dir ++ [x] ++ listar esq

-- 4.9*
nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No a _ _) = [a]
nivel n (No a esq dir) = nivel (n-1) esq ++ nivel (n-1) dir

-- 4.10*
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv f Vazia = Vazia
mapArv f (No a esq dir) = No (f a) (mapArv f esq) (mapArv f dir)

-- 4.11*
-- FAZER
-- a)
-- Construir uma árvore equilibrada
-- pré-condição: a lista de valores deve estar
-- por ordem crescente
construir :: [a] -> Arv a
construir [] = Vazia
construir xs = No x (construir xs') (construir xs'')
        where 
          n = length xs`div`2     -- ponto médio
          xs' = take n xs         -- partir a lista
          x:xs'' = drop n xs



-- FAZER

-- b)
inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
      | x==y = No y esq dir             -- já ocorre; não insere
      | x<y = No y (inserir x esq) dir  -- insere à esquerda
      | x>y = No y esq (inserir x dir)  -- insere à direita
      
construir' xs = foldr inserir Vazia xs


-- 4.12*
-- a)
maisEsq :: Arv a -> a
maisEsq (No x Vazia _) = x
maisEsq (No _ esq _) = maisEsq esq

maisDir :: Arv a -> a
maisDir (No x _ Vazia) = x
maisDir (No _ _ dir) = maisDir dir

-- b)
removerMaisDir :: Ord a =>  Arv a -> Arv a
removerMaisDir (No x esq dir) | x == maisDir esq = Vazia
                              | otherwise = No x esq (removerMaisDir dir)
