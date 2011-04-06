--------------------------------------------
-- TAD Bolsa (implementación logarítmica) --
--------------------------------------------

module BolsaLog
( Bolsa
, vacia         -- Ord a => Bolsa a
, insertar      -- Ord a => a -> Bolsa a -> Bolsa a
, listaABolsa   -- Ord a => [a] -> Bolsa a
, bolsaALista   -- Ord a => Bolsa a -> [(a, Int)]
, tamaño        -- Ord a => Bolsa a -> Int
, apariciones   -- Ord a => a -> Bolsa a -> Int
, todos         -- Ord a => ( a-> Bool) -> Bolsa a -> Bool
) where

import Test.QuickCheck
import Data.Char (isUpper)
import Data.List (sort)

data Bolsa a = Vacía
             | Nodo (Bolsa a) a Int (Bolsa a)

-- constructores

vacia :: Ord a => Bolsa a
vacia = Vacía

insertar :: Ord a => a -> Bolsa a -> Bolsa a
insertar e Vacía = Nodo Vacía e 1 Vacía
insertar e (Nodo izq x n der)
	| e == x = Nodo izq x (n + 1) der
	| e < x = Nodo (insertar e izq) x n der
	| otherwise = Nodo izq x n (insertar e der)

-- otras operaciones

listaABolsa :: Ord a => [a] -> Bolsa a
listaABolsa [] = Vacía
listaABolsa (x : xs) = insertar x (listaABolsa xs)

bolsaALista :: Ord a => Bolsa a -> [(a, Int)]
bolsaALista Vacía = []
bolsaALista (Nodo izq x n der) = bolsaALista izq ++ (x, n) : bolsaALista der

bolsaALista' :: Ord a => Bolsa a -> [(a, Int)]
bolsaALista' = foldBolsa f []
				where
					f = (\izq x n der -> izq ++ (x, n) : der)

tamaño :: Ord a => Bolsa a -> Int
tamaño Vacía = 0
tamaño (Nodo izq _ _ der) = 1 + tamaño izq + tamaño der

tamaño' :: Ord a => Bolsa a -> Int
tamaño' = foldBolsa f 0
			where
				f = (\izq _ _ der -> 1 + izq + der)

apariciones :: Ord a => a -> Bolsa a -> Int
apariciones e Vacía = 0
apariciones e (Nodo izq x n der)
	| e == x = n
	| e < x = apariciones e izq
	| otherwise = apariciones e der
	
apariciones' :: Ord a => a -> Bolsa a -> Int
apariciones' e = foldBolsa f 0
					where
						f = (\izq x n der -> if (e == x) then n + izq + der else izq + der)
	
todos :: Ord a => (a-> Bool) -> Bolsa a -> Bool
todos _ Vacía = True
todos prop (Nodo izq x _ der) = prop x && todos prop izq && todos prop der

todos' :: Ord a => (a-> Bool) -> Bolsa a -> Bool
todos' prop = foldBolsa f True
				where
					f = (\izq x _ der -> prop x && izq && der)

-- TODO: definir los fold y reescribir las funciones con éstos
foldBolsa :: (b -> a -> Int -> b -> b) -> b -> Bolsa a -> b
foldBolsa _ e Vacía = e
foldBolsa f e (Nodo izq x n der) = f (foldBolsa f e izq) x n (foldBolsa f e der)

-- foldBolsaAc :: (a -> Int -> b -> b) -> b -> Bolsa a -> b


-- TODO: Pruebas QuickCheck

-- tamaño funciona correctamente

-- prop_tamaño xs =



-- apariciones funciona correctamente

-- prop_apariciones xs =



-- las listas devueltas por bolsaALista están ordenadas

-- prop_listaOrdenada xs  =



-- si se expande una bolsa en una lista con repeticiones [a],
-- se obtiene una ordenación de la lista original

-- prop_expande xs =



-- la representación interna de las bolsas está ordenada

-- prop_ordenInterno xs  =

-- las implementaciones alternativas son iguales...
