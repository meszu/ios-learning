//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Mészáros Kristóf on 2022. 05. 03..
//

import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }
    
    /*
     if shouldResetCriteria {
        // Inline validation (✅ or ⚪️)
     } else {
        ...
     }
     */
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage) // ⚪️
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Loss_Of_Focus: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // inline
    }
    
    /*
     if shouldResetCriteria {
        // Inline validation (✅ or ❌)
     } else {
        ...
     }
     */
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage) // ❌
    }
}

class PasswordStatusViewTests_Validate: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let validThreeOfFourPassword = "12345678Aa"
    let invalidTwoOfFourPassword = "12345678A"
    let invalidOneOfFourPassword = "12345678"
    let invalidDoesContainSpacesPassword = "12345678 Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testValidateForTrue() throws {
        XCTAssertTrue(statusView.validate(validPassword))
        XCTAssertTrue(statusView.validate(validThreeOfFourPassword))
    }
    
    func testValidateForFalse() throws {
        XCTAssertFalse(statusView.validate(invalidOneOfFourPassword))
        XCTAssertFalse(statusView.validate(invalidTwoOfFourPassword))
    }
    
    func testValidateForContainingSpace() throws {
        XCTAssertFalse(statusView.validate(invalidDoesContainSpacesPassword))
    }
}
