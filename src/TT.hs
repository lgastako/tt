{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ExplicitNamespaces  #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE OverloadedLabels    #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}

module TT
  ( Template
  , render
  , partial
  , example
  , renderedExample
  , partialExample
  , finishedExample
  ) where

import qualified Data.Text as T

import Data.Row  ( (.==)
                 , (.+)
                 , (.!)
                 , type (.\\)
                 , type (.==)
                 , type (.+)
                 , Rec
                 , Row
                 , Forall
                 )
import Data.Row.Internal ( Unconstrained1 )

-- | A template is a function from a row type to text.
type Template a = Rec a -> T.Text

-- | Render the template by passing a complete row-type.
render :: forall a.
          Template a
       -> Rec a
       -> T.Text
render = ($)

-- | Partially apply a template by passing a partial row-type.
partial :: forall a b.
           Forall a Unconstrained1
        => Template (a .+ b)
        -> Rec a
        -> Template b
partial t a = \b -> t (a .+ b)

example :: Template ("name" .== T.Text .+ "age" .== Int)
example r = T.unwords
  [ "My name is"
  , r .! #name
  , "and I am"
  , (T.pack . show) (r .! #age)
  , "years old."
  ]

renderedExample :: T.Text
renderedExample = render example (#name .== "Rip Van Winkle" .+ #age .== 55)

partialExample :: Template ("age" .== Int)
partialExample = partial example (#name .== "Rip Van Winkle")

finishedExample :: T.Text
finishedExample = partialExample (#age .== 55)

-- We'd like this function to handle a case where we have a nested row-type and
-- we pass only part of the outer type containing only part of the inner type, like so:
--   Template ("person" .== ("name" .== T.Text .+ "age" .== Int) .+ "location" .== T.Text)
-- and we call it with:
--   Rec ("person" .== ("name" .== "Rip Van Winkle"))

partialGeneral :: forall a b c.
                  Forall a Unconstrained1
               => Template ((a .+ b) .+ c)
               -> Rec (a .+ b)
               -> Template c
partialGeneral = undefined
