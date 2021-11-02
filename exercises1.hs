-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c | a + b < c = False 
                     | a + c < b = False 
                     | c + b < a = False 
                     | otherwise = True 

                    
-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt(calculateS a b c * 
                        (calculateS a b c - a) *
                        (calculateS a b c - b) *
                        (calculateS a b c - c))

calculateS :: Float -> Float -> Float -> Float
calculateS a b c = (a + b + c)/2

-- 1.3
metades :: [t] -> ([t], [t])
metades l = (take (length l `div` 2) l, drop (length l `div` 2) l)

-- 1.4
-- a)
last' :: [t] -> t 
last' a = head(reverse a)

-- b)
init' :: [t] -> [t]
init' a = reverse(tail(reverse a))
-- ou  reverse(drop 1 (reverse a))


-- 1.5
-- a)
binom :: Integer -> Integer -> Integer
binom n k = product [1..n] `div` (product [1..k] * product [1..(n-k)])

-- b)
binom' :: Integer -> Integer -> Integer
binom' n k = if k < n - k then product [n-k+1..n] `div` product [1..k] 
              else product [k+1..n] `div` product [1..n-k]

-- 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ((- b - binomio)/2, (- b + binomio)/2) 
                where binomio =  sqrt(b*b - 4 * a * c)

-- 1.7
-- a) Lista de chars / string [Char]
-- b) Tuplos de chars (Char, Char)
-- c) Lista de tuplos de booleanos e chars [(Bool, Char)]
-- d) Tuplos de listas de booleanos e chars ([Bool], [Char])
-- e) Lista de funções template ( [[a] -> [a]] )
-- f) Lista de funções de booleanos para booleanos (id é template mas not restringe o tipo da lista) [Bool -> Bool]

-- 1.8
-- a) segundo :: [l] -> l
-- b) trocar :: (x, y) -> (y, x)
-- c) par :: x -> y -> (x, y)
-- d) dobro :: Num a => a -> a
-- e) metade :: Fractional a => a -> a
-- f) minuscula :: Char -> Bool
-- g) intervalo :: Ord a => a -> a -> a -> Bool
-- h) palindromo :: Eq a => [a] -> Bool
-- i) twice :: (x -> x) -> x -> x _______ função f: (x -> x)  


-- NOTA: Num e Fractional são Classes e não tipos, pelo que, tem que se colocar como restrição

-- 1.9
classifica :: Int -> String
classifica x | x <= 9 = "reprovado" 
             | x >= 10 && x <= 12 = "suficiente" 
             | x >= 13 && x <= 15 = "bom"
             | x >= 16 && x <= 18 = "muito bom"
             | x >= 19 && x <= 20 = "muito bom com distincao"
             | x < 0 && x > 20 = "invalido"  

-- 1.10

classificapeso :: Float -> Float -> String
classificapeso p a | imcValue < 18.5 = "baixo peso" 
                   | imcValue >= 18.5  && imcValue < 25 = "peso normal" 
                   | imcValue >= 25  && imcValue < 30 = "excesso de peso" 
                   | imcValue >= 30 = "obsedidade"
                   where imcValue = imc p a

imc :: Float -> Float -> Float 
imc p a = p / (a*a)


-- 1.11
--max, min :: Ord a => a -> a -> a
--max x y = if x>=y then x else y
--min x y = if x<=y then x else y

-- a)

--max3, min3 :: Ord a => a -> a -> a
--max3 x y z= if x>=y && x >= z then x else 
--    (if ..<.. && .. >= .. then .. else) ..

--min3 x y z= if x<=y then x else y

-- b)

max3 :: Ord a => a -> a -> a -> a
max3 x y z = max (max x y) z 

min3 :: Ord a => a -> a -> a -> a
min3 x y z = min (min x y) z 


-- 1.12
xor' :: Bool -> Bool -> Bool
True `xor'` True = False
False `xor'` False = False
True `xor'` False = True
False `xor'` True = True 

-- 1.13
safetail :: [a] -> [a]
safetail a = if null a then [] else tail a


-- 1.14
curta :: [a] -> Bool
-- a) 
--curta l | length l <= 2 = True 
  --      | otherwise = False

