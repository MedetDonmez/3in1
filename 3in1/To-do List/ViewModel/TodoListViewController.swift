//
//  TodoListViewController.swift
//  3in1
//
//  Created by Medet Dönmez on 23.09.2022.
//

import UIKit
import CoreData
import ChameleonFramework


class TodoListViewController: UITableViewController{
    
    //creating container here for data storage.
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var model = ToDoModel()
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        tabBarController?.tabBar.backgroundColor = FlatGreenDark()
        SaveItems()
    }
    
    override func viewDidLoad() {
        
        setupUI()
        model.loadItems()
        
    }
    
    func setupUI() {
        view.backgroundColor = FlatGreen()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return model.itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = model.itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.tintColor = FlatRedDark()
        
        //arranging cell colour by index.
        if let colour = FlatGreen().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(model.itemArray.count)) {
            cell.contentView.backgroundColor = colour
            cell.backgroundColor = colour
            cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
        }
        
        //cell checkmark will be equal to item.done
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //swipe to delete function
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            model.context.delete(model.itemArray[indexPath.row])
            model.itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            SaveItems()
            
        }
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckboxViewController") as! CheckboxViewController
        vc.index = indexPath.row
        vc.bar = model.itemArray[indexPath.row].done
        vc.delegate = self
        SaveItems()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func SaveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context")
        }
        self.tableView.reloadData()
    }
}

// MARK: - ADD PROTOCOL
extension TodoListViewController: addProtocol {
    
    func addItem(title: String) {
        let newItem = Item(context: self.context)
        newItem.title = title
        newItem.done = false
        newItem.date = Date.now
        model.itemArray.insert(newItem, at: 0)
        self.SaveItems()
    }
}

// MARK: - STATUS PROTOCOL
extension TodoListViewController: statusProtocol {
    func status(index: Int){
        model.itemArray[index].done = !model.itemArray[index].done
    }
}
