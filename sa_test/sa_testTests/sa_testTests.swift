//
//  sa_testTests.swift
//  sa_testTests
//
//  Created by Admin on 19/07/24.
//

import XCTest
@testable import sa_test

final class sa_testTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testRegisterSuccess() {
        let expectation = self.expectation(description: "Register Success")
        
        NetworkManager.shared.register(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Registration failed")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login Success")
        
        NetworkManager.shared.login(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case .failure:
                XCTFail("Login failed")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testStartInspectionSuccess() {
        let expectation = self.expectation(description: "Start Inspection Success")
        
        NetworkManager.shared.startInspection { result in
            switch result {
            case .success(let inspection):
                XCTAssertNotNil(inspection)
            case .failure:
                XCTFail("Start inspection failed")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
