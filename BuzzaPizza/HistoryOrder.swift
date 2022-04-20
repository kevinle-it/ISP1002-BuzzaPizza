//
//  HistoryOrder.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import Foundation

class HistoryOrder {
    var id = UUID().uuidString
    var toppings: [String] = []
    var name = ""
    var address = ""
    var city = ""
    var zipCode = ""
    var toppingText = ""
    
    init() {}
    
    init(toppings: [String]) {
        self.toppings = toppings
        
        updateToppingText()
    }

    func updateToppingText() {
        // Convert from array list of toppings to a string with comma-separated toppings
        // ["Mozzarella", "BBQ Sauce", "Tomato"] => "Mozzarella, BBQ Sauce, and Tomato"
        var toppingsToConvert = toppings;
        if (toppingsToConvert.count > 0) {
            let firstTopping = toppingsToConvert[0];
            let lastTopping = toppingsToConvert[toppingsToConvert.count - 1];
            
            let from1 = firstTopping.index(firstTopping.startIndex, offsetBy: 0)
            let to1 = firstTopping.index(firstTopping.startIndex, offsetBy: 1)
            let from2 = firstTopping.index(after: firstTopping.startIndex)
            let to2 = firstTopping.endIndex
            // Capitalize first letter of first topping in the list
            toppingsToConvert[0] = String(format: "%@%@", String(firstTopping[from1..<to1]).uppercased(), String(firstTopping[from2..<to2]))
            // Add "and" as a linking word to the last topping in the list for a more natural sentence.
            toppingsToConvert[toppingsToConvert.count - 1] = String(format: "and %@.", lastTopping);

            self.toppingText = toppingsToConvert.joined(separator: ", ")
        }
    }
}
