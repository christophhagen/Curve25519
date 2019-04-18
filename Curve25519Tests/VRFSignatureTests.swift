//
//  VRFSignatureTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

class VRFSignatureTests: XCTestCase {
    
    private var vrfRandom: Data {
        return randomData[0..<Curve25519.vrfRandomLength]
    }

    /**
     Check if the signature is correct.
     */
    func testSignature() {

        let mySignature: Data
        do {
            mySignature = try Curve25519.vrfSignature(
                for: message,
                privateKey: alicePrivate,
                randomData: vrfRandom)
        } catch {
            XCTFail("Could not calculate VRF signature: \(error)")
            return
        }

        XCTAssert(mySignature == vrfSignature, "VRF Signature invalid")
    }

    /**
     Check if the signature is incorrect for different message.
     */
    func testInvalidMessage() {
        var invalid = message
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.vrfSignature(
                for: invalid,
                privateKey: alicePrivate,
                randomData: vrfRandom)
        } catch {
            XCTFail("Could not calculate VRF signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == vrfSignature, "VRF Signature unexpectedly correct")
    }

    /**
     Check if the signature is incorrect for different key.
     */
    func testInvalidKey() {
        var invalid = alicePrivate
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.vrfSignature(
                for: message,
                privateKey: invalid,
                randomData: vrfRandom)
        } catch {
            XCTFail("Could not calculate VRF signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == vrfSignature, "VRF Signature unexpectedly correct")
    }

    /**
     Check if the signature is incorrect for different random data.
     */
    func testInvalidRandomData() {
        var invalid = vrfRandom
        invalid[10] += 1

        let mySignature: Data
        do {
            mySignature = try Curve25519.vrfSignature(
                for: message,
                privateKey: alicePrivate,
                randomData: invalid)
        } catch {
            XCTFail("Could not calculate VRF signature: \(error)")
            return
        }

        XCTAssertFalse(mySignature == vrfSignature, "VRF Signature unexpectedly correct")
    }
}

