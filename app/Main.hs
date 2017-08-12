module Main where

import Routes
import Yesod.Core (toWaiApp)
import Network.Wai.Handler.Warp (run)


main :: IO ()
main = toWaiApp YesodServantApp >>= run 3000
