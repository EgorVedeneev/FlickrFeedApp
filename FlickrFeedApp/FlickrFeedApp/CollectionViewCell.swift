import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    public var cellImage: UIImage?

    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var imageURL: String? {
        didSet{
            if let imageURL = imageURL, let url = URL(string: imageURL){
                
                ImageView.kf.setImage(with: url)
                cellImage = ImageView.image
            
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
