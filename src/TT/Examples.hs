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
  , templateFromFile
  , textFromFile
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
                  , ttFrom
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

templateFromFile :: Template ("name" .== Text .+ "age" .== Int)
templateFromFile = [ttFrom|test/example.template.txt|]

textFromFile :: Text
textFromFile = render templateFromFile
  (  #name .== "Freddy Fileman"
  .+ #age  .== 5150
  )
