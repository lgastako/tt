{-# LANGUAGE DataKinds          #-}
{-# LANGUAGE ExplicitNamespaces #-}
{-# LANGUAGE OverloadedLabels   #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE QuasiQuotes        #-}
{-# LANGUAGE TemplateHaskell    #-}

module TestTT
  ( spec_TT
  , main
    -- exampleTemplate
  -- , exampleText
  -- , exampleText2
  -- , finishedExample
  -- , partialExample
  -- , templateFromFile
  -- , textFromFile
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
                  -- , render
                  , tt
                  , ttFrom
                  )

import Test.Hspec

main :: IO ()
main = hspec spec_TT

spec_TT :: Spec
spec_TT = do
  let exampleTemplate :: Template ("name" .== Text .+ "age" .== Int)
      exampleTemplate = [tt|My name is #{name} and I am #{age} years old.|]

  context "exampleTemplate" $ do
    it "should evaluate to the proper text" $
      exampleTemplate (#name .== "John" .+ #age .== 48)
        `shouldBe` "My name is John and I am 48 years old."
    it "should evaluate to different text with different input" $
      exampleTemplate (#name .== "John" .+ #age .== 48)
        `shouldBe` "My name is John and I am 48 years old."

  context "partialExample" $ do
    let partialTemplate :: Template ("age" .== Int)
        partialTemplate = partial exampleTemplate (#name .== "Bob")

    it "should evaluate to the proper text" $
      partialTemplate (#age .== 90)
        `shouldBe ` "My name is Bob and I am 90 years old."

    it "should evaluate to different text with different input" $
      partialTemplate (#age .== 65)
        `shouldBe` "My name is Bob and I am 65 years old."

    -- TODO
    -- it "should not overwrite the previous partially bound input" $
    --   partialTemplate (#name .== "Dave" .+ #age .== 45)
    --     `shouldBe` "My name is Bob and I am 45 years old."

  context "template from file" $ do
    let templateFromFile :: Template ("name" .== Text .+ "age" .== Int)
        templateFromFile = [ttFrom|test/example.template.txt|]

    it "should evaluate to the proper text" $
      templateFromFile
        (  #name .== "Freddy"
        .+ #age  .== 5150
        ) `shouldBe`
          "Hi, my name is Freddy and I am 5150 years old as of today."
