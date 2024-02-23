//
//  ViewController.swift
//  Ekart
//
//  Created by karthik on 13/02/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var MainPage: UITableView!
    var product = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.MainPage.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "OverViewCell")
        self.MainPage.register(UINib(nibName: "Products", bundle: nil), forCellReuseIdentifier: "Products")
        fetchingData()
    }

    func fetchingData() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            return
        }

        ApiManager.fetchData(from: url) { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                self.product = products
                DispatchQueue.main.async {
                    self.MainPage.reloadData()
                }
            case .failure(let error):
                print("Fetching data error: \(error.localizedDescription)")
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : product.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverViewCell", for: indexPath) as! OverViewCell
            return cell
        } else {
            return productCell(tableView, indexPath: indexPath)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController{
            vc.selectedProductId = product[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func productCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Products", for: indexPath) as! Products
        let cellData = product[indexPath.row]
        cell.ProductTitle.text = cellData.title
        let string = cellData.image
        let url = URL(string: string)
        cell.ProductImg.downloaded(from: url!, contentMode: .scaleToFill)
        cell.ProductImg.layer.cornerRadius = cell.ProductImg.frame.width / 2
        cell.ProductImg.clipsToBounds = true
        return cell
    }
}
