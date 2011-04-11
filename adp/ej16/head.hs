module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime las primeras N líneas
de un fichero.
-}

-- código impuro

main :: IO ()
main = do
		args <- getArgs
		if length args < 2
			then putStrLn "Argumentos insuficientes."
			else do
					texto <- readFile . head $ tail args
					putStr $ nLineas (número $ head args) texto
					`catch`
					\_ -> do
							putStrLn "Uso: ./head <número> <fichero-texto>"
		
-- código puro

lineas :: String -> [String]
lineas = tokens (/= '\n')

nLineas :: Int -> String -> String
nLineas n = concat . take n . map (++ "\n") . lineas

número :: String -> Int
número = read