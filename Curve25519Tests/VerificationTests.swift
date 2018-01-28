//
//  VerificationTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

class VerificationTests: XCTestCase {
    
    /**
     Check that verification works for a correct signature.
     */
    func testVerify() {
        XCTAssertTrue(Curve25519.verify(signature: signature, for: message, publicKey: alicePublic), "Verification failed")
    }

    /**
     Check that verification fails for an incorrect signature.
     */
    func testVerifyInvalidSignature() {
        var invalid = signature
        invalid[10] += 1

        XCTAssertFalse(Curve25519.verify(signature: invalid, for: message, publicKey: alicePublic), "Verification unexpectedly succeeded")
    }

    /**
     Check that verification fails for an incorrect public key.
     */
    func testVerifyInvalidPublicKey() {

        XCTAssertFalse(Curve25519.verify(signature: signature, for: message, publicKey: bobPublic), "Verification unexpectedly succeeded")
    }

    /**
     Check that verification fails for an incorrect message.
     */
    func testVerifyInvalidMessage() {
        var invalid = message
        invalid[10] += 1

        XCTAssertFalse(Curve25519.verify(signature: signature, for: invalid, publicKey: alicePublic), "Verification unexpectedly succeeded")
    }
}
