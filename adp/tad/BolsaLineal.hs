---------------------------------------
-- TAD Bolsa (implementación lineal) --
---------------------------------------

module BolsaLineal 
( Bolsa
, vacia         -- Ord a => Bolsa a
, insertar      -- Ord a => a -> Bolsa a -> Bolsa a
, listaABolsa   -- Ord a => [a] -> Bolsa a
, bolsaALista   -- Ord a => Bolsa a -> [(a, Int)]
, tamaño        -- Ord a => Bolsa a -> Int
, apariciones   -- Ord a => a -> Bolsa a -> Int
, todos         -- Ord a => (a-> Bool) -> Bolsa a -> Bool
) where

import Test.QuickCheck
import Data.Char (isUpper)
import Data.List (sort)

type Bolsa a = [(a, Int)] -- mantenemos la lista ordenada

-- constructores

vacia :: Ord a => Bolsa a
vacia = []

insertar :: Ord a => a -> Bolsa a -> Bolsa a
insertar e [] = [(e, 1)]
insertar e ((x, n) : bs)
	| e == x = ((x, n + 1) : bs)
	| e < x = (e, 1) : (x, n) : bs
	| otherwise = (x, n) : insertar e bs

-- otras operaciones

listaABolsa :: Ord a => [a] -> Bolsa a
listaABolsa [] = vacia
listaABolsa (x : xs) = insertar x (listaABolsa xs)

bolsaALista :: Ord a => Bolsa a -> [(a, Int)]
bolsaALista [] = []
bolsaALista ((x, n) : bs) = (x, n) : bolsaALista bs

tamaño :: Ord a => Bolsa a -> Int
tamaño [] = 0
tamaño (_ : bs) = 1 + tamaño bs

apariciones :: Ord a => a -> Bolsa a -> Int
apariciones _ [] = 0
apariciones e ((x, n) : bs)
	| e == x = n
	| e > x = apariciones e bs
	| otherwise = 0
	
todos :: Ord a => (a-> Bool) -> Bolsa a -> Bool
todos _ [] = True
todos propiedad ((x, n) : bs) = propiedad x && todos propiedad ((x, n) : bs)

-- TODO: Pruebas QuickCheck

-- tamaño funciona correctamente
prop_tamaño xs = 
	-- collect (tamaño xs) $
	tamaño xs == length ls
	where
		ls = bolsaALista xs

-- apariciones funciona correctamente
{- TODO
prop_apariciones xs =
	apariciones e xs == n
	where
		ls = bolsaALista xs
		n = 
-}

-- las listas devueltas por bolsaALista están ordenadas
{-
prop_listaOrdenada xs  =
	-- collect (tamaño xs) $
	ordenada ls
	where
		ls = bolsaALista xs
		ordenada = 
			-- and . zipWith (\(x, _) (y, _) -> x <= y) ls $ tail ls
-}

-- si se expande una bolsa en una lista con repeticiones [a],
-- se obtiene una ordenación de la lista original

-- prop_expande xs =
	-- collect (tamaño xs) $
-- las representación interna de las bolsas está ordenada

-- prop_ordenInterno xs  =
	-- collect (tamaño xs) $
	