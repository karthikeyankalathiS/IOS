//
//  ViewController.swift
//  NotificationVC
//
//  Created by karthik on 08/02/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var customTableView: UITableView!
    var data = [
        ["name": "Karthik", "message": "Hi"],
        ["name": "Keerthi", "message": "How are you"],
        ["name": "Raj", "message": "Whats up"],
        ["name": "Vinoth", "message": "Let's Do it"],
        ["name": "Sridhar", "message": "Yeah!"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.customTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count",data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let rowData = data[indexPath.row]
        cell.NameLbl.text = rowData["name"]
        cell.MsgLbl.text = rowData["message"]
        return cell
    }
}


