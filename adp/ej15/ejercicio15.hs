module Main where
	
import Data.Bits
import Data.Char (chr, ord)
import System.Environment

{-
Cifrar y descifrar un
fichero de texto.
Uso:
./main <fichero-origen> <fichero-destino> <clave-numérica> <0:cifrar|[^0]:descifrar>
-}

-- código impuro

main :: IO ()
main = 
	do 	{
		args <- getArgs;
		if length args < 4
			then putStrLn "Argumentos insuficientes.";
			else
				let
					fichOrigen = head args
					fichDestino = head $ tail args
					clave = número . head $ drop 2 args
					cifrar = número . head $ drop 3 args
					uso = "Uso: ./c <fichero> <fichero> <clave> <cifrar/descifrar>"
				in
				do 	{
					cripto fichOrigen fichDestino clave cifrar
					`catch`
					\_ -> putStrLn uso
					}
		}
	
-- cripto origen destino clave cifrar/descifrar
cripto :: String -> String -> Int -> Int -> IO ()
cripto fOrigen fDestino clave cif = 
	do 	{
		origen <- readFile fOrigen
		`catch`
		\_ -> ioError (userError "Introduzca fichero origen existente.");
		if cif == 0
			then do {
					(writeFile fDestino $ cifrar clave origen)
					`catch`
					\_ -> ioError (userError "Introduzca fichero destino existente.");
					}
			else do {
					(writeFile fDestino $ descifrar clave origen)
					`catch`
					\_ -> ioError (userError "Introduzca fichero destino existente.");
					}
		}

-- código puro

cifrar :: Int -> String -> String
cifrar clave = map (chr . (xor clave) . ord)

descifrar :: Int -> String -> String
descifrar = cifrar

número :: String -> Int
número = read