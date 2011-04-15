module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime un fichero paginado.
-}

-- código impuro

main :: IO ()
main = 
	do 	{
		args <- getArgs;
		if null args
			then putStrLn "Argumentos insuficientes."
			else do
				texto <- readFile $ head args
				pinta $ lineas texto
				more . quita $ lineas texto
				`catch`
				\_ -> do
						putStrLn "Uso: ./more <fichero-texto>"
		}
						
more :: [String] -> IO ()
more txt = 
	do 	{
		c <- getChar;
		if c == 'q' 
			then return ()
			else do { pinta txt; more $ quita txt }
		}
		
pinta :: [String] -> IO ()
pinta txt = 
	if length txt <= 24
		then do { putStr . concat $ take 24 txt; return () }
		else putStr . concat $ take 24 txt

-- código puro

lineas :: String -> [String]
lineas = map (++ "\n") . tokens (/= '\n')

quita :: [String] -> [String]
quita = drop 24