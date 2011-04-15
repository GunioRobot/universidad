module Main where

import Data.List (elemIndex)
import System.Environment
import System.Random

{-
Programa para jugar al Nim (dos jugadores).
http://en.wikipedia.org/wiki/Nim.
-}

-- código impuro

main :: IO ()
main = 
	do 	{
		args <- getArgs;
		if null args || length args < 2
			then putStrLn "Argumentos insuficientes."
			else 
				do
					nim (pilas args) (fichas args) -- TODO : control de errores
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
		if terminada ps
			then do { putStrLn $ "EL JUGADOR " ++ show j ++ " PIERDE." }
			else 
				do
					pintaPilas ps;
					putStrLn $ "TURNO - JUGADOR " ++ show j;
					pila <- pregunta "Introduce el número de pila:" :: IO Int;
					if pilaVálida pila ps
						then do { putStrLn "-PILA NO VÁLIDA-"; juego j ps }
						else 
							do 	
								fichas <- pregunta "¿Cuántas fichas quieres sacar?" :: IO Int
								if jugadaVálida pila fichas ps
									then juego (1 - j) (jugada pila fichas ps)
									else do { putStrLn "-JUGADA NO VÁLIDA-"; juego j ps }
		}
	
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
pregunta s = 
	do 	{
		putStrLn s;
      	r <- readLn;
      	return r
		}
		
-- código puro

pilas :: [String] -> Int
pilas = read . head

fichas :: [String] -> Int
fichas = read . head . tail

jugada :: Int -> Int -> [Int] -> [Int]
jugada p f pilas = 
	nuevasPilas
		where
			primeras = take (p - 1) pilas
			últimas = drop (p - 1) pilas
			nuevasPilas = primeras ++ head últimas - f : tail últimas
		
jugadaVálida :: Int -> Int -> [Int] -> Bool
jugadaVálida p f pilas = f > 0 && f <= pilas !! (p - 1)

terminada :: [Int] -> Bool
terminada = and . map (== 0)

pilaVálida :: Int -> [Int] -> Bool
pilaVálida pila ps = pila <= 0 || pila > length ps