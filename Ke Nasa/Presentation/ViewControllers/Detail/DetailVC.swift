//
//  DetailViewController.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    //
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageHeadline: UIImageView!
    //
    var imageVM: ImageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        navigationController?.navigationBar.prefersLargeTitles = false
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        labelContent.text = imageVM.content
        labelTitle.text = imageVM.header
        labelSubtitle.text = imageVM.subHeader
        imageHeadline.loadFrom(urlString: imageVM.imgLink)
    }
    
}
