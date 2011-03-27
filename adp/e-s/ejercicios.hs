import Data.Char (ord, toLower)
import System.Environment

-- Ejercicio 1
-- TODO : utilizar (>>=)

-- Primer y último carácter de tres
tresPrimeroUltimo :: IO (Char, Char)
tresPrimeroUltimo = 
      do
        x <- getChar
        getChar
        z <- getChar
        return (x, z)

-- Tres caracteres como String
tresCadena :: IO String
tresCadena =
      do
        x <- getChar
        y <- getChar
        z <- getChar
        return [x,y,z]

-- Suma de los ordinales de los tres caracteres
tresSumaOrdinales :: IO Int
tresSumaOrdinales =
      do
        x <- getChar
        y <- getChar
        z <- getChar
        return $ (ord x + ord y + ord z)

-- Ejercicio 2

-- Saludo personalizado
saludo :: IO ()
saludo =  putStr "Dime tu nombre: " >>= \_ -> 
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
factorial = putStr "Dime un número: " >>= \_ -> 
            readLn >>= \x ->
            print $ fact x

-- Ejercicio 4

-- Imprime la inversa de la cadena leída
leeCadena :: IO ()
leeCadena = getChar >>= \c -> 
              if (c == '\n') 
                then 
                  putChar '\n'
                else
                  leeCadena >>= \_ ->
                  putChar c

-- Ejercicio5
-- Ejercicios anteriores con notación 'do'

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
                if (c == '\n')
                  then
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
                      if prop x
                        then do
                              return []
                        else do
                              xs <- leeSecuencia prop
                              return $ x : xs