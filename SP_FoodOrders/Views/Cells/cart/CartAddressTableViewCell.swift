//
//  CartAddressTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 18/04/21.
//

import UIKit

class CartAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.innerView.layer.shadowColor = UIColor.black.cgColor
        self.innerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.innerView.layer.shadowRadius = 1
        self.innerView.layer.shadowOpacity = 0.7
        self.innerView.layer.cornerRadius = 8
        
        let add = BaseDataManager.sharedInstance.getUserAddress()
        address.text = add.streetAddress
        phone.text = add.phone
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
