//
//  FullscreenViewController.swift
//  FlickrFeedApp
//
//  Created by Egor Vedeneev on 14.03.2021.
//

import UIKit
import Kingfisher

class FullscreenViewController: UIViewController {

    var fullPhoto: String?
    var titleText: String?
    var publishedText: String?
    
    @IBOutlet weak var fullScreenPhoto: UIImageView!
    
    @IBOutlet weak var fspublishedLabel: UILabel!
   
    @IBOutlet weak var fstitleLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fullPhoto = fullPhoto, let url = URL(string: fullPhoto){
                
            fullScreenPhoto.kf.setImage(with: url)
            fstitleLabel.text = titleText
            fspublishedLabel.text = publishedText
            
        }
    }
}
