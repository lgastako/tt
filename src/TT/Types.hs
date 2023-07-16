module TT.Types
  ( Template
  ) where

import Data.Text ( Text )

import Data.Row ( Rec )

-- | A template is a function from a row type to text.
type Template a = Rec a -> Text
