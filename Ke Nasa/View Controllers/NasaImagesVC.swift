//
//  NasaImagesVC.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import Foundation
import UIKit

class NasaImagesViewController: UIViewController{
    
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var collectionImages: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        navigationController?.navigationBar.prefersLargeTitles = true
        loaderView.isHidden = true
        //
        toggleLoader(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.toggleLoader(false)
            self.errorDialog()
        }
    }
    
    //MARK: - Show error dialog
    private func errorDialog(_ msg: String = "Example error message would go here"){
        let alert = UIAlertController(title: "That didn't work", message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
            // todo send network request
            self.performSegue(withIdentifier: "ToDetailsScreen", sender: nil)
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
            //
        }
        //
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
