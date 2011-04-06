module Main where

import BolsaLog
import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Lee un fichero de texto y muestra por pantalla
la frecuencia absoluta de las palabras que contiene.
-}

main :: IO ()
main = do
		args <- getArgs
		palabras <- readFile (head args)
		pintaLineas $ bolsaFrecuencias palabras
		
-- código puro

bolsaFrecuencias :: String -> Bolsa String
bolsaFrecuencias = listaABolsa . tokens isAlpha

linea :: (String, Int) -> String
linea (x, n) = x ++ "   [" ++ show n ++ "]\n"

-- código impuro

pintaLineas :: Bolsa String -> IO ()
pintaLineas bs = putStr salida
					where
						ls = bolsaALista bs
						salida = concat $ map linea ls