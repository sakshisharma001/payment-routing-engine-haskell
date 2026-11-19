module Stage2_Validation
  ( validateTransaction
  , supportsTransaction
  ) where

import Stage1_Basics

-- Either carries a clear error (Left) or the valid transaction (Right).
validateTransaction :: Transaction -> Either String Transaction
validateTransaction txn
  | amount txn <= 0 = Left "Transaction amount must be greater than zero."
  | null (transactionId txn) = Left "Transaction ID cannot be empty."
  | otherwise = Right txn

supportsTransaction :: Transaction -> Gateway -> Bool
supportsTransaction txn gateway =
  paymentMethod txn `elem` supportedMethods gateway
    && amount txn >= minimumAmount gateway
    && amount txn <= maximumAmount gateway
