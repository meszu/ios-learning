//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Mészáros Kristóf on 2022. 05. 04..
//

import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message
    */
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorMessageLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = "12345678†Aa"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorMessageLabel.text!, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }
    
    func testCriteriaNotMet() throws {
        vc.newPasswordText = "12345678a"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorMessageLabel.text!, "Your password must meet the requirements below")
    }
    
    func testValidPassword() throws {
        vc.newPasswordText = "12345678Aa!"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.newPasswordTextField.errorMessageLabel.text!, "")
    }
    
}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorMessageLabel.text!, "Enter your password.")
    }
    
    func testPasswordMatch() throws {
        vc.confirmPasswordText = validPassword
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorMessageLabel.text!, "")
    }
    
    func testPasswordNoMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorMessageLabel.text!, "Passwords do not match.")
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success") // Optional
    }
    
    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertNil(vc.alert)
    }
}
