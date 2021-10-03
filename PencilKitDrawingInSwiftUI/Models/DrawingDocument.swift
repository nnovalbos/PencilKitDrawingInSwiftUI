//
//  DrawingDocument.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import Foundation

struct DrawingDocument : Identifiable
{
    let id:UUID
    var data: Data
    var name: String
}
