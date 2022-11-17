//
//  MockUrlProtocol.swift
//  Ke NasaTests
//
//  Created by LenoxBrown on 16/11/2022.
//

import Foundation
@testable import Ke_Nasa

class MockUrlProtocol: URLProtocol {
    
    static var stubResponseData: Data?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    // mock result here
    override func startLoading() {
        if let error = MockUrlProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }else {
            self.client?.urlProtocol(self, didLoad: MockUrlProtocol.stubResponseData ?? Data())
        }
        
        //needs to be added otherwise not value will be returned
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}
