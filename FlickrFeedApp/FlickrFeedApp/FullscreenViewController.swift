import UIKit
import Kingfisher

class FullscreenViewController: UIViewController {

    var fullPhoto: String?
    var titleText: String?
    var publishedText: String?
    var tagsText: String?
    
    @IBOutlet weak var fullScreenPhoto: UIImageView!
    
    @IBOutlet weak var fspublishedLabel: UILabel!
   
    @IBOutlet weak var fstitleLabel: UILabel!
    
    @IBOutlet weak var fsTagsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fullPhoto = fullPhoto, let url = URL(string: fullPhoto){
                
            fullScreenPhoto.kf.setImage(with: url)
            fstitleLabel.text = titleText
            fspublishedLabel.text = (publishedText?.replacingOccurrences(of: "T", with: " "))?.replacingOccurrences(of: "Z", with: "")
            fsTagsLabel.text = tagsText
            
            
        }
    }
}
