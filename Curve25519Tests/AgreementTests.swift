//
//  AgreementTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

class AgreementTests: XCTestCase {

    /**
     Check if curve agreements are equal when calculated from both sides
     */
    func testEquality() {

        let agreement1: Data
        do {
            agreement1 = try Curve25519.calculateAgreement(privateKey: alicePrivate, publicKey: bobPublic)
        } catch {
            XCTFail("Could not calculate agreement1: \(error)")
            return
        }

        let agreement2: Data
        do {
            agreement2 = try Curve25519.calculateAgreement(privateKey: bobPrivate, publicKey: alicePublic)
        } catch {
            XCTFail("Could not calculate agreement2: \(error)")
            return
        }

        XCTAssert(agreement1 == agreement2, "Agreements not equal")
    }

    /**
     Check if curve agreement is correct
     */
    func testCorrectness() {
        let agreement: Data
        do {
            agreement = try Curve25519.calculateAgreement(privateKey: alicePrivate, publicKey: bobPublic)
        } catch {
            XCTFail("Could not calculate agreement: \(error)")
            return
        }

        XCTAssert(agreement == shared, "Agreement not correct")
    }

    /**
     Check if curve agreement is incorrect for invalid private key
     */
    func testInvalidPrivateKey() {
        var invalid = alicePrivate
        invalid[10] += 1

        let agreement: Data
        do {
            agreement = try Curve25519.calculateAgreement(privateKey: invalid, publicKey: bobPublic)
        } catch {
            XCTFail("Could not calculate agreement: \(error)")
            return
        }

        XCTAssertFalse(agreement == shared, "Agreement unexpectedly correct")
    }

    /**
     Check if curve agreement is incorrect for invalid public key
     */
    func testInvalidPublicKey() {
        var invalid = bobPublic
        invalid[10] += 1

        let agreement: Data
        do {
            agreement = try Curve25519.calculateAgreement(privateKey: alicePrivate, publicKey: invalid)
        } catch {
            XCTFail("Could not calculate agreement: \(error)")
            return
        }

        XCTAssertFalse(agreement == shared, "Agreement unexpectedly correct")
    }
}
