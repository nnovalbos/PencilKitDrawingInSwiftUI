//
//  CoreDataManager.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init () {}
    
    lazy var persistenceContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "DrawingDocModel")
        container.loadPersistentStores{ (storeDesc, error) in
        
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
        
    }()
    
    
    func saveContext(){
        
        let context = persistenceContainer.viewContext
        
        if context.hasChanges {
            
            do {
                try context.save()
            }catch{
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addData (document: DrawingDocument){
        
        let drawing = DrawingDoc(context: persistenceContainer.viewContext)
        
        drawing.id = document.id
        drawing.data = document.data
        drawing.name = document.name
        
        saveContext()
        
    }
    
    func getData() -> [DrawingDocument] {
        
        let request: NSFetchRequest<DrawingDoc> = DrawingDoc.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        var fetchResults = [DrawingDocument]()
        
        do{
            let result = try persistenceContainer.viewContext.fetch(request)
            
            for data in result {
                fetchResults.append(DrawingDocument(id: data.id ?? UUID(), data: data.data ?? Data(), name: data.name ?? ""))
            }
            
        }catch{
            print("Fetching failed")
        }
        
        return fetchResults
    }
    
    func updateData(data: DrawingDocument){
        
        let request: NSFetchRequest<DrawingDoc> = DrawingDoc.fetchRequest()
        
        let predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        request.predicate = predicate
        
        do{
            let results = try persistenceContainer.viewContext.fetch(request)
            let obj = results.first
            obj?.setValue(data.data, forKey: "data")
            obj?.setValue(data.name, forKey: "name")
            saveContext()
        }catch {
            print("Error upadating document")
        }
        
    }
    
    func deleteData(data: DrawingDocument){
        
        let request : NSFetchRequest<DrawingDoc> = DrawingDoc.fetchRequest()
        request.includesPropertyValues = false;
        let predicate = NSPredicate(format: "id = %@", data.id as CVarArg)
        request.predicate = predicate
        
        do{
            let results = try persistenceContainer.viewContext.fetch(request)
            for item in results {
                persistenceContainer.viewContext.delete(item)
            }
            
            saveContext()
            
        }catch{
            print("Error deleting document")
        }
        
    }
    
}
