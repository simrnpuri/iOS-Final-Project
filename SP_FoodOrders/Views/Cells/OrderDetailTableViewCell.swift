//
//  OrderDetailTableViewCell.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 19/04/21.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var itemStackView: UIStackView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var canceledLbl: UILabel!
    
    var object: OrdersDataModel?
    var delegate: OrderViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.innerView.layer.shadowColor = UIColor.black.cgColor
        self.innerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.innerView.layer.shadowRadius = 1
        self.innerView.layer.shadowOpacity = 0.7
        self.innerView.layer.cornerRadius = 4
        
        
        self.cancelBtn.layer.shadowColor = UIColor.black.cgColor
        self.cancelBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.cancelBtn.layer.shadowRadius = 1
        self.cancelBtn.layer.shadowOpacity = 0.5
        self.cancelBtn.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData() {
        if let obj = object {
            for item in obj.items {
                let textLabel = UILabel()
                textLabel.widthAnchor.constraint(equalToConstant: self.itemStackView.frame.width).isActive = true
                textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
                textLabel.text  = "\(item.name ?? "") x \(item.quantity ?? 0)"
                self.itemStackView.addArrangedSubview(textLabel)
            }
            if let date = obj.date {                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM YYYY, hh:mm"

                let strDate = dateFormatter.string(from: date)
                dateLbl.text = strDate
            }
            
            if let can = obj.isCanceled {
                if can {
                    canceledLbl.isHidden = false
                    cancelBtn.isHidden = true
                }else{
                    canceledLbl.isHidden = true
                    if let date = obj.date {
                        let dateNow = Date()
                        let diff = Calendar.current.dateComponents([.minute], from: date, to: dateNow).minute ?? 0
                        if diff < 15 {
                            cancelBtn.isHidden = false
                        }else {
                            cancelBtn.isHidden = true
                        }
                    }
                }
            }
            
            totalAmount.text = obj.total
        }
        
    }
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        if let obj = object, let i = obj.id {
            self.delegate?.cancelOrder(i)
        }
    }
    
}
