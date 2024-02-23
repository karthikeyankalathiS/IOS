import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var data = ["Karthik","Raj","Vinoth","Kirthi","Sridhar"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // 	Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }


}

