//
//  KeyTests.swift
//  Curve25519Tests
//
//  Created by User on 28.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
import Curve25519

func bytesConvertToHexstring(byte : [UInt8]) -> String {
    var string = ""

    for val in byte {
        string = string + String(format: "0x%02x, ", val)
    }

    return string
}


class KeyTests: XCTestCase {

    /**
     Check if public keys are correctly calculated.
     */
    func testPublicKey() {

        let publicKey: Data
        do {
            publicKey = try Curve25519.publicKey(for: alicePrivate, basepoint: basepoint)
        } catch {
            XCTFail("Could not calculate public key: \(error)")
            return
        }

        XCTAssert(publicKey == alicePublic, "Public key not correct")
    }
}
