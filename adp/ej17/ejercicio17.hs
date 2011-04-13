module Main where

import System.Environment
import System.Random

{-
Juego de adivinanza.
Se genera un número aleatorio
que hay que adivinar.
-}

-- código impuro

main :: IO ()
main = do
		args <- getArgs
		if null args
			then do
					num <- randomRIO (1, 100)
					adivinanza num
			else do
					num <- randomRIO (número $ head args, número . head $ tail args)
					adivinanza num
					`catch`
					\_ -> putStrLn "Uso: ./ejercicio17 <número> <número>"
					
		return ()

adivinanza :: Int -> IO ()
adivinanza solucion = do
						num <- pregunta "Dame un número:" :: IO Int
						if num == solucion
							then putStrLn "¡Enhorabuena! Has acertado."
							else if num < solucion
								then do { putStrLn "La solución es mayor que tu respuesta" ; adivinanza solucion }
								else do { putStrLn "La solución es menor que tu respuesta" ; adivinanza solucion }
			
pregunta :: Read a => String -> IO a
pregunta s = do
              putStrLn s
              r <- readLn
              return r
				
-- código puro

número :: String -> Int
número = read
