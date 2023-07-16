{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}

{-# OPTIONS_GHC -Wno-all                  #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module TT.Example where

import Language.Haskell.TH
import Language.Haskell.TH.Quote
-- import Language.Haskell.QQ (str)
import Data.String.Interpolate (i, iii)
-- import Data.String.Interpolate.Util (unindent)
import Data.Row
import Data.Text (Text)

type Template a = Rec a -> Text

-- Your new quasi-quoter that inserts the equivalent of `\r ->`.
t :: QuasiQuoter
t = QuasiQuoter { quoteExp = tExp }

tExp :: String -> Q Exp
tExp s = do
    -- Here you transform each #{var} into #{r .! #var}
    let newS = transform s
    -- Then use the `i` quasi-quoter from `text-interpolate` library to 
    -- turn the resulting string into an interpolated function
    -- e <- iii (unindent newS)
    let e :: Exp
        e = undefined
    return e

unindent :: a -> a
unindent = id

-- The transformation function
transform :: String -> String
transform s = undefined
-- Put here your code that transforms "#{var}" into "#{r .! #var}"


-- {-# LANGUAGE DataKinds   #-}
-- {-# LANGUAGE QuasiQuotes #-}

-- module TT.Example where

-- import Data.Row
-- import Data.Text ( Text )

-- type Template a = Rec a -> Text

-- -- example :: Template ("name" .== Text .+ "age" .== Int)
-- -- example = [t|Hello, #{name}! You are #{age} years old.|]


-- example :: Template ("name" .== Text .+ "age" .== Int)
-- example = \r -> [i|Hello, #{name}! You are #{age} years old.|]
--   where
--     name = r .! #name
--     age  = r .! #age
