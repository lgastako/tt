{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}

module TT
  ( Template
  , render
  , tt
  , partial
  ) where

import Data.Row          ( (.+)
                         , type (.+)
                         , Rec
                         , Forall
                         )
import Data.Row.Internal ( Unconstrained1 )
import Data.Text         ( Text )

import TT.QQ             ( tt )
import TT.Types          ( Template )

-- TODO File version(s)

-- | Render the template by passing a complete row-type.
render :: forall a.
          Template a
       -> Rec a
       -> Text
render = ($)

-- | Partially apply a template by passing a partial row-type.
partial :: forall a b.
           Forall a Unconstrained1
           -- Forall (a .+ b) Unconstrained1
        => Template (a .+ b)
        -> Rec a
        -> Template b
partial t a = \b -> t (a .+ b)
