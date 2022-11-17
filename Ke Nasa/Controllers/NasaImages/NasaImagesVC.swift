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
    
    private var imagesListVM: ImagesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        navigationController?.navigationBar.prefersLargeTitles = true
        //
        let webService = WebService(urlString: AppConstants.urlString)
        imagesListVM = ImagesListViewModel(webservice: webService)
        //
        collectionImages.delegate = self
        collectionImages.dataSource = self
        //
        imagesListVM.ui = self
    }
    
}

extension NasaImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesListVM.imageViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CELL_NAME, for: indexPath) as! NasaImageCell
        
        let vm = self.imagesListVM.imageViewModels[indexPath.row]
        cell.setUp(with: vm)
        
        return cell
    }
    
}

extension NasaImagesViewController: ImageListUI {
    
    func showLoader() {
        self.loaderView.isHidden = false
    }
    
    func hideLoader() {
        self.loaderView.isHidden = true
    }
    
    func showError(errorMsg: String) {
        let alert = UIAlertController(title: "That didn't work", message: errorMsg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func refreshList() {
        self.collectionImages.reloadData()
    }
    
}
