//
//  ViewController.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

protocol HomeViewDelegate {
    func addItemToCart(_ id: Int)
}

class HomeViewController: UIViewController {

    @IBOutlet weak var itemTableVIew: UITableView!
    var items = [MenuDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Simran's Restaurant"
        self.itemTableVIew.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuItemTableViewCell")
        self.itemTableVIew.dataSource = self
        items = BaseDataManager.sharedInstance.getMenuItems()
        self.itemTableVIew.reloadData()
    }

    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15

        controller.present(alert, animated: true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemTableViewCell", for: indexPath) as! MenuItemTableViewCell
        cell.delegate = self
        cell.model = items[indexPath.row]
        cell.setData()
        return cell
    }
}

extension HomeViewController: HomeViewDelegate {
    func addItemToCart(_ id: Int) {
        self.showToast(controller: self, message: "Added to cart", seconds: 0.5)
        BaseDataManager.sharedInstance.addToCart(id)
    }
}
