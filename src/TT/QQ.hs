{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

{-# OPTIONS_GHC -Wno-everything #-}

module TT.QQ
  ( tt
  , ttFrom
  ) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote

import Data.Char (isAlphaNum)

import Data.String.Interpolate ( i )
import Data.String.Interpolate.Parse ( parseInterpSegments )
import Data.String.Interpolate.Types ( InterpSegment(..)
                                     , Line
                                     , Lines
                                     )

-- TODO errors for the other types.
tt :: QuasiQuoter
tt = QuasiQuoter { quoteExp = mkExp }

ttFrom :: QuasiQuoter
ttFrom = quoteFile tt

mkExp :: String -> Q Exp
mkExp s = lamE [varP $ mkName "r"] (quoteExp i . injectRefs $ s)

injectRefs :: String -> String
injectRefs s = case parseInterpSegments s of
  Left err -> error err
  Right segs -> reassemble segs
  where
    reassemble :: Lines -> String
    reassemble = concatMap f

    f :: Line -> String
    f = concatMap g

    g :: InterpSegment -> String
    g = \case
      Expression s -> "#{r .! #" ++ s ++ "}"
      Verbatim s   -> s
      Spaces n     -> replicate n ' '
      Tabs n       -> replicate n '\t'
