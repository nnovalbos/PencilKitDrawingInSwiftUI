//
//  EmptyView.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import SwiftUI

struct EmptyView : View {
    
    var body: some View {
        VStack(spacing: 20){
            Text("Let's draw something")
                .font(.largeTitle)
            
            Text("Select or create document form left panel")
            
            Image(systemName: "scribble")
                .font(.largeTitle)
                
        }.foregroundColor(.gray)
    }
    
}
