//
//  AppUtilTests.swift
//  Ke NasaTests
//
//  Created by LenoxBrown on 16/11/2022.
//

import XCTest
@testable import Ke_Nasa

class AppUtilTests: XCTestCase {
    
    var sut: AppUtil!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AppUtil()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testFormatDateTime_givenValidDateString_returnsProperDateFormatted(){
        //arrange
        let input = "2002-03-20T00:00:00Z"
        let inputFormatted = "20 Mar, 2002"
        
        //act
        let result = sut.formatDateString(input)
        
        //assert
        XCTAssertEqual(result, inputFormatted, "formatDateString() did not return the proper date formatted")
    }
    
    func testFormatDateTime_givenEmptyDateString_returnEmptyString(){
        let result = sut.formatDateString("")
        
        XCTAssertEqual(result, "", "formatDateString() was supposed to return empty string")
    }

}
