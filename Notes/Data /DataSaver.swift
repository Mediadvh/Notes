//
//  SaveNotes.swift
//  Notes
//
//  Created by Media Davarkhah on 12/7/1399 AP.
//

import UIKit
import CoreData
class DataSaver{
    static  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func save(){
    do{
        try context.save()
        
    }
    catch{
        print("couldn't configure data successfully")
    }

}
}
