//
//  CartItemTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 18/04/21.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var negative: UIButton!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var positive: UIButton!
    var id: Int = -1
    @IBOutlet weak var total: UILabel!
    var delegate: CartViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData() {
        if id != -1 {
            let cartItem = BaseDataManager.sharedInstance.allMenuDict[id]
            let quantity = BaseDataManager.sharedInstance.cart[id]
            
            title.text = cartItem?.title
            count.text = "\(quantity ?? 0)"
            total.text = "$ \((quantity ?? 0) * (cartItem?.price ?? 0))"
        }
    }
    
    @IBAction func negativeTap(_ sender: Any) {
        self.delegate?.updateItem(id, false)
    }
    
    @IBAction func positiveTap(_ sender: Any) {
        self.delegate?.updateItem(id, true)
    }
    
}
