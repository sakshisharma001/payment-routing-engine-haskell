module Main where

import Stage1_Basics
import Stage2_Validation
import Stage3_Routing

main :: IO ()
main = do
  putStrLn "Payment Routing Engine (demo only)"
  putStrLn "----------------------------------"
  case validateTransaction sampleTransaction of
    Left err -> putStrLn ("Validation error: " ++ err)
    Right txn -> do
      putStrLn ("Transaction: " ++ transactionId txn)
      putStrLn ("Amount: " ++ show (amount txn))
      putStrLn ("Method: " ++ show (paymentMethod txn))
      case routeWithFallback txn sampleGateways of
        Left err -> putStrLn ("Routing error: " ++ err)
        Right (preferred : fallbacks) -> do
          putStrLn ("Preferred gateway: " ++ gatewayName preferred)
          if null fallbacks
            then putStrLn "Fallback gateways: none"
            else putStrLn
              ("Fallback order: " ++ show (map gatewayName fallbacks))
        Right [] -> putStrLn "No gateway found."
