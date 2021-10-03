//
//  AddNewDocument.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import SwiftUI

struct AddNewDocument: View {

    @ObservedObject var manager: DrawingManager
    @State private var documentName : String = ""
    @Binding var addShown: Bool
    
    var body: some View {
        VStack {
            
            Text("Enter document name:")
            
            TextField("Enter document name here...", text: $documentName, onCommit: {
               save(fileName: documentName)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Create") {
                save(fileName: documentName)
            }
        }.padding()
    }
    
    
    
    
    private func save(fileName: String){
        manager.addData(doc: DrawingDocument(id: UUID(), data: Data(), name: fileName))
        addShown.toggle()
    }
    
}
