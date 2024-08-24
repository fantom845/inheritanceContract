# Inheritance Smart Contract Documentation

## Overview

This smart contract implements an inheritance mechanism for Ethereum (ETH) assets. It allows an owner to manage funds, with a failsafe that transfers control to a designated heir if the owner becomes inactive.

## Key Features

- Owner can withdraw ETH
- Designated heir can claim ownership after a period of owner inactivity
- Ownership transfer mechanism
- Inheritance period reset functionality

## Contract Details

### State Variables

- `owner`: Address of the current contract owner
- `heir`: Address of the designated heir
- `lastWithdrawalTime`: Timestamp of the last withdrawal or reset action
- `INHERITANCE_PERIOD`: Constant set to 30 days (2,592,000 seconds)

### Events

- `OwnershipTransferred`: Logs change of ownership
- `HeirChanged`: Logs change of designated heir
- `Withdrawal`: Logs withdrawals from the contract

### Functions

#### Constructor

- Initializes the contract with the deployer as owner and a specified heir

#### withdraw

- Allows owner to withdraw ETH
- Resets the inheritance period

#### resetInheritancePeriod

- Allows owner to reset the inheritance period without withdrawing

#### changeHeir

- Allows owner to designate a new heir

#### claimOwnership

- Allows heir to claim ownership after the inheritance period has passed

#### getContractBalance

- Returns the current ETH balance of the contract

### Modifiers

- `onlyOwner`: Restricts function access to the current owner
- `onlyHeir`: Restricts function access to the designated heir

### Fallback Function

- `receive()`: Allows the contract to receive ETH

## Usage

1. Deploy the contract, specifying the initial heir
2. Owner can withdraw funds or reset the inheritance period
3. If owner is inactive for 30 days, heir can claim ownership
4. New owner can designate a new heir

## Security Considerations

- Ensure proper key management for owner and heir addresses
- Be aware that anyone can view the contract state on the blockchain
- The contract doesn't include a way to reclaim ownership once transferred

