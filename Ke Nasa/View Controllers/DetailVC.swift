//
//  DetailViewController.swift
//  Ke Nasa
//
//  Created by LenoxBrown on 11/09/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageHeadline: UIImageView!
    
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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.57
        labelContent.attributedText = NSMutableAttributedString(string: "VSHAIP test in 7x10ft#1 W.T. (multiple model configruations) V-22 helicopter shipboard aerodynamic interaction program: L-R seated Allen Wadcox, (standind) Mark Betzina, seated in front of computer Gloria Yamauchi, in background Kurt Long.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        //
    }
    
}
