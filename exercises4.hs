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

