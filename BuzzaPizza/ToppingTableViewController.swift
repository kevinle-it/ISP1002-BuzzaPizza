//
//  ToppingTableViewController.swift
//  BuzzaPizza
//
//  Created by Tri Le on 4/20/22.
//

import UIKit

class ToppingTableViewController: UITableViewController {
    
    let TOPPINGS = ["Pepperoni", "Bacon", "Mushroom", "Tomatoes", "Olives", "Green Peppers", "Onions", "Jalapenos"]
    let SELECTED_ROW_COLOR = UIColor(red: CGFloat(3.0/255), green: CGFloat(218.0/255), blue: CGFloat(197.0/255), alpha: 1)
    let DEFAULT_ROW_COLOR = UIColor(white: 0, alpha: 0)
    var toppingSelectionStatuses = Array(repeating: false, count: 8)
    
//    var historyOrderList: HistoryOrderList!
//    var selectedOrderIndex: Int?
    var isEditMode: Bool = false
    
    var historyOrderToModify: HistoryOrder!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        
        // Save selected topping of history order (to update on UITableView below in viewWillLayoutSubviews())
        if let order = historyOrderToModify {
            let selectedToppingList = order.toppings
            
            if selectedToppingList.count > 0 {
                for (index, tp) in TOPPINGS.enumerated() {
                    if selectedToppingList.contains(tp) {
                        // Init the status list
                        toppingSelectionStatuses[index] = true
                    }
                }
            }
        }
    }
    
    // Reload table view data after go back from order scene to this scene to show newly added history order (if any)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload table view data
        tableView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        // Highlight selected rows in this lifecycle method, after subviews
        // are about layouting, to prevent warning of layouting this
        // UITableView's visible cells while it has not been added
        // to the window view hierarchy yet
        var indexPath: IndexPath!
        for (index, isSelected) in toppingSelectionStatuses.enumerated() {
            if isSelected {
                indexPath = IndexPath(row: index, section: 0)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                tableView.delegate?.tableView!(self.tableView, didSelectRowAt: indexPath)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TOPPINGS.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topping", for: indexPath)

        // Configure the cell...
        let currentToppingRow = TOPPINGS[indexPath.row]
        cell.textLabel!.text = currentToppingRow
        // Remove default selected row style color
        // cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return }
        selectedCell.contentView.backgroundColor = SELECTED_ROW_COLOR
        
        toppingSelectionStatuses[indexPath.row] = true
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return }
        selectedCell.contentView.backgroundColor = DEFAULT_ROW_COLOR
        
        toppingSelectionStatuses[indexPath.row] = false
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let selectedCell = tableView.cellForRow(at: indexPath)
        else { return nil }
        
        if toppingSelectionStatuses[indexPath.row] {
            tableView.deselectRow(at: indexPath, animated: false)
            toppingSelectionStatuses[indexPath.row] = false
            selectedCell.contentView.backgroundColor = DEFAULT_ROW_COLOR
            return nil
        }
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        toppingSelectionStatuses[indexPath.row] = true
        selectedCell.contentView.backgroundColor = SELECTED_ROW_COLOR
        return indexPath
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        var selectedTopping: String!
        historyOrderToModify.toppings = []
        if let indexPaths = tableView.indexPathsForSelectedRows {
            for idx in indexPaths {
                selectedTopping = TOPPINGS[idx.row]
                historyOrderToModify.toppings.append(selectedTopping)
            }
        }
        
        // pass over the historyOrderToModify to the destination (OrderViewController)
        let dst = segue.destination as! OrderViewController
        dst.historyOrderToModify = historyOrderToModify
    }

}
