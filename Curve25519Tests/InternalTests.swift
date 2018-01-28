//
//  Curve25519Tests.swift
//  Curve25519Tests
//
//  Created by User on 27.01.18.
//  Copyright © 2018 User. All rights reserved.
//

import XCTest
@testable import Curve25519

class Curve25519Tests: XCTestCase {

    func testFastSHA512() {
        guard sha512_fast_test(1) == 0 else {
            XCTFail("SHA512 fast test failed")
            return
        }
    }

    func testFastStrict() {
        guard strict_fast_test(1) == 0 else {
            XCTFail("Strict fast test failed")
            return
        }
    }

    func testFastElligator() {
        guard elligator_fast_test(1) == 0 else {
            XCTFail("Elligator fast test failed")
            return
        }
    }

    func testFastCurveSigs() {
        guard curvesigs_fast_test(1) == 0 else {
            XCTFail("CurveSigs fast test failed")
            return
        }
    }

    func testFastXEdDSA() {
        guard xeddsa_fast_test(1) == 0 else {
            XCTFail("XEdDSA fast test failed")
            return
        }
    }

    func testFastGeneralizedXEdDSA() {
        guard generalized_xeddsa_fast_test(1) == 0 else {
            XCTFail("Generalized XEdDSA fast test failed")
            return
        }
    }

    func testFastGeneralizedXVEdDSA() {
        guard generalized_xveddsa_fast_test(1) == 0 else {
            XCTFail("Generalized XVEdDSA fast test failed")
            return
        }
    }

    func testCurveSigs() {
        guard curvesigs_slow_test(1, 10000) == 0 else {
            XCTFail("CurveSigs slow tests failed")
            return
        }
    }

    func testXEdDSASlow() {
        guard xeddsa_slow_test(1, 10000) == 0 else {
            XCTFail("XEdDSA slow tests failed")
            return
        }
    }
    func testXEdDSAtoCurveSigs() {
        guard xeddsa_to_curvesigs_slow_test(1, 10000) == 0 else {
            XCTFail("XEdDSA to CurveSigs slow tests failed")
            return
        }
    }

    func testXVEdDSA() {
        guard generalized_xveddsa_slow_test(1, 10000) == 0 else {
            XCTFail("XVEdDSA slow tests failed")
            return
        }
    }
}
