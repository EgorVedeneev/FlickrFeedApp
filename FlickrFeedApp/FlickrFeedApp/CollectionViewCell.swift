//
//  CollectionViewCell.swift
//  FlickrFeedApp
//
//  Created by Egor Vedeneev on 14.03.2021.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var imageURL: String? {
        didSet{
            if let imageURL = imageURL, let url = URL(string: imageURL){
                
                ImageView.kf.setImage(with: url)
            
            } else {
                
                ImageView.image = nil
                ImageView.kf.cancelDownloadTask()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageURL = nil
    }
}