-- b)
curta l | null(tail l) = True
        | null(tail (tail l)) = True 
        | null(tail (tail (tail l))) = True 
        | otherwise = False


-- 1.15
--mediana :: Ord a => [a] -> a
--mediana a =

-- 1.16
 {-
  Defina uma função textual :: Int -> String para
  converter um número positivo inferior a um milhão para
  a designação textual em Português.

  Baseado na solução no livro "Introduction to Functional Programming"
  de Bird & Wadler, 1988.

  Vamos começar por resolver um problema mais pequeno:
  converter para texto números inferiores a 100
  (i.e., até dois algarismos).
  Começamos por definir listas com a representação textual
  de numeros pequenos.
 -}
 
unidades :: [String]
unidades =
  [ "zero"
  , "um"
  , "dois"
  , "tres"
  , "quatro"
  , "cinco"
  , "seis"
  , "sete"
  , "oito"
  , "nove"
  ]

dez_a_dezanove :: [String]
dez_a_dezanove =
  [ "dez"
  , "onze"
  , "doze"
  , "treze"
  , "quatorze"
  , "quinze"
  , "dezasseis"
  , "dezassete"
  , "dezoito"
  , "dezanove"
  ]

dezenas :: [String]
dezenas =
  [ "vinte"
  , "trinta"
  , "quarenta"
  , "cinquenta"
  , "sessenta"
  , "setenta"
  , "oitenta"
  , "noventa"
  ]

{-
  A função 'converte2' é composição de duas:
  * 'divide2' obtêm os algarimos;
  * 'combina2' combina o texto de cada algarismo.
  Usamos as operações de concatenação (++) e
  indexação de listas (!!) (note que os índices começam em zero.)
-}
converte2 :: Int -> String
converte2 n | n < 100 = combina2 (divide2 n)

divide2 :: Int -> (Int, Int)
divide2 n = (n`div`10, n`mod`10) -- (quociente,resto)

combina2 :: (Int, Int) -> String
combina2 (0, u) = unidades !! u
combina2 (1, u) = dez_a_dezanove !! u
combina2 (d, 0) = dezenas !! (d-2)
combina2 (d, u) = dezenas !! (d-2) ++ " e " ++ unidades !! u

{- Em seguida, resolvemos o problema análogo para números até 3
   algarismos. Necessitamos dos nomes em Português das centenas.
 -}
centenas :: [String]
centenas =
  [ "cento"
  , "duzentos"
  , "trezentos"
  , "quatrocentos"
  , "quinhentos"
  , "seiscentos"
  , "setecentos"
  , "oitocentos"
  , "novecentos"
  ]

{- A função de conversão, nos mesmos moldes da anterior.
   Note o tratamento especial do número 100.  -}
converte3 :: Int -> String
converte3 n | n<1000 = combina3 (divide3 n)

divide3 :: Int -> (Int, Int)
divide3 n = (n`div`100, n`mod`100)

combina3 :: (Int, Int) -> String
combina3 (0, n) = converte2 n
combina3 (1, 0) = "cem"
combina3 (c, 0) = centenas !! (c-1)
combina3 (c, n) = centenas !! (c-1) ++ " e " ++ converte2 n

{- Finalmente podemos resolver o problema para números
  até 6 algarismos, i.e. inferiores a 1 milhão.  -}
converte6 :: Int -> String
converte6 n | n<1000000 = combina6 (divide6 n)

divide6 n = (n `div` 1000, n `mod` 1000)

combina6 (0, n) = converte3 n
combina6 (1, 0) = "mil"
combina6 (1, n) = "mil" ++ ligar n ++ converte3 n
combina6 (m, 0) = converte3 m ++ " mil"
combina6 (m, n) = converte3 m ++ " mil" ++ ligar n ++ converte3 n

{- Uma função auxiliar para escolher a partícula de ligação entre
   milhares e o restante (r).
   Regra: colocamos "e" quando o resto é inferior a 100
   ou múltiplo de 100; caso contrario, basta um espaço.
 -}
ligar :: Int -> String
ligar r
  | r < 100 || r `mod` 100 == 0 = " e "
  | otherwise                   = " "

-- A solução do exercício proposto é converte6.
converte :: Int -> String
converte = converte6
------------------------------------------------------------------------

