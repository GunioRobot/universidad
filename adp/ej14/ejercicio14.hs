module Main where

import BolsaLog
import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Lee un fichero de texto y muestra por pantalla
la frecuencia absoluta de las palabras que contiene.
-}

-- código impuro

main :: IO ()
main = do
		args <- getArgs
		if null args
			then putStrLn "Debe introducir un fichero de texto como parámetro."
			else do
					palabras <- readFile $ head args
					pintaLineas $ frecuencia palabras
					`catch`
					\_ -> do
							putStrLn "Uso: ./ejercicio14 <fichero-texto>"
							

pintaLineas :: Bolsa String -> IO ()
pintaLineas bs = putStr salida
					where
						ls = bolsaALista bs
						ancho = longitudTokenMasLargo ls
						salida = concat $ map (linea ancho) ls
						
-- código puro

frecuencia :: String -> Bolsa String
frecuencia = listaABolsa . tokens isAlpha

linea :: Int -> (String, Int) -> String
linea l (x, n) = x ++ replicate nEspacios ' '  ++ "[" ++ show n ++ "]" ++ replicate n '*' ++ "\n"
					where
						nEspacios = l - length x + 1

longitudTokenMasLargo :: [(String, Int)] -> Int
longitudTokenMasLargo = foldr f 0
							where
								f (t, _) ts = max (length t) ts