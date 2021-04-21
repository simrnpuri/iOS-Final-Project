//
//  OrdersDataModel.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

class OrdersDataModel: Codable {
    var items = [OrderItemModel]()
    var date: Date? 
    var total: String?
    var id: Int?
    var isCanceled: Bool?
}


class OrderItemModel: Codable {
    var name: String?
    var quantity: Int?
}
