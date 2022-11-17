//
//  WebServiceTests.swift
//  Ke NasaTests
//
//  Created by LenoxBrown on 16/11/2022.
//

import XCTest
@testable import Ke_Nasa

class WebServiceTests: XCTestCase {
    
    var sut: WebService!
    var urlSession: URLSession!

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        urlSession = URLSession(configuration: config)
        
        sut = WebService(urlString: AppConstants.urlString, urlSession: urlSession)
    }

    override func tearDownWithError() throws {
        sut = nil
        urlSession = nil
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }
    
    func testWebService_whenGivenSuccessfulResponse_ReturnsNasaData() {
        // arrange
        let successfulResponseJson = "{\"collection\":{\"version\":\"1.0\",\"href\":\"http://images-api.nasa.gov/search?q=%22%22\",\"items\":[{\"href\":\"https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/collection.json\",\"data\":[{\"center\":\"ARC\",\"title\":\"ARC-2002-ACD02-0056-22\",\"photographer\":\"TomTrower\",\"keywords\":[\"VSHAIP\",\"V-22\"],\"nasa_id\":\"ARC-2002-ACD02-0056-22\",\"media_type\":\"image\",\"date_created\":\"2002-03-20T00:00:00Z\",\"description\":\"VSHAIPtestin7x10ft#1W.T.(multiplemodelconfigruations)V-22helicoptershipboardaerodynamicinteractionprogram:L-RseatedAllenWadcox,(standind)MarkBetzina,seatedinfrontofcomputerGloriaYamauchi,inbackgroundKurtLong.\"}],\"links\":[{\"href\":\"https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/ARC-2002-ACD02-0056-22~thumb.jpg\",\"rel\":\"preview\",\"render\":\"image\"}]}],\"metadata\":{\"total_hits\":6855},\"links\":[{\"rel\":\"next\",\"prompt\":\"Next\",\"href\":\"http://images-api.nasa.gov/search?q=%22%22&page=2\"}]}}"
        
        MockUrlProtocol.stubResponseData = successfulResponseJson.data(using: .utf8)
        
        //act
        let expectation = self.expectation(description: "Web service call response not receive")
        
        sut.fetchNasaImages { mainResponse, error in
            //assert
            XCTAssertNotNil(mainResponse, "Main response was found to be nil")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testWebService_whenGivenInvalidJson_ReturnFailureResponse(){
        let invalidJson = "{\"browsers\":{\"firefox\":{\"name\":\"Firefox\",\"pref_url\":\"about:config\",\"releases\":{\"1\":{\"release_date\":\"2004-11-09\",\"status\":\"retired\",\"engine\":\"Gecko\",\"engine_version\":\"1.7\"}}}}}"
        
        MockUrlProtocol.stubResponseData = invalidJson.data(using: .utf8)
        let expectation = self.expectation(description: "Invalid Json response expectation")
        
        sut.fetchNasaImages { response, error in
            XCTAssertNil(response, "Response was supposed to be nil but returned a value")
            XCTAssertEqual(error, ApiError.invalidResponseModel, "Was expecting an error of type ApiError.invalidResponseModel but did not get one")
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }
    
    func testWebService_whenGivenEmptyUrlString_ReturnFailureWithMessage(){
        sut = WebService(urlString: "", urlSession: urlSession)
        
        let expectation = self.expectation(description: "Expectation to wait for failure message after passing empty url")
        
        sut.fetchNasaImages { response, error in
            XCTAssertEqual(error, ApiError.emptyUrlString, "Error received was supposed to be ApiError.emptyUrlString but did not happen")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1)
    }
    
    func testWebService_whenUrlrequestFails_returnErrorWithdescription(){
        let expectation = self.expectation(description: "Expectation to wait for url request error with error description message")
        let errorMsg = "A localized description of an error"
//        MockUrlProtocol.error = ApiError.requestFailed(description: errorMsg)
        MockUrlProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])
        
        sut.fetchNasaImages { response, error in
            XCTAssertEqual(error, ApiError.requestFailed(description: errorMsg), "Error received was supposed to be ApiError.requestFailed with description")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }

}
