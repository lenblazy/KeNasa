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
    
    private lazy var repository: ImagesRepoProtocol = {
        return ImagesRepo(cacheDataSource: CacheDataSourceImpl(), localDataSource: LocalDataSourceImpl(), remoteDataSource: RemoteDataSourceImpl(webservice: WebService(urlString: AppConstants.urlString)))
    }()
    
    private lazy var viewModel: ImagesListViewModel = {
        return ImagesListViewModel(repository: repository)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        initView()
        initViewModel()
    }
    
    private func initView(){
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionImages.delegate = self
        collectionImages.dataSource = self
    }
    
    private func initViewModel(){
        //Naive binding
        viewModel.showAlertClosure = { [weak self] in
            
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showError(errorMsg: message)
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.loaderView.startAnimating()
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.loaderView.alpha = 0.0
                        self?.collectionImages.alpha = 0.0
                        
                    })
                }else {
                    self?.loaderView.stopAnimating()
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.collectionImages.alpha = 1.0
                        self?.loaderView.alpha = 0.0
                    })
                }
            }
        }
        
        viewModel.reloadCollectionViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionImages.reloadData()
            }
        }
        
        viewModel.performSegue = { [weak self] in
            self?.performSegue(withIdentifier: AppConstants.DETAILS_SEGUE, sender: nil)
        }
        
        viewModel.populateData()
    }
    
    private func showError(errorMsg: String) {
        let alert = UIAlertController(title: "That didn't work", message: errorMsg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Retry", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    //MARK: - Navigate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.DETAILS_SEGUE {
            let vc = segue.destination as! DetailViewController
            vc.imageVM = viewModel.selectedArticle
        }
    }
    
}

extension NasaImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.CELL_NAME, for: indexPath) as! NasaImageCell
        cell.setUp(with: viewModel.getCellViewModel(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.userPressed(at: indexPath)
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
