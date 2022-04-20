//
//  HistoryOrderList.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import Foundation

class HistoryOrderList {
    var hisroryOrders: [HistoryOrder] = []
    
    init() {
        let toppings = ["Pepperoni", "Bacon", "Mushroom", "Tomatoes", "Olives", "Green Peppers", "Onions", "Jalapenos"]
        var order: HistoryOrder!
        for _ in 1...10 {
            order = HistoryOrder(toppings: toppings)
            order.setOrderInfo("My Name", "My Address", "My City", "My ZipCode")
            addHistoryOrder(order: order)
        }
    }
    
    // Add new history order
    func addHistoryOrder(order: HistoryOrder) {
        if let index = hisroryOrders.firstIndex(where: {$0.id == order.id}) {
            // Order exists => Update data
            hisroryOrders[index] = order
        } else {
            // Order not found => Add new
            hisroryOrders.append(order)
        }
    }
    
    // Remove existing history order
    func removeHistoryOrder(position: Int) {
        hisroryOrders.remove(at: position)
    }
    
    /*
    // UNSUPPORTED FOR NOW
    // Change position of a history order item in the history order list
    func moveHistoryOrder(from: Int, to: Int) {
        let temp = hisroryOrders[from]
        removeHistoryOrder(position: from)
        hisroryOrders.insert(temp, at: to)
    }
    */
}
