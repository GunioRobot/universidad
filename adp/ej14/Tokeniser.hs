module Tokeniser 
( tokens -- :: (a -> Bool) -> [a] -> [[a]]
) where

tokens :: (a -> Bool) -> [a] -> [[a]]
tokens _ [] = []
tokens prop t = 
	if null tok 
		then []
		else tok : tokens prop ts
			where
				limpia = dropWhile (not . prop) t
				tok = takeWhile prop limpia
				ts = dropWhile prop limpia