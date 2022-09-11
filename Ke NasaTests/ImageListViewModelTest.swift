//
//  ImageListViewModelTest.swift
//  Ke NasaTests
//
//  Created by LenoxBrown on 11/09/2022.
//

import XCTest
@testable import Ke_Nasa

class ImageListViewModelTest: XCTestCase {

    var imageListVm: ImagesListViewModel!
    var item1: Item!
    var item2: Item!
    
    override func setUp() {
        
        self.item1 = Item(data: [ItemData(title: "ABC", photographer: nil, date_created: "2009-12-20T00:00:00Z", description: "success")], links: [Link(href: "image link")])
        self.item2 = Item(data: [ItemData(title: "DEF", photographer: "photo", date_created: "2020-10-22T00:00:00Z", description: "no description")], links: [Link(href: "image link")])
        //
        self.imageListVm = ImagesListViewModel([self.item1, self.item2])
    }
    
    func test_ImageViewModelAt_ReturnItemAtIndex(){
        let vmToTestItem1 = imageListVm.imageAt(0)
        let vmToTestItem2 = imageListVm.imageAt(1)
        
        let vmFromItem1 = ImageViewModel(self.item1)
        let vmFromItem2 = ImageViewModel(self.item2)
        
        XCTAssertEqual(vmToTestItem1.name, vmFromItem1.name)
        XCTAssertEqual(vmToTestItem2.name, vmFromItem2.name)
        
    }

}
