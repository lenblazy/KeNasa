//
//  NasaImagesVC.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation
import UIKit

//MARK: - NasaImagesViewController
class NasaImagesViewController: UIViewController{
   
    //
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var collectionImages: UICollectionView!
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        navigationController?.navigationBar.prefersLargeTitles = true
        //
    }
    
}
