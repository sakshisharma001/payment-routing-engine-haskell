module Stage1_Basics
  ( PaymentMethod(..)
  , Transaction(..)
  , Gateway(..)
  , sampleTransaction
  , sampleGateways
  , availableGateways
  ) where

data PaymentMethod = UPI | Card
  deriving (Eq, Show)

data Transaction = Transaction
  { transactionId :: String
  , amount        :: Double
  , paymentMethod :: PaymentMethod
  } deriving (Eq, Show)

data Gateway = Gateway
  { gatewayName       :: String
  , supportedMethods  :: [PaymentMethod]
  , minimumAmount     :: Double
  , maximumAmount     :: Double
  , successRate       :: Double
  , gatewayAvailable  :: Bool
  } deriving (Eq, Show)

sampleTransaction :: Transaction
sampleTransaction = Transaction "TXN-1001" 1500 UPI

sampleGateways :: [Gateway]
sampleGateways =
  [ Gateway "Gateway-A" [UPI, Card] 1 50000 96 True
  , Gateway "Gateway-B" [UPI]      1 10000 98 True
  , Gateway "Gateway-C" [Card]     1 75000 99 False
  ]

-- filter keeps only gateways that are currently available.
availableGateways :: [Gateway] -> [Gateway]
availableGateways = filter gatewayAvailable
