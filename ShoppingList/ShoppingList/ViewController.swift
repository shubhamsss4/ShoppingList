//
//  ViewController.swift
//  ShoppingList
//
//  Created by Shah, Shubham on 04/03/20.
//  Copyright © 2020 Shubham shah. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForShoppingItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear List", style: .plain, target: self, action: #selector(clearShoppingList))
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItem", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func promptForShoppingItem() {
        let ac = UIAlertController(title: "Enter Shopping Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addToListAction = UIAlertAction(title: "Add To List", style: .default) {
            [weak self,weak ac] _ in
            guard let itemToBeAdded = ac?.textFields?[0].text else { return }
            self?.addItemToList(itemToBeAdded)
        }
        ac.addAction(addToListAction)
        present(ac,animated: true)
    }
    
    @objc func clearShoppingList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func addItemToList(_ itemToBeAdded: String) {
        let lowercasedItem = itemToBeAdded.lowercased()
        if isOriginal(itemToBeAdded: lowercasedItem) {
            shoppingList.insert(lowercasedItem, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        else {
            showError(errorTitle: "Item Already Added", errorMessage: "Please try to add something which is not already included.")
        }
    }
    
    func isOriginal(itemToBeAdded: String) -> Bool {
        return !shoppingList.contains(itemToBeAdded)
    }
    
    func showError(errorTitle: String,errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac,animated: true)
    }
}

