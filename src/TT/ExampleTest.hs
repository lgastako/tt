{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE QuasiQuotes     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

{-# OPTIONS_GHC -Wno-everything #-}

module TT.ExampleTest where

import Data.Row   ( type (.==)
                  , type (.+)
                  , Rec
                  )
import Data.Text  ( Text )

import TT.Types   ( Template )
import TT.Example ( t )

import TT.XY ( tt )

import Data.Row

exampleTemplate :: Rec ("name" .== Text .+ "age" .== Int) -> String
exampleTemplate = [tt|My name is #{name} and I am #{age} years old.|]

text1 :: String
text1 = exampleTemplate
  (  #name .== "John"
  .+ #age  .== 48
  )
