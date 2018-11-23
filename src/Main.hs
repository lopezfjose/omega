
import Data.Char
import System.IO

showLength :: String -> String
showLength str = show (length str)

data Token = TokenOp Op
           | TokenNum Int
           | TokenEnd
    deriving (Show, Eq)

data Op = Add | Subtract deriving (Show, Eq)

op :: String -> Op
op str
    | str == "\t"   = Add
    | str == "\t\t" = Subtract
    | otherwise     = error "<Other Op>"

accumulateSpaces :: String -> String -> [Token]
accumulateSpaces acc [] = [(number acc)]
accumulateSpaces acc (x:xs)
    | [x] == " " = accumulateSpaces (acc ++ [x]) xs
    | otherwise = number acc : tokenize xs

number :: String -> Token
number str = TokenNum (length str)

tokenize :: String -> [Token]
tokenize "" = []
tokenize (x:xs)
    | [x] == "\t" = TokenOp (op [x]) : tokenize xs
    | [x] == " " = accumulateSpaces [x] xs
    | otherwise = error "Other"

loop :: IO ()
loop = do
    putStr "Enter string: "
    hFlush stdout
    line <- getLine
    if (length line) == 0 then
        return ()
    else
        let
            token = tokenize (line :: String)
        in do
            (print . show) token
            main


main :: IO ()
main = do
    loop
