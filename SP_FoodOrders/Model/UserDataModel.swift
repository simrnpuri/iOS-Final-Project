//
//  UserDataModel.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

class UserDataModel: NSObject {
    var image: String?
    var name: String?
    var address: [UserAddress]?
    
    override init() {
        super.init()
    }
}


class UserAddress: NSObject {
    var streetAddress: String?
    var phone: String?
    
    override init() {
        super.init()
    }
}
