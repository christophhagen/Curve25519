import XCTest

import Curve25519_NewTests

var tests = [XCTestCaseEntry]()
tests += AgreementTests.allTests()
tests += KeyTests.allTests()
tests += SignatureTests.allTests()
tests += VerificationTests.allTests()
tests += VRFSignatureTests.allTests()
tests += VRFVerificationTests.allTests()

XCTMain(tests)
