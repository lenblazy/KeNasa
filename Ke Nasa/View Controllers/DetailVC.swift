//
//  DetailViewController.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    //
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageHeadline: UIImageView!
    //
    var vm: ImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        navigationController?.navigationBar.prefersLargeTitles = false
        //
        setUp()
        //
    }
    
    private func setUp(){
        //
        self.vm?.header.asDriver(onErrorJustReturn: "")
             .drive(self.labelTitle.rx.text)
             .disposed(by: disposeBag)
         //
        self.vm?.subHeader.asDriver(onErrorJustReturn: "")
             .drive(self.labelSubtitle.rx.text)
             .disposed(by: disposeBag)
         //
        self.vm?.imageURL.subscribe { url in
             if let safeUrl = url.element {
                 self.imageHeadline.loadFrom(urlString: safeUrl)
             }
         }.disposed(by: disposeBag)
         //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.57
        //
        self.vm?.desc.subscribe { desc in
            if let safeDesc = desc.element{
                self.labelContent.attributedText = NSMutableAttributedString(string: safeDesc, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            }
        }.disposed(by: disposeBag)
        //
    }
    
}
