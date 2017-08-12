{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE DeriveGeneric     #-}

module Routes where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics
import Yesod.Core
import Servant.API (servantApp)


data User = User {
    name :: Text
  , nickName :: Text
  , age :: Int
  , description :: Text
  } deriving (Show, Generic)

instance FromJSON User
instance ToJSON User


-- | Yesod App with Servant SubSite

data YesodServantApp = YesodServantApp

mkYesod "YesodServantApp" [parseRoutes|
/ RootR GET
|]
instance Yesod YesodServantApp


-- | Handler

getRootR :: HandlerT YesodServantApp IO Value
getRootR = return . toJSON $ User {
    name = "Sebastian"
  , nickName = "sebashack"
  , age = 25
  , description = "I am a friendly person"
  }
