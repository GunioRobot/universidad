import Data.Char
import System.Environment

-- Separar argumentos, contarlos e imprimirlos en minúscula

main :: IO ()
main = do
		args <- getArgs
		putStr "Ha introducido "
		putStr $ show $ length args
		putStrLn " parámetros"
		sequence_ (map putStrLn $ map (map toLower)  args)