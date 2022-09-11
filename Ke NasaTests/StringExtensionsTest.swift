//
//  StringExtensionsTest.swift
//  Ke NasaTests
//
//  Created by LenoxBrown on 11/09/2022.
//

import XCTest
@testable import Ke_Nasa

class StringExtensionsTest: XCTestCase {

    func test_formatDateFromString_returnFormattedString(){
        //2009-12-20T00:00:00Z to equal 20 Mar, 2002
        
        let dateString = "2009-12-20T00:00:00Z"
        let dateStringFromatted = dateString.formatDateFromString()
        XCTAssertEqual("20 Dec, 2009", dateStringFromatted)
    }
    
    
    
}
