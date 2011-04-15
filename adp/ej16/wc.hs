module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime el número de \n, palabras y bytes 
en un fichero.
-}

-- código impuro

main :: IO ()
main = 
	do 	{
		args <- getArgs;
		if null args
			then putStrLn "Argumentos insuficientes."
			else
				let
					arg = head args
				in
				do
					texto <- readFile arg
					putStrLn $  wc texto ++ arg
					`catch`
					\_ -> do { putStrLn "Uso: ./wc <fichero-texto>" }
		}
						
-- código puro

wc :: String -> String
wc t = "\t" ++ (nLineas t) ++ "\t" ++ (nPalabras t) ++ "\t" ++ (nBytes t) ++ "\t"

nLineas :: String -> String
nLineas = show . cuentaCaracter '\n'
								 	
nPalabras :: String -> String
nPalabras = show . length . tokens isAlpha

nBytes :: String -> String
nBytes = show . length

cuentaCaracter :: Char -> String -> Int
cuentaCaracter c = 
	foldr f 0
		where
			f x xs = if x == c
						then 1 + xs
						else xs