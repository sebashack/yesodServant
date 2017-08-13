{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module Routes where

import Data.Aeson
import Data.Text (Text)
import GHC.Generics
import Yesod.Core
import Yesod.Core.Types (YesodSubRunnerEnv(..))
import Servant.API (servantApp)
import Network.Wai (pathInfo)


data User = User {
    name :: Text
  , nickName :: Text
  , age :: Int
  , description :: Text
  } deriving (Show, Generic)

instance FromJSON User
instance ToJSON User


-- | Servant Subsite
data ServantSub = ServantSub

mkYesodSubData "ServantSub" [parseRoutes|
/ SubRootR GET
|]

instance Yesod site => YesodSubDispatch ServantSub (HandlerT site IO) where
  yesodSubDispatch _ = servantApp

-- | Yesod Main Site with Servant SubSite

newtype YesodServantApp = YesodServantApp {
  getServantSub :: ServantSub
  }

mkYesod "YesodServantApp" [parseRoutes|
/ RootR GET
/servantApi SubsiteR ServantSub getServantSub
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
