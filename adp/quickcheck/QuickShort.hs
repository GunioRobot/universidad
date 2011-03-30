module QuickSort (qSort) where

import List ((\\))
import Test.QuickCheck

qSort :: Ord a => [a] -> [a]
qSort []      = []
qSort (p:xs)  = qSort ys ++ (p : qSort zs)
  where
    ys = [ x | x <- xs, x <= p ]
    zs = [ x | x <- xs, x > p ]

-- Algunas propiedades de la ordenación:

-- La ordenación es idempotente
prop_idempot xs  =
  	collect (length xs) $
   	qSort xs == qSort (qSort xs)
   	where 
   		types = (xs :: [Int])

-- La ordenación de la vacía es la vacía
prop_vacia1 xs =
	null xs ==> null (qSort xs)
	where 
		types = (xs :: [Int])

prop_vacia2 xs =
	null $ qSort ([] :: [Int])
	where 
		types = (xs :: [Int])
	
-- La ordenación de la lista unitaria es la misma lista unitaria
prop_unitaria1 xs =
	length xs == 1 ==> xs == qSort xs
	where 
		types = (xs :: [Int])
	
prop_unitaria2 x =
	length xs == 1 ==> xs == qSort xs
	where 
		types = (x :: Int)
		xs = [x]

-- Para listas no vacías, la cabeza de la lista ordenada es el 
-- mínimo elemento de la lista original
prop_min xs  =
	collect (length xs) $
	not (null xs) ==> minimum xs == head (qSort xs)
	where
		types = (xs :: [Int])

-- Para listas no vacías, el último elemento de la lista ordenada
-- es el máximo elemento de la lista original
prop_max xs  =
	collect (length xs) $
	not (null xs) ==> maximum xs == last (qSort xs)
	where
		types = (xs :: [Int])

-- La lista y su ordenación tienen la misma longitud:
prop_longitud xs =
	length xs == length (qSort xs)
	where
		types = (xs :: [Int])

-- Tras ordenar una lista, la lista está en orden
prop_ordenada xs  =
	collect (length xs) $
	ordenada (qSort xs)
	where
		types = (xs :: [Int])
		ordenada xs = and . zipWith (<=) xs $ tail xs

-- La lista ordenada es una permutación de la original
prop_permuta xs  =
	collect (length xs) $
	(qSort xs) 'esPermutacionDe' xs
	where
		types = (xs :: [Int])
		xs 'esPermutacionDe' ys = null (xs // ys) && null (ys // xs)