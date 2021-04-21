//
//  CartViewController.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

protocol CartViewDelegate {
    func updateItem(_ id: Int, _ increase: Bool)
    func placeOrder()
}

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    var allKeys = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cartTableView.register(UINib(nibName: "CartItemTableViewCell", bundle: nil), forCellReuseIdentifier: "CartItemTableViewCell")
        self.cartTableView.register(UINib(nibName: "CartAmountTableViewCell", bundle: nil), forCellReuseIdentifier: "CartAmountTableViewCell")
        self.cartTableView.register(UINib(nibName: "CartAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "CartAddressTableViewCell")
        self.cartTableView.register(UINib(nibName: "PlaceOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "PlaceOrderTableViewCell")
        
        
        self.cartTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCart()
    }
    
    func updateCart() {
        allKeys = [Int]()
        for key in BaseDataManager.sharedInstance.cart.keys {
            allKeys.append(key)
        }
        if allKeys.count > 0 {
            self.cartTableView.backgroundColor = UIColor.white
        }else {
            self.cartTableView.backgroundColor = UIColor.clear
        }
        self.cartTableView.reloadData()
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


extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return allKeys.count > 0 ? 4 : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allKeys.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemTableViewCell", for: indexPath) as! CartItemTableViewCell
            cell.id = allKeys[indexPath.row]
            cell.updateData()
            cell.delegate = self
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartAmountTableViewCell", for: indexPath) as! CartAmountTableViewCell
            cell.updateTotal()
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartAddressTableViewCell", for: indexPath)
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceOrderTableViewCell", for: indexPath) as! PlaceOrderTableViewCell
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension CartViewController: CartViewDelegate {
    func updateItem(_ id: Int, _ increase: Bool) {
        if increase == true {
            BaseDataManager.sharedInstance.addToCart(id)
        }else {
            BaseDataManager.sharedInstance.removeFromCart(id)
        }
        updateCart()
    }
    
    func placeOrder() {
        BaseDataManager.sharedInstance.placeOrder()
        self.showToast(controller: self, message: "Order Placed", seconds: 1)
        updateCart()
    }
}
