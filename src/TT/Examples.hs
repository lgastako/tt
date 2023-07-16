{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE OverloadedLabels   #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE QuasiQuotes        #-}
{-# LANGUAGE TemplateHaskell    #-}

module TT.Examples
  ( exampleTemplate
  , exampleText
  , exampleText2
  , finishedExample
  , partialExample
  ) where

import Data.Text  ( Text )
import Data.Row   ( type (.==)
                  , type (.+)
                  , (.==)
                  , (.+)
                  , (.!)
                  )

import TT         ( Template
                  , partial
                  , render
                  , tt
                  )

exampleTemplate :: Template ("name" .== Text .+ "age" .== Int)
exampleTemplate = [tt|My name is #{name} and I am #{age} years old.|]

exampleText :: Text
exampleText = render exampleTemplate
  (  #name .== "Rip Van Winkle"
  .+ #age  .== 55
  )

exampleText2 :: Text
exampleText2 = render exampleTemplate
  (  #name .== "Dave"
  .+ #age  .== 25
  )

partialExample :: Template ("age" .== Int)
partialExample = partial exampleTemplate (#name .== "Rip Van Winkle")

finishedExample :: Text
finishedExample = render partialExample (#age .== 55)
