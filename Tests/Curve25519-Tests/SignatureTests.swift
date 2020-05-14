//
//  SignatureTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

class SignatureTests: XCTestCase {
    
    /**
     Create a number of random bytes.
     
     - Parameter bytes: The number of random bytes to create
     - Returns: An array of `bytes` length with random numbers
     - Throws: `CryptoError.noRandomBytes` if the sytem can't supply random data
     */
    func random(bytes: Int) -> Data? {
        let random = [UInt8](repeating: 0, count: bytes)
        let result = SecRandomCopyBytes(nil, bytes, UnsafeMutableRawPointer(mutating: random))
        
        guard result == errSecSuccess else {
            return nil
        }
        return Data(random)
    }
    
    
    func testSignAndVerify() {
        var key = random(bytes: Curve25519.keyLength)!
        key[0] &= 248
        key[31] &= 63
        key[31] |= 64
        
        let data = random(bytes: 32)!
        let randomData = random(bytes: Curve25519.randomLength)!
        
        do {
            let signature = try Curve25519.signature(for: data, privateKey: key, randomData: randomData)
            let publicKey = try Curve25519.publicKey(for: key)
            
            let result = Curve25519.verify(signature: signature, for: data, publicKey: publicKey)
            print(signature.count)
            XCTAssertTrue(result)
        } catch {
            XCTFail()
        }
        
    }
    
    /**
     Check if signing a message produces the expected signature for given "random" data
     */
    func testCorrectSignature() {

        let mySignature: Data
        do {
            mySignature = try Curve25519.signature(for: message, privateKey: alicePrivate, randomData: randomData)
        } catch {
            XCTFail("Could not calculate signature: \(error)")
            return
        }

        XCTAssertTrue(mySignature == signature, "Signature not correct")
    }

    /**
     Check if signing a message produces different signature for other "random" data
     */
    func testDifferentRandomData() {
        var invalid = randomData
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.signature(for: message, privateKey: alicePrivate, randomData: invalid)
        } catch {
            XCTFail("Could not calculate signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == signature, "Signature unexpectedly correct")
    }

    /**
     Check if signing a different message produces different signature
     */
    func testDifferentMessage() {
        var invalid = message
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.signature(for: invalid, privateKey: alicePrivate, randomData: randomData)
        } catch {
            XCTFail("Could not calculate signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == signature, "Signature unexpectedly correct")
    }

    /**
     Check if signing with a different key produces different signature
     */
    func testDifferentKey() {
        var invalid = alicePrivate
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.signature(for: message, privateKey: invalid, randomData: randomData)
        } catch {
            XCTFail("Could not calculate signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == signature, "Signature unexpectedly correct")
    }
    
}
