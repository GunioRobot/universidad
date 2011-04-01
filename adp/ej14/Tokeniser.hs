module Tokeniser ( tokens -- :: (a -> Bool) -> [a] -> [[a]]
				 ) where
				 
import Data.Char (isAlpha, isUpper)

-- TODO	: takeWhile y dropWhile

tokens :: (a -> Bool) -> [a] -> [[a]]
tokens _ [] = []
tokens prop t = tok : tokens prop ts
				where
					-- TODO
					tok = takeWhile prop t
					ts = dropWhile prop t