import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var fetchedItems = [Items]()
    var fetchedItem = [Item]()
    var fetchedMedia = [Media]()
//    var sort: SortType = .none
    
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
          super.viewDidLoad()
        CollectionView.dataSource = self
        FetchFlickrPhotos()
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let fullScreen = segue.destination as? FullscreenViewController,
            let indexPath = CollectionView.indexPathsForSelectedItems?.first{
            
            fullScreen.fullPhoto = fetchedItem[indexPath.row].media.m
            fullScreen.titleText = fetchedItem[indexPath.row].title
            fullScreen.publishedText = fetchedItem[indexPath.row].published
        }
    }
    
    
//    @IBAction func SegmentedControlSortChanged(_ sender: UISegmentedControl) {
//
//        self.sort = SortType(rawValue: sender.selectedSegmentIndex) ?? .none
//        print("SegmentedControlValueChanged")
//    }
    
    
    
    
}

extension MainViewController {
    
    //MARK:Fetch JSON and Transforms into data model
    func FetchFlickrPhotos(searchText: String? = nil, completion: (([Items]?) -> Void)? = nil) {
        let url = URL(string: "https://flickr.com/services/feeds/photos_public.gne")
        var parameters = [
            "format" : "json", "nojsoncallback" : "1", "safety_level" : "1"
            ]
        if let searchText = searchText {
            parameters = ["format" : "json", "nojsoncallback" : "1", "safety_level" : "1", "tags" : searchText]

        }

        AF.request(url!, method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) -> Void in
                
                do{
                    let decoder = JSONDecoder()
                    print(response)
                    let model = try decoder.decode(Items.self, from: response.data!)
                    
                    print("result ============================ \n\(model)")
                    
                
                    self.fetchedItems = [model]
                    print(self.fetchedItems.count)
                    
                    self.fetchedItem = model.items
                    print(self.fetchedItem.count)
                    
                    
                    
                } catch {
                    print("ERRRROOOOOORRRRRR ================= \n\(error)")
                }
                
                DispatchQueue.main.async {
                    self.CollectionView.reloadData()
                }
            }
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout{
    
    //MARK: SearchBar
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var reusableView = UICollectionReusableView()

        if kind == UICollectionView.elementKindSectionHeader {
            
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchBar", for: indexPath)

        }
        return reusableView
    }

    //MARK: Count of elements in a row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let w = collectionView.bounds.width/3.0
        let h = collectionView.bounds.height/3.0
        return CGSize(width: w, height: h)
    }
}

extension MainViewController: UICollectionViewDataSource{
    
//    enum SortType: Int{
//        case none
//        case byName
//        case byDate
//    }
    
    //MARK: Count of cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        let number = fetchedItem.count
        print(number)
        
        return number
    }

    //MARK: Data to Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
       
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! CollectionViewCell
        
        let titletext = fetchedItem[indexPath.row].title
        
        let datetext1 = fetchedItem[indexPath.row].published.replacingOccurrences(of: "T", with: " ")
        let datetext = datetext1.replacingOccurrences(of: "Z", with: "")
        let imageview = fetchedItem[indexPath.row].media.m
        
        cell.imageURL = imageview
        
        cell.TitleLabel.text = titletext
        print(titletext)
        cell.dateLabel.text = datetext
        print(datetext)
        return cell
    }


}

extension MainViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.resignFirstResponder()
        FetchFlickrPhotos(searchText: searchBar.text)
        self.CollectionView.reloadData()
        
    }
    
}
