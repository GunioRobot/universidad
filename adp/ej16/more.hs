module Main where

import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Imprime un fichero paginado.
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
		pinta $ lineas texto
		more $ quita $ lineas texto
		
more :: [String] -> IO ()
more txt = do
			c <- getChar
			if c == 'q' then
				return ()
			else do
					pinta txt
					if length txt <= 24 then
						return()
					else
						more $ quita txt
		
pinta :: [String] -> IO ()
pinta txt = putStr . concat $ take 24 txt

-- código puro

lineas :: String -> [String]
lineas = map (++ "\n") . tokens (/= '\n')

quita :: [String] -> [String]
quita = drop 24