-- 5.1*
module Stack (Stack, -- exportar o tipo
        push, pop, top, -- e as operações
        empty, isEmpty) 
    where
data Stack a = Stk [a] -- implementação usando listas
push :: a -> Stack a -> Stack a
push x (Stk xs) = Stk (x:xs)

pop :: Stack a -> Stack a
pop (Stk (_:xs)) = Stk xs
pop _ = error "Stack.pop: empty stack"

top :: Stack a -> a
top (Stk (x:_)) = x
top _ = error "Stack.top: empty stack"

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk [])= True
isEmpty (Stk _) = False

-- (, {, [
    
close :: Char -> Char 
close '(' = ')'
close '[' = ']'
close '{' = '}'

parent :: String -> Bool
parent s = parentAux s empty

parentAux :: String -> Stack Char -> Bool
parentAux [] stk = isEmpty stk
parentAux (x:xs) stk
            | x == '(' || x == '{' || x == '[' = parentAux xs (push x stk)
            | x == ')' || x == '}' || x == ']'= not (isEmpty stk) && close(top stk) == x && parentAux xs (pop stk)
            | otherwise = parentAux xs stk

-- 5.2*
-- a)
-- implemente uma operação (se o 2º argumento for “+”, “*”, “-” ou “/”
-- ou 
-- coloque um operando na pilha (se o 2º argumento for um numeral); 
-- o resultado deve ser a pilha modificada.  

operation :: Float -> String -> Float -> Float
operation a op b | op == "+" = b + a
                 | op == "-" = b - a
                 | op == "/" = b / a
                 | op == "*" = b * a

calc :: Stack Float -> String -> Stack Float 
calc stk s | s == "+" || s == "*" || s == "-" || s == "/" = push (operation (top stk) s (top(pop stk))) (pop (pop stk))
           | otherwise =  push (read s) stk

-- b)
isSpace :: Char -> Bool 
isSpace c = c == ' '

palavras' :: String -> [String]
palavras' [] = [] 
palavras' s = takeWhile (not.isSpace) s : palavras' (dropWhile isSpace (dropWhile (not.isSpace) s))

calcular :: String -> Float
calcular s = if isEmpty(pop stk) then result else error "Stack not empty" 
    where 
        stk = foldl calc empty (palavras' s)
        result = top stk

