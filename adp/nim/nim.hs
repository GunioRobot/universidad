module Main where

import Data.List (elemIndex)
import System.Environment
import System.Random

{-
Programa para jugar al Nim (dos jugadores).
http://en.wikipedia.org/wiki/Nim.
-}

{- TODO
 - Refactorizar
-}

-- código impuro

main :: IO ()
main = 
	do
		args <- getArgs
		if null args || length args < 2
			then putStrLn "Argumentos insuficientes."
			else 
				do 	{
					nim (pilas args) (fichas args)
					`catch`
					\_ -> putStrLn "Uso: ./nim <número> <número>"
					}
					
nim :: Int -> Int -> IO ()
nim p n = 
	do 	{
		pilas <- generaPilas p n;
		juego 0 pilas
		}
		
-- considero jugador 0 y jugador 1
juego :: Int -> [Int] -> IO ()
juego j ps =
	do 	{
		if and $ map (== 0) ps
			then do { putStrLn $ "EL JUGADOR " ++ show j ++ " PIERDE."; return () }
			else do
				pintaPilas ps;
				putStrLn $ "TURNO - JUGADOR " ++ show j;
				pila <- pregunta "Introduce el número de pila:" :: IO Int;
				if pila <= 0 || pila > length ps
					then juego j ps;				-- ERROR HANDLING?
					else 
						do 	{
							fichas <- pregunta "¿Cuántas fichas quieres sacar?" :: IO Int;
							if fichas > 0 && jugadaVálida pila fichas ps
								then 
									do 	{
										if j == 0 
											then juego 1 (jugada pila fichas ps)
											else juego 0 (jugada pila fichas ps)
										}
								else juego j ps		-- ERROR HANDLING?
							}
		}
		

jugada :: Int -> Int -> [Int] -> [Int]
jugada p f pilas = nuevasPilas
	where
		primeras = take (p - 1) pilas
		últimas = drop (p - 1) pilas
		nuevasPilas = primeras ++ head últimas - f : tail últimas
		
jugadaVálida :: Int -> Int -> [Int] -> Bool
jugadaVálida p f pilas = f <= pilas !! (p - 1)
	
generaPilas :: Int -> Int -> IO [Int]
generaPilas 0 n = do { return [] }
generaPilas p n = 
	do 	{
		pilas <- generaPilas (p - 1) n;
		num <- randomRIO (1, n);
		return $ num : pilas
		}

pintaPilas :: [Int] -> IO ()
pintaPilas = pintaPilasDesde 1

pintaPilasDesde :: Int -> [Int] -> IO ()
pintaPilasDesde _ [] = return ()
pintaPilasDesde n (x : xs) = 
	do 	{
		putStrLn $ "[" ++ show n ++ "]\t: " ++ replicate x '*';
		pintaPilasDesde (n + 1) xs  
		}
		
pregunta :: Read a => String -> IO a
pregunta s = do
              putStrLn s
              r <- readLn
              return r
		
-- código puro

pilas :: [String] -> Int
pilas = read . head

fichas :: [String] -> Int
fichas = read . head . tail