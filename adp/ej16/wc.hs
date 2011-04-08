module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime el número de \n, palabras y bytes 
en un fichero.
-}

{-
 TODO
 - Manejo de excepciones
 - Refactorizar
-}

-- código impuro

main :: IO ()
main = do
		arg : _ <- getArgs
		texto <- readFile arg
		putStrLn $  wc texto ++ arg
		
-- código puro

wc :: String -> String
wc t = "\t" ++ (nLineas t) ++ "\t" ++ (nPalabras t) ++ "\t" ++ (nBytes t) ++ "\t"

nLineas :: String -> String
nLineas = show . cuentaNuevaLinea

cuentaNuevaLinea :: String -> Int
cuentaNuevaLinea = foldr f 0
					where
						f x xs = if x == '\n' then
									1 + xs
								 else
								 	xs
								 	
nPalabras :: String -> String
nPalabras = show . length . tokens isAlpha

nBytes :: String -> String
nBytes = show . length