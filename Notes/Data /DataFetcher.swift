//
//  DataFetcher.swift
//  Notes
//
//  Created by Media Davarkhah on 12/8/1399 AP.
//

import Foundation
import UIKit
import CoreData
class DataFetcher{
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func fetchNotes(into notes: inout [Note]){
        let request = Note.fetchRequest() as NSFetchRequest<Note>
        request.returnsObjectsAsFaults = false
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do{ notes = try context.fetch(request) }
       
        catch{}
    }
}
