//
//  CartAmountTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 18/04/21.
//

import UIKit

class CartAmountTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.innerView.layer.shadowColor = UIColor.black.cgColor
        self.innerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.innerView.layer.shadowRadius = 1
        self.innerView.layer.shadowOpacity = 0.7
        self.innerView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateTotal() {
        var totalAmount = 0.0
        var taxAmount = 0.0
        var gtAmount = 0.0
        for kv in BaseDataManager.sharedInstance.cart {
            let item = BaseDataManager.sharedInstance.allMenuDict[kv.key]
            let quantity = kv.value
            totalAmount += Double((item?.price ?? 0) * quantity)
        }
        taxAmount = (totalAmount * 18) / 100
        gtAmount = totalAmount + taxAmount
        total.text = "$ \(totalAmount)"
        tax.text = "$ \(taxAmount)"
        grandTotal.text = "$ \(gtAmount)"
    }
    
}
