import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var product: Product?
    var selectedProductId: Int?

    @IBOutlet var TableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.TableView.register(UINib(nibName: "MainDetails", bundle: nil), forCellReuseIdentifier: "MainDetails")
        self.TableView.register(UINib(nibName: "Details", bundle: nil), forCellReuseIdentifier: "Details")

        guard selectedProductId != nil else {
            return
        }

        fetchProductDetails()

        self.TableView.dataSource = self
        self.TableView.delegate = self
    }

    // Replace the current fetchProductDetails function with this one
    func fetchProductDetails() {
        guard let selectedProductId = selectedProductId else {
            return
        }

        let urlString = "https://fakestoreapi.com/products/\(selectedProductId)"
        guard let url = URL(string: urlString) else {
            return
        }

        ApiManager.fetchData(from: url) { (result: Result<Product, Error>) in
            switch result {
            case .success(let product):
                self.product = product
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            case .failure(let error):
                print("Fetching product details error: \(error.localizedDescription)")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0     {
            if let product = self.product {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MainDetails", for: indexPath) as! MainDetails
                let string = product.image
                let url = URL(string: string)
                cell.Img.downloaded(from: url!, contentMode: .scaleToFill)
                cell.Title.text = product.title
                cell.Price.text = "$\(String(product.price))"
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            return productDetails(tableView, indexPath: indexPath)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func productDetails(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let product = self.product {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath) as! Details
            cell.Category.text = product.category
            cell.Description.text = product.description
            cell.configureRatingStack(with: product.rating)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
