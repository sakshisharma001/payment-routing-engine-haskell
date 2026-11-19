module Stage3_Routing
  ( eligibleGateways
  , routeWithFallback
  ) where

import Data.List (sortBy)
import Data.Ord (comparing, Down(..))
import Stage1_Basics
import Stage2_Validation

-- Keep eligible gateways and rank the best success rate first.
eligibleGateways :: Transaction -> [Gateway] -> [Gateway]
eligibleGateways txn gateways =
  sortBy (comparing (Down . successRate))
    (filter (\g -> gatewayAvailable g && supportsTransaction txn g) gateways)

-- The first item is the preferred gateway; remaining items are fallback choices.
routeWithFallback :: Transaction -> [Gateway] -> Either String [Gateway]
routeWithFallback txn gateways = do
  validTxn <- validateTransaction txn
  let candidates = eligibleGateways validTxn gateways
  if null candidates
    then Left "No available gateway supports this transaction."
    else Right candidates
