import Data.Char (ord, toLower)
import System.Environment

-- Ejercicio 1

-- Primer y último carácter de tres
tresPrimeroUltimo :: IO (Char, Char)
tresPrimeroUltimo = 
        getChar >>= \x ->
        getChar >>= \_ ->
       	getChar >>= \z ->
        return (x, z)

-- Tres caracteres como String
tresCadena :: IO String
tresCadena =
        getChar >>= \x ->
        getChar >>= \y ->
       	getChar >>= \z ->
        return [x, y, z]

-- Suma de los ordinales de los tres caracteres
tresSumaOrdinales :: IO Int
tresSumaOrdinales =
        getChar >>= \x ->
        getChar >>= \y ->
       	getChar >>= \z ->
        return $ (ord x + ord y + ord z)

-- Ejercicio 2

-- Saludo personalizado
saludo :: IO ()
saludo =  
		putStr "Dime tu nombre: " >>= \_ -> 
		getLine >>= \nombre -> 
		putStrLn $ "Hola " ++ nombre

-- Ejercicio 3

-- Factorial
fact :: Int -> Int
fact x
  | x == 0 = 1
  | otherwise = x * fact (x - 1)

-- Factorial del número insertado
factorial :: IO ()
factorial = 
		putStr "Dime un número: " >>= \_ -> 
		readLn >>= \x ->
		print $ fact x

-- Ejercicio 4

-- Imprime la inversa de la cadena leída
leeCadena :: IO ()
leeCadena = 
		getChar >>= \c -> 
			if (c == '\n') then 
				putChar '\n'
			else
				leeCadena >>= \_ ->
				putChar c

-- Ejercicio5
-- Ejercicios anteriores con notación 'do'

tresPrimeroUltimo' :: IO (Char, Char)
tresPrimeroUltimo' = do
        				x <- getChar
        				getChar
        				z <- getChar
        				return (x, z)
        				
tresCadena' :: IO String
tresCadena' = do
				x <- getChar
				y <- getChar
				z <- getChar
				return [x, y, z]
        
tresSumaOrdinales' :: IO Int
tresSumaOrdinales' = do
						x <- getChar
						y <- getChar
						z <- getChar
						return $ (ord x + ord y + ord z)

doSaludo :: IO ()
doSaludo = do
            putStr "Dime tu nombre: "
            nombre <- getLine
            putStrLn $ "Hola " ++ nombre


doFactorial :: IO ()
doFactorial = do 
				putStr "Dime un número: " 
				x <- readLn
				print $ fact x

doLeeCadena :: IO ()
doLeeCadena = do
                c <- getChar
                if (c == '\n') then
					putChar '\n'
				else
                	do
                      doLeeCadena
                      putChar c

-- Ejercicio 6

-- Pregunta y leer respuesta
pregunta :: Read a => String -> IO a
pregunta s = do
              putStrLn s
              r <- readLn
              return r

-- Probar 'pregunta'
preguntas :: IO (String, Integer)
preguntas = do
              nombre <- pregunta "Nombre: "
              edad <- pregunta "Edad: "
              return (nombre, edad)

-- Ejercicio 7

-- Lee valores hasta que uno cumpla la propiedad, devuelve lista de los que no
leeSecuencia :: Read a => (a -> Bool) -> IO [a]
leeSecuencia prop = do
						x <- readLn
						if prop x then do { return [] }
						else do 
							{
							xs <- leeSecuencia prop;
                        	return $ x : xs
                        	}
                              
-- Ejercicio 8

-- TODO: Separar argumentos, contarlos e imprimirlos en minúscula
cuenta :: IO ()
cuenta = do
		   	args <- getArgs
			putStr "Ha introducido "
			putStr $ show $ length args
			putStrLn " parámetros"
			sequence_ (map putStrLn args)
			
-- Ejercicio 9

-- Ejecuta n veces la acción de entrada/salida dada

-- TODO: versión recursiva
	
-- utilizando sequence_
repite' :: Int -> IO a -> IO ()
repite' n accion = sequence_ $ replicate n accion

-- Ejercicio 10

-- Definir una función equivalente a 'sequence_'

-- con (>>=)
secuenciaBind :: Monad m => [m a] -> m ()
secuenciaBind [] = return ()
secuenciaBind (a:as) = 
			a >>= \_ ->
			secuenciaBind as

-- TODO: con 'foldr'

-- TODO: con 'foldl'