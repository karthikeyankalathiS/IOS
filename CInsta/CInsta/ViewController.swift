import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!

    var data = [TODO]() 
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(url: "https://fakestoreapi.com/products") { result in
            self.data = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    func fetchData(url: String, completion: @escaping ([TODO]) -> Void) {
        if let url = URL(string: url) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                do {
                    if let data = data {
                        let parsingData = try JSONDecoder().decode([TODO].self, from: data)
                        completion(parsingData)
                    }
                } catch {
                    print("Parsing Error: \(error.localizedDescription)")
                }
            }
            dataTask.resume()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Story", for: indexPath) as! Story
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryContent", for: indexPath) as! StoryContent
        let product = data[indexPath.row]
        let imageURL = URL(string: product.image)
        cell.Img.downloaded(from: imageURL, contentMode: .scaleToFill)
        cell.Profile.text = product.title
        return cell
    }
}

extension UIImageView {
    func downloaded(from url: URL?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = url else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }

    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let link = link, let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
