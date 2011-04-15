module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime las últimas N líneas
de un fichero.
-}

-- código impuro

main :: IO ()
main = 
	do 	{
		args <- getArgs;
		if length args < 2
			then putStrLn "Argumentos insuficientes."
			else 
				do
					texto <- readFile . head $ tail args
					putStr $ nLineas (numero $ head args) texto
					`catch`
					\_ -> do
							putStrLn "Uso: ./tail <número> <fichero-texto>"
		}
		
-- código puro

lineas :: String -> [String]
lineas = tokens (/= '\n')

nLineas :: Int -> String -> String
nLineas n = concat . (\ls -> drop (length ls - n) ls) . map (++ "\n") . lineas

numero :: String -> Int
numero = read