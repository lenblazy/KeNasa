//
//  NasaImageCell.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit

class NasaImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageNasa: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    func setUp(with vm: ImageViewModel){
        print("header \(vm)")
        labelTitle.text = vm.header
        labelSubTitle.text = vm.subHeader
    }
    
}
