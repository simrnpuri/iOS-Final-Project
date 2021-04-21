//
//  ProfileViewController.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = BaseDataManager.sharedInstance.getUserProfile()
        userName.text = model.name
        if let image = model.image{
            userImage.image = UIImage(named: image)
        }
        if let add = model.address {
            address.text = add[0].streetAddress
            phone.text = add[0].phone
        }
        
    }
    
}
