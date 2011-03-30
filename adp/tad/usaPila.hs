module UsaPila () where

import Pila
import Data.Char (ord)

-- Tipo transparente: recursión y patrones

listaAPila :: [a] -> Pila a
listaAPila xs = 
	case xs of
		[] -> vacia
		x:xs -> apilar x (listaAPila xs)

pilaALista :: Pila a -> [a]
pilaALista ps =
	if esVacia ps then
		[]
	else
		cima ps : pilaALista (desapilar ps)

profundidad :: Pila a -> Integer
profundidad ps =
	if esVacia ps then
		0
	else
		1 + profundidad (desapilar ps)

ordinales :: Pila Char -> Pila Int
ordinales ps =
	if esVacia ps then
		vacia
	else
		apilar (ord $ cima ps) (ordinales $ desapilar ps)

esta :: Eq a => a -> Pila a -> Bool
esta p ps =
	if esVacia ps then
		False
	else 
		p == cima ps || esta p (desapilar ps)

capicua :: String -> Bool
capicua palabra =
	iguales (listaAPila palabra) (listaAPila $ reverse palabra)

iguales :: Eq a => Pila a -> Pila a -> Bool
iguales ps qs =
	if esVacia ps && esVacia qs then
		True
	else if esVacia ps then
		False
	else if esVacia qs then
		False
	else
		cima ps == cima qs && iguales (desapilar ps) (desapilar qs)

-- Tipo Abstracto:  mapPila y foldPila

listaAPila' :: [a] -> Pila a
listaAPila' = foldr apilar vacia

pilaALista' :: Pila a -> [a]
pilaALista' = foldPila (:) []

profundidad' :: Pila a -> Integer
profundidad' = foldPila (\_ xs-> 1 + xs) 0

ordinales' :: Pila Char -> Pila Int
ordinales' = mapPila ord

esta' :: Eq a => a -> Pila a -> Bool
esta' e = foldPila (\x xs -> e == x  || xs) False

capicua' :: String -> Bool
capicua' palabra = 
	iguales' (listaAPila' palabra) (listaAPila' $ reverse palabra)

iguales' :: Eq a => Pila a -> Pila a -> Bool
iguales' ps qs = 
	pilaALista' ps == pilaALista' qs