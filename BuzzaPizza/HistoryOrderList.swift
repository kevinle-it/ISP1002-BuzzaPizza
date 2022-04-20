//
//  HistoryOrderList.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import Foundation

class HistoryOrderList {
    var hisroryOrders: [HistoryOrder] = []
    
    init() {}
    
    // Add new history order
    func addHistoryOrder(order: HistoryOrder) {
        hisroryOrders.append(order)
    }
    
    // Remove existing history order
    func removeHistoryOrder(position: Int) {
        hisroryOrders.remove(at: position)
    }
    
    // Change position of a history order item in the history order list
    func moveHistoryOrder(from: Int, to: Int) {
        let temp = hisroryOrders[from]
        removeHistoryOrder(position: from)
        hisroryOrders.insert(temp, at: to)
    }
}
