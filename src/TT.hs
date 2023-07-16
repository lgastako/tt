{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE TypeOperators      #-}

module TT
  ( Template
  , render
  , partial
  , example
  ) where

import Data.Row  ( (.==)
                 , (.+)
                 , (.!)
                 , type (.==)
                 , type (.+)
                 , Rec
                 )
import Data.Text ( Text, pack )

-- | A template is a function from a row type to text.
type Template a = Rec a -> Text

-- | Render the template by passing a complete row-type.
render :: Template a -> Rec a -> Text
render template record = template record

-- | Partially apply a template by passing a partial row-type.
partial :: Template a -> Rec a -> Template a
partial template partialRecord = \record -> template (partialRecord .+ record)

-- | Example template
example :: Template ("name" .== Text .+ "age" .== Int)
example record = pack ("My name is " ++ (record .! #name) ++ " and I am " ++ show (record .! #age) ++ " years old.")
