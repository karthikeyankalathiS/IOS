//
//  OverViewCell.swift
//  Ekart
//
//  Created by karthik on 13/02/24.
//

import UIKit

class OverViewCell: UITableViewCell {
    
    @IBOutlet var ProductTitle: UILabel!
    @IBOutlet var ProductList: UICollectionView!
    
    var product = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ProductList.dataSource = self
        self.ProductList.delegate = self
        self.ProductList.register(UINib(nibName: "ProductIcon", bundle: nil), forCellWithReuseIdentifier: "ProductIcon")
        fetcingData()
    }
    
    func fetcingData() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }

        ApiManager.fetchData(from: url) { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                self.product = products
                DispatchQueue.main.async {
                    self.ProductList.reloadData()
                }
            case .failure(let error):
                print("Fetching data error: \(error.localizedDescription)")
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
    
    extension OverViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print(product.count,"Count")
            return product.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductIcon", for: indexPath) as! ProductIcon
            let datacell = product[indexPath.row]
            let string = (datacell.image)
            let url = URL(string: string)
            cell.Img.downloaded(from: url!, contentMode: .scaleToFill)
            
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
    
