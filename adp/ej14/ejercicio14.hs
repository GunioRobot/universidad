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
		escribeFichero (head args)
		return ()
		
-- código impuro
				
escribeFichero :: FilePath -> IO ()
escribeFichero fich = do
						contenido <- readFile fich
						putStr contenido

-- código puro

guardaTokens :: Ord a => [a] -> Bolsa a
guardaTokens [] = vacia
guardaTokens (t : ts) = insertar t (guardaTokens ts)