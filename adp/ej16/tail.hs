module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime las últimas N líneas
de un fichero.
-}

{-
 TODO
 - Manejo de excepciones
 - Refactorizar
-}

-- código impuro

main :: IO ()
main = do
		args <- getArgs
		texto <- readFile $ head (tail args)
		putStrLn $ nLineas (numero $ head args) texto

		
-- código puro

lineas :: String -> [String]
lineas = tokens (/= '\n')

nLineas :: Int -> String -> String
nLineas n = concat . (\ls -> drop (length ls - n) ls) . map (++ "\n") . lineas

numero :: String -> Int
numero = read