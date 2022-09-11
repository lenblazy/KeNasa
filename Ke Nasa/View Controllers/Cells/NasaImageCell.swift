//
//  NasaImageCell.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class NasaImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageNasa: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    
    //
    let disposeBag = DisposeBag()
    //
    
     func setUp(with vm: ImageViewModel){
        //
         vm.header.asDriver(onErrorJustReturn: "")
             .drive(self.labelTitle.rx.text)
             .disposed(by: disposeBag)
         //
         vm.subHeader.asDriver(onErrorJustReturn: "")
             .drive(self.labelSubTitle.rx.text)
             .disposed(by: disposeBag)
         //
        
         vm.imageURL.subscribe { url in
             if let safeUrl = url.element {
                 
                     self.imageNasa.loadFrom(urlString: safeUrl)
                 
             }
         }.disposed(by: disposeBag)
         //

    }
    
}
