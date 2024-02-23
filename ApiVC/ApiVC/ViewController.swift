//
//  ViewController.swift
//  ApiVC
//
//  Created by karthik on 08/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var data = [TODO]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetcingData(URL: "https://fakestoreapi.com/products"){
            result in self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("Count",data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApiData", for: indexPath) as! DetailsCell
        let datacell = data[indexPath.row]
        let string = (datacell.image)
        let url = URL(string: string)
        cell.img.downloaded(from: url!, contentMode: .scaleToFill)
        cell.txtLabel.text = datacell.title
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



