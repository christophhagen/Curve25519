# Curve25519
A small framework to use Curve25519 functions in Swift.

## Purpose

I created this framework to provide a Swift API to the Elliptic Curve functions needed for the Signal Protocol. It encapsules the pure C implementation found in [libsignal-protocol-c](https://github.com/signalapp/libsignal-protocol-c).

The framework is used with my [Swift implementation](https://github.com/christophhagen/SignalProtocolSwift) of the [Signal Protocol](https://signal.org/docs/).

## Installation

The framework can be installed by using [Cocoapods](https://cocoapods.org/). Include in your `Podfile`:

```ruby
pod 'Curve25519', :git => 'https://github.com/christophhagen/Curve25519'
```

## Usage

Once the Framework is included in your project, simply

```swift
import Curve25519
```

All features are available through static functions of the `Curve25519` class, for example:

```swift
let agreement = Curve25519.calculateAgreement(privateKey: priv, publicKey: pub)
```

## Features

The framework provides the following features:

### Creating public keys for private keys

Create the corresponding public key for a 32 byte private key.

```swift
func publicKey(for privateKey: Data, basepoint: Data) -> Data?
```

The function will return nil if the inputs have the wrong size.

### Signing and verifying messages

It is possible to sign a message with a private key, and then verify the message with a public key.

```swift
func signature(for message: Data, privateKey: Data, randomData: Data) -> Data?

func verify(signature: Data, for message: Data, publicKey: Data) -> Bool
```

### VRF signature and verification

Additionally it is possible to create and verify VRF (Verifiable Random Function) signatures.

```swift
func vrfSignature(for message: Data, privateKey: Data, randomData: Data) -> Data?

func verify(vrfSignature: Data, for message: Data, publicKey: Data) -> Data?
```

### Key agreement

Create a shared secret between a private and a public key.

```swift
func calculateAgreement(privateKey: Data, publicKey: Data) -> Data?
```

## Directly using C functions

Additionally all C functions are exposed directly for use:

```swift
// Public key creation
func curve25519_donna(_ pub: UnsafeMutablePointer<UInt8>!, 
                      _ priv: UnsafePointer<UInt8>!, 
                      _ base: UnsafePointer<UInt8>!) -> Int32

// Signing
func curve25519_sign(
                  _ signature_out: UnsafeMutablePointer<UInt8>!, 
                  _ curve25519_privkey: UnsafePointer<UInt8>!, 
                  _ msg: UnsafePointer<UInt8>!, 
                  _ msg_len: UInt, 
                  _ random: UnsafePointer<UInt8>!) -> Int32

// Verification
func curve25519_verify(
                  _ signature: UnsafePointer<UInt8>!, 
                  _ curve25519_pubkey: UnsafePointer<UInt8>!, 
                  _ msg: UnsafePointer<UInt8>!, 
                  _ msg_len: UInt) -> Int32

// VRF signature
func generalized_xveddsa_25519_sign(
                  _ signature_out: UnsafeMutablePointer<UInt8>!, 
                  _ x25519_privkey_scalar: UnsafePointer<UInt8>!, 
                  _ msg: UnsafePointer<UInt8>!, 
                  _ msg_len: UInt, 
                  _ random: UnsafePointer<UInt8>!, 
                  _ customization_label: UnsafePointer<UInt8>!, 
                  _ customization_label_len: UInt) -> Int32
                  
// VRF verification
func generalized_xveddsa_25519_verify(
                  _ vrf_out: UnsafeMutablePointer<UInt8>!, 
                  _ signature: UnsafePointer<UInt8>!, 
                  _ x25519_pubkey_bytes: UnsafePointer<UInt8>!, 
                  _ msg: UnsafePointer<UInt8>!, 
                  _ msg_len: UInt, 
                  _ customization_label: UnsafePointer<UInt8>!, 
                  _ customization_label_len: UInt) -> Int32
                  
// Agreement
func curve25519_donna(_ shared: UnsafeMutablePointer<UInt8>!, 
                      _ priv: UnsafePointer<UInt8>!, 
                      _ pub: UnsafePointer<UInt8>!) -> Int32
```

