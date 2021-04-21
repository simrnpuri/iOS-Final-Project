//
//  OrdersViewController.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

protocol OrderViewProtocol {
    func cancelOrder(_ id: Int)
}

class OrdersViewController: UIViewController {

    @IBOutlet weak var ordersTableView: UITableView!
    var object = [OrdersDataModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ordersTableView.register(UINib(nibName: "OrderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDetailTableViewCell")
        self.ordersTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkData()
    }
    
    func checkData() {
        object = [OrdersDataModel]()
        if let obj = BaseDataManager.sharedInstance.getOrders() {
            object = obj
        }
        self.ordersTableView.reloadData()
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailTableViewCell", for: indexPath) as! OrderDetailTableViewCell
        cell.itemStackView.arrangedSubviews.forEach{
            $0.removeFromSuperview()
        }
        cell.object = object[indexPath.row]
        cell.setData()
        cell.delegate = self
        return cell
    }
    
    
}


extension OrdersViewController: OrderViewProtocol {
    func cancelOrder(_ id: Int) {
        BaseDataManager.sharedInstance.cancelOrder(id)
        self.checkData()
    }
}
