//
//  NasaImagesVC.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NasaImagesViewController: UIViewController{
    
    //
    let disposeBag = DisposeBag()
    //
    var imagesListVM: ImagesListViewModel!
    //
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var collectionImages: UICollectionView!
    //
    var selectedImage: ImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        collectionImages.delegate = self
        collectionImages.dataSource = self
        //
        navigationController?.navigationBar.prefersLargeTitles = true
        loaderView.isHidden = true
        //
        sendRequest()
    }
    
    private func sendRequest(){
        //
        toggleLoader(true)
        let resource = Resource<MainResponse>(url: URL(string: "https://images-api.nasa.gov/search?q=%22%22")!)
        //
        URLRequest.load(resource: resource).subscribe { imagesResponse in
            //
            let imagesRes = imagesResponse.collection.items
            self.imagesListVM = ImagesListViewModel(imagesRes)
            //
            DispatchQueue.main.async {
                self.toggleLoader(false)
                self.collectionImages.reloadData()
            }
            //
        } onError: { error in
            //
            DispatchQueue.main.async {
                self.toggleLoader(false)
                self.errorDialog(error.localizedDescription)
            }
            //
        }.disposed(by: disposeBag)
        
        //
    }
    
    //MARK: - Show error dialog
    private func errorDialog(_ msg: String = "Request Failed!!! Please Try Again Later..."){
        let alert = UIAlertController(title: "That didn't work", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            //
            alert.dismiss(animated: true, completion: nil)
            self.sendRequest()
            //
        }))
        
        self.present(alert, animated: true,completion: nil)
    }
    
    //MARK: - Shows loader when network request has been performed
    private func toggleLoader(_ toShown: Bool){
        //
        if toShown{
            //
            self.loaderView.isHidden = false
            self.loaderView.startAnimating()
            self.view.isUserInteractionEnabled = false
            //
        }else{
            //
            self.loaderView.isHidden = true
            self.loaderView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            //
        }
        //
    }
    
}


//MARK: - CollectionView datasource and delegate methods
extension NasaImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesListVM == nil ? 0 : self.imagesListVM.imageVms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let vc = self.imagesListVM.imageAt(indexPath.row)
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NasaCell", for: indexPath) as! NasaImageCell
        cell.setUp(with: vc)
        //
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = self.imagesListVM.imageAt(indexPath.row)
        self.performSegue(withIdentifier: "ToDetailsScreen", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? DetailViewController
        dest?.vm = selectedImage
    }
  
    
}

//MARK: - Collectionview layout methods
extension NasaImagesViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 24)
    }
    
}
