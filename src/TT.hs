module TT where

import Data.Text

-- | A template is a function from a row type to text.
type Template a = a -> Text

-- | Render the template by passing a complete row-type.
render :: Template a -> a -> Text
render = undefined

-- | Partially apply a template by passing a partial row-type.
partial :: Template a -> a -> Template a
partial = undefined

-- | Example template
myTemplate :: Template ("name" .== Text .+ "age" .== Int)
myTemplate = undefined
