-- {-# LANGUAGE AllowAmbiguousTypes #-}
-- {-# LANGUAGE DataKinds           #-}
-- {-# LANGUAGE ExplicitNamespaces  #-}
-- {-# LANGUAGE FlexibleContexts    #-}
-- {-# LANGUAGE OverloadedLabels    #-}
-- {-# LANGUAGE OverloadedStrings   #-}
-- {-# LANGUAGE QuasiQuotes         #-}
-- {-# LANGUAGE ScopedTypeVariables #-}
-- {-# LANGUAGE TypeFamilies        #-}
-- {-# LANGUAGE TypeOperators       #-}

module TT.QQ
  ( t
  ) where

import Language.Haskell.TH.Quote  ( QuasiQuoter( QuasiQuoter
                                               , quoteExp
                                               , quotePat
                                               , quoteDec
                                               , quoteType
                                               )
                                  )
import Language.Haskell.TH.Syntax ( Exp
                                  , Q
                                  )

-- import qualified Data.Text as T
-- import Data.Row
-- import Data.Row.Internal ( Unconstrained1 )
-- import Data.String.Interpolate

t :: QuasiQuoter
t = QuasiQuoter
  { quoteExp  = qExp
  , quotePat  = undefined
  , quoteDec  = undefined
  , quoteType = undefined
  }

qExp :: String -> Q Exp
qExp = undefined
