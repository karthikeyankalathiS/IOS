//
//  CartVC.swift
//  Ekart
//
//  Created by karthik on 15/02/24.
//

import UIKit

class CartVC: UIViewController {

    @IBAction func Clear(_ sender: Any) {
        CartTabView.badgeValue = nil
    }
    @IBOutlet var CartTabView: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
