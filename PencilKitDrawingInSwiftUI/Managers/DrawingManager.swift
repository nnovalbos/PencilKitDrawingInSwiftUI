//
//  DrawingManager.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import SwiftUI

class  DrawingManager: ObservableObject {
    
    @Published var docs : [DrawingDocument]
    
    init() {
        docs = CoreDataManager.shared.getData()
    }
    
    func update(data: Data, for id: UUID){
        
        if let index = self.docs.firstIndex(where: {$0.id == id}){
            self.docs[index].data = data
            CoreDataManager.shared.updateData(data: self.docs[index])
            
        }
        
    }
    
    func getData(for id:UUID ) -> Data {
        if let doc = self.docs.first(where: {$0.id == id}){
            return doc.data
        }
        
        return Data()
    }
    
    func addData(doc:DrawingDocument){
        docs.append(doc)
        CoreDataManager.shared.addData(document: doc)
    }
    
    func delete(for indexSet: IndexSet){
        for index in indexSet {
            CoreDataManager.shared.deleteData(data: docs[index])
            docs.remove(at: index)
        }
    }
}
