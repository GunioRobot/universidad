module Main where

import BolsaLog
import Data.Char (isAlpha)
import System.Environment
import Tokeniser

{-
Lee un fichero de texto y muestra por pantalla
la frecuencia absoluta de las palabras que contiene.
-}

{-
 TODO
 - Pintar asteriscos
 - Manejo de excepciones
 - Refactorizar
-}

-- código impuro

main :: IO ()
main = do
		arg : _ <- getArgs
		palabras <- readFile arg
		pintaLineas $ bolsaFrecuencias palabras

pintaLineas :: Bolsa String -> IO ()
pintaLineas bs = putStr salida
					where
						ls = bolsaALista bs
						salida = concat $ map (linea $ longitudTokenMasLargo ls) ls
						
-- código puro

bolsaFrecuencias :: String -> Bolsa String
bolsaFrecuencias = listaABolsa . tokens isAlpha

linea :: Int -> (String, Int) -> String
linea l (x, n) = x ++ replicate nEspacios ' '  ++ "[" ++ show n ++ "]" ++ replicate n '*' ++ "\n"
					where
						nEspacios = l - length x + 1

longitudTokenMasLargo :: [(String, Int)] -> Int
longitudTokenMasLargo = foldr f 0
							where
								f (t, _) ts = max (length t) ts
-- longitudTokenMasLargo ((t, _) : ts) = max (length t) (longitudTokenMasLargo ts)
