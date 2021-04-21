//
//  BaseDataManager.swift
//  SP_FoodOrders
//
//  Created by Simran Puri on 17/04/21.
//

import UIKit

class BaseDataManager: NSObject {
    static let sharedInstance = BaseDataManager()
    private let ud = UserDefaults.standard
    var cart = [Int: Int]()
    var allMenuDict = [Int: MenuDataModel] ()
    private override init() {
        super.init()
        prepareData()
    }
    
    func addToCart(_ id: Int) {
        let item = cart[id]
        if let count = item {
            cart[id] = count + 1
        }else {
            cart[id] = 1
        }
        saveCart()
    }
    
    func removeFromCart(_ id: Int) {
        let item = cart[id]
        if let count = item {
            if count > 0 {
                cart[id] = count - 1
            }
            if cart[id] == 0{
                cart.removeValue(forKey: id)
            }
        }
        saveCart()
    }
    
    func prepareData() {
        allMenuDict[1] = getHashBrowns()
        allMenuDict[2] = getFriedChicken()
        allMenuDict[6] = getHamburger()
        allMenuDict[5] = getSandwich()
        allMenuDict[4] = getColdDrink()
        allMenuDict[3] = getPizza()
    }
    
    func saveCart() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: cart, requiringSecureCoding: false)
            ud.set(encodedData, forKey: "cart")
            ud.synchronize()
        }catch {}

        
    }
    
    func getCart() -> [Int: Int]? {
        if let localCart = ud.value(forKey: "cart") as? Data {
            do {
            let item = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(localCart) as? [Int: Int]
                return item
            }catch {}
        }
        return nil
    }
    
    func clearCart() {
        cart = [Int: Int]()
        saveCart()
    }
    
    func getMenuItems() -> [MenuDataModel] {
        return [getHashBrowns(), getFriedChicken(), getHamburger(), getSandwich(), getColdDrink(), getPizza()]
    }
    
    func getHashBrowns() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Hash Browns"
        model.details = "Hash browns potato patty baked"
        model.price = 5
        model.id = 1
        model.image = "hashbrowns"
        return model
    }
    
    func getFriedChicken() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Fried Chicken"
        model.details = "Deep Fried Chicken with Tangy Sauce"
        model.price = 15
        model.id = 2
        model.image = "friedChicken"
        return model
    }
    
    func getPizza() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Pizza"
        model.details = "Pepperoni pizza baked in wood oven"
        model.price = 15
        model.id = 3
        model.image = "pizza"
        return model
    }
    
    func getColdDrink() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Cold Drink"
        model.details = "Carbonated canned drink"
        model.price = 8
        model.id = 4
        model.image = "coldDrink"
        return model
    }
    
    func getSandwich() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Cheese Sandwich"
        model.details = "Triple cheese grilled sandwich"
        model.price = 10
        model.id = 5
        model.image = "sandwich"
        return model
    }
    
    func getHamburger() -> MenuDataModel {
        let model = MenuDataModel()
        model.title = "Hamburger"
        model.details = "Thick Patty hamburger with fries on side"
        model.price = 15
        model.id = 6
        model.image = "hamburger"
        return model
    }
    
    func getUserProfile() -> UserDataModel {
        let model = UserDataModel()
        model.image = "userImg"
        model.name = "John Wick"
        model.address = [getUserAddress()]
        return model
    }
    
    func getUserAddress() -> UserAddress {
        let model = UserAddress()
        model.streetAddress = "111, ABC Street, Sudbury, CA"
        model.phone = "123-456-7890"
        return model
    }
    
    func placeOrder() {
        var totalAmount = 0.0
        var taxAmount = 0.0
        var gtAmount = 0.0
        let order = OrdersDataModel()
        for kv in self.cart {
            let item = BaseDataManager.sharedInstance.allMenuDict[kv.key]
            let quantity = kv.value
            totalAmount += Double((item?.price ?? 0) * quantity)
            let orderItem = OrderItemModel()
            orderItem.name = item?.title
            orderItem.quantity = quantity
            order.items.append(orderItem)
        }
        taxAmount = (totalAmount * 18) / 100
        gtAmount = totalAmount + taxAmount
        order.total = "$ \(gtAmount)"
        order.date = Date()
        order.isCanceled = false
        
        if let orders = getOrders() {
            var localOrders = orders
            let lastOrder = localOrders[0]
            order.id = (lastOrder.id ?? 0) + 1
            localOrders.insert(order, at: 0)
            saveOrder(localOrders)
        }else {
            order.id = 1
            let orders = [order]
            saveOrder(orders)
        }
        clearCart()
    }
    
    func saveOrder(_ orders: [OrdersDataModel]) {
        do {
            let endcoder = JSONEncoder()
            let encodedData = try endcoder.encode(orders)
            ud.set(encodedData, forKey: "orders")
            ud.synchronize()
        }catch {}
    }
    
    func getOrders() -> [OrdersDataModel]? {
        if let localOrders = ud.value(forKey: "orders") as? Data {
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([OrdersDataModel].self, from: localOrders)
                return data
            }catch {}
        }
        return nil
    }
    
    func cancelOrder(_ id: Int) {
        if let orders = getOrders() {
           let index = getIndex(id, orders: orders)
            if index != -1 {
                let order = orders[index]
                order.isCanceled = true
                var localOrders = orders
                localOrders.remove(at: index)
                localOrders.insert(order, at: index)
                saveOrder(localOrders)
            }
        }
    }
    
    func getIndex(_ id: Int, orders: [OrdersDataModel]) -> Int {
        var index = -1
        var found = false
        for order in orders {
            index += 1
            if order.id == id {
                found = true
                break
            }
        }
        return found ? index : -1
    }
}
