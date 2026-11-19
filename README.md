# Payment Routing Engine (Haskell)

A small simulation of payment-gateway selection. It validates a transaction,
filters gateways that can handle it, and returns a preferred gateway plus an
ordered list of fallbacks. It does not connect to banks, UPI, card networks or
real payment providers, and it does not move money.

## Features

- Transactions, gateways and payment methods modelled with algebraic data
  types and records.
- Validation and routing errors returned as `Either String a`.
- `filter` keeps gateways that are available and support the transaction's
  payment method and amount range.
- `sortBy` ranks eligible gateways by configured success rate (highest first).
- The first gateway in the result is preferred; the rest form the fallback order.

## Project structure

| File | Purpose |
|---|---|
| `Stage1_Basics.hs` | Data types and sample data |
| `Stage2_Validation.hs` | Transaction validation and gateway compatibility |
| `Stage3_Routing.hs` | Eligibility, ranking and fallback ordering |
| `Main.hs` | Command-line demo |

## Run

Requires GHC.

    ghc -Wall Main.hs -o payment-routing-engine
    ./payment-routing-engine

On Windows, run `payment-routing-engine.exe` after compiling.

## Example

The sample transaction is a UPI payment of 1500. Gateway-C is unavailable, and
Gateway-A and Gateway-B are eligible. Gateway-B has the higher success rate, so
it is preferred and Gateway-A is the fallback.

## Scope

The `successRate` values are sample configuration, not measured production
data. The fallback output is a routing order, not a live retry against a real
gateway. A production system would also need provider integrations, timeouts,
idempotency, observability, reconciliation and compliance controls.
