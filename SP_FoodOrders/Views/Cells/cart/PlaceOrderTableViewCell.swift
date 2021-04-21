//
//  PlaceOrderTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 18/04/21.
//

import UIKit

class PlaceOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var placeOrderBtn: UIButton!
    var delegate: CartViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.placeOrderBtn.layer.shadowColor = UIColor.black.cgColor
        self.placeOrderBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.placeOrderBtn.layer.shadowRadius = 1
        self.placeOrderBtn.layer.shadowOpacity = 0.5
        self.placeOrderBtn.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func placeOrderBtnTap(_ sender: Any) {
        self.delegate?.placeOrder()
    }
}
