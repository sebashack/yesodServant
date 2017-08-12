{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE OverloadedStrings     #-}

module Servant.API (servantApp) where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics
import Servant

data BlogPost = BlogPost {
    title :: Text
  , keyWords :: [Text]
  , content :: Text
  } deriving (Show, Generic)

instance FromJSON BlogPost
instance ToJSON BlogPost

type ServantAPI =
  "getBlogPost" :> Get '[JSON] BlogPost

getBlogPost :: Handler BlogPost
getBlogPost = return $ BlogPost {
    title = "Experimenting With Yesod and Servant"
  , keyWords = ["servant", "yesod", "subsite"]
  , content = "Here we try how to serve a Servant-API and a Yesod subsite"
  }

apiProxy :: Proxy ServantAPI
apiProxy = Proxy

apiServer :: Server ServantAPI
apiServer = getBlogPost

servantApp :: Application
servantApp = serve apiProxy apiServer
