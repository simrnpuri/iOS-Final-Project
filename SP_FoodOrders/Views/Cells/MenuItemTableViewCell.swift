//
//  MenuItemTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var delegate: HomeViewDelegate?
    var model: MenuDataModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.innerView.layer.shadowColor = UIColor.black.cgColor
        self.innerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.innerView.layer.shadowRadius = 1
        self.innerView.layer.shadowOpacity = 0.7
        self.innerView.layer.cornerRadius = 4
        
        
        self.addBtn.layer.shadowColor = UIColor.black.cgColor
        self.addBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.addBtn.layer.shadowRadius = 1
        self.addBtn.layer.shadowOpacity = 0.5
        self.addBtn.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData() {
        if let data = model {
            if let img = data.image {
                self.itemImageView.image = UIImage(named: img)
            }
            self.title.text = data.title
            self.detail.text = data.details
            self.price.text = "$ \(data.price ?? 0)"
        }
    }
    
    @IBAction func addBtnTap(_ sender: Any) {
        self.delegate?.addItemToCart(self.model?.id ?? 0)
    }
}
