//
//  ToDoModel.swift
//  3in1
//
//  Created by Medet Dönmez on 25.09.2022.
//

import Foundation
import CoreData
import UIKit

protocol addProtocol {
    func addItem(title: String)
}

protocol statusProtocol {
    func status(index: Int)
}

class ToDoModel {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadItems() {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
