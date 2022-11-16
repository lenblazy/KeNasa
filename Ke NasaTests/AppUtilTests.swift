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

    func testFormatDateTime_givenValidDateFormat_returnsProperDateFormatted(){
        //arrange
        let format = "dd mm, yyyy"
        
        //act
        
        //assert
    }

}
