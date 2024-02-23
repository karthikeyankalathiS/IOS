

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {

    var data = [TODO]()

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "cellView")
        
        fetcingData(URL: "https://fakestoreapi.com/products"){
            result in self.data = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetcingData(URL url:String,completion:@escaping([TODO]) -> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){data,response,error in
            do{
                let parsingData = try JSONDecoder().decode([TODO].self, from: data!)
                completion(parsingData)
            }
            catch{
                print("parsing Error")
            }
        }
        dataTask.resume()
        
    }

}


extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count",data.count)
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellView", for: indexPath) as! CustomCell
        let cellData = data[indexPath.row]
        let string = (cellData.image)
        print("string :\(string)")
        let url = URL(string: string)
        cell.Img.downloaded(from: url!, contentMode: .scaleToFill)
        cell.Title.text = cellData.title
        print(cellData.title)
        return cell
    }
    
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType,
                  mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}




