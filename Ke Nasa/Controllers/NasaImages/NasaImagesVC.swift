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
    private var imageVM: ImageViewModel!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.DETAILS_SEGUE {
            let vc = segue.destination as! DetailViewController
            vc.imageVM = self.imageVM
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageVM = self.imagesListVM.imageViewModels[indexPath.row]
        self.performSegue(withIdentifier: AppConstants.DETAILS_SEGUE, sender: nil)
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

//MARK: - Collectionview layout methods
extension NasaImagesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 24)
    }
    
}
