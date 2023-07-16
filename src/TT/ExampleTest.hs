{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE QuasiQuotes        #-}
{-# LANGUAGE TemplateHaskell    #-}

module TT.ExampleTest
  ( exampleTemplate
  , exampleText
  ) where

import Data.Text  ( Text )
import Data.Row   ( type (.==)
                  , type (.+)
                  , (.==)
                  , (.+)
                  , (.!)
                  )

import TT.Types   ( Template )
import TT.XY      ( tt )

exampleTemplate :: Template ("name" .== Text .+ "age" .== Int)
exampleTemplate = [tt|My name is #{name} and I am #{age} years old.|]

exampleText :: Text
exampleText = exampleTemplate
  (  #name .== "John"
  .+ #age  .== 48
  )
