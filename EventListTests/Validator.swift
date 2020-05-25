//
//  Validator.swift
//  EventListTests
//
//  Created by EDILBERTO DA SILVA RAMOS JUNIOR on 25/05/20.
//  Copyright © 2020 Edilberto Ramos. All rights reserved.
//

import XCTest

class Validator: XCTestCase {

  override func setUp() {
    
  }
  
  override func tearDown() {
    
  }
  
  func testEmailValidator() {
    XCTAssertEqual(testEmail("test@mototalk.com"), true)
    XCTAssertEqual(testEmail("test@mototalk.com.br"), true)
    XCTAssertEqual(testEmail("test1@mototalk.com"), true)
    XCTAssertEqual(testEmail("1test@mototalk.com"), true)
    XCTAssertEqual(testEmail("test-@mototalk.com"), true)
    XCTAssertEqual(testEmail("-test@mototalk.com"), true)
    XCTAssertEqual(testEmail("-@mototalk.com"), true)
    XCTAssertEqual(testEmail("test.m@mototalk.com"), true)
    XCTAssertEqual(testEmail(".test@mototalk.com"), true)
    XCTAssertEqual(testEmail("test.@mototalk.com"), true)
    XCTAssertEqual(testEmail("test@.com"), false)
    XCTAssertEqual(testEmail("testmototalk.com"), false)
    XCTAssertEqual(testEmail("test@mototalk"), false)
    XCTAssertEqual(testEmail("  @  .  "), false)
  }
  
  func testNameValidator() {
    XCTAssertEqual(testName("First"), true)
    XCTAssertEqual(testName(" Last"), true)
    XCTAssertEqual(testName("First Last"), true)
    XCTAssertEqual(testName("1"), false)
    XCTAssertEqual(testName("..."), false)
    XCTAssertEqual(testName("   "), false)
    XCTAssertEqual(testName(""), false)

  }
  
  private func testEmail(_ text: String) -> Bool {
    return text.isEmail
  }
  
  private func testName(_ text: String) -> Bool {
    return text.isName
  }
  
}
