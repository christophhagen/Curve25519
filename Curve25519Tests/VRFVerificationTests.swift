//
//  VRFVerificationTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

class VRFVerificationTests: XCTestCase {
    
    /**
     Check that verification works for a correct signature.
     */
    func testVerify() {
        let output: Data
        do {
            output = try Curve25519.verify(vrfSignature: vrfSignature, for: message, publicKey: alicePublic)
        } catch {
            XCTFail("Could not verify signature: \(error)")
            return
        }
        XCTAssertTrue(output == vrfOutput, "Verification failed")
    }

    /**
     Check that verification fails for an incorrect signature.
     */
    func testVerifyInvalidSignature() {
        var invalid = vrfSignature
        invalid[10] += 1

        do {
            _ = try Curve25519.verify(vrfSignature: invalid, for: message, publicKey: alicePublic)
        } catch CurveError.curveError(let val) where val == -1 {
            return
        } catch {
            XCTFail("Invalid error while verifying: \(error)")
        }
        XCTFail("Verification unexpectedly succeeded")
    }

    /**
     Check that verification fails for an incorrect public key.
     */
    func testVerifyInvalidPublicKey() {
        do {
            _ = try Curve25519.verify(vrfSignature: vrfSignature, for: message, publicKey: bobPublic)
        } catch CurveError.curveError(let val) where val == -1 {
            return
        } catch {
            XCTFail("Invalid error while verifying: \(error)")
        }
        XCTFail("Verification unexpectedly succeeded")
    }

    /**
     Check that verification fails for an incorrect message.
     */
    func testVerifyInvalidMessage() {
        var invalid = message
        invalid[10] += 1

        do {
            _ = try Curve25519.verify(vrfSignature: vrfSignature, for: invalid, publicKey: alicePublic)
        } catch CurveError.curveError(let val) where val == -1 {
            return
        } catch {
            XCTFail("Invalid error while verifying: \(error)")
        }
        XCTFail("Verification unexpectedly succeeded")
    }

    /**
     Check that verification fails for an longer message.
     */
    func testVerifyLongerMessage() {
        do {
            _ = try Curve25519.verify(vrfSignature: vrfSignature, for: message + [12], publicKey: alicePublic)
        } catch CurveError.curveError(let val) where val == -1 {
            return
        } catch {
            XCTFail("Invalid error while verifying: \(error)")
        }
        XCTFail("Verification unexpectedly succeeded")
    }
}
