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
