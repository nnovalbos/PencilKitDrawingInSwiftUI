//
//  DrawingViewController.swift
//  PencilKitDrawingInSwiftUI
//
//  Created by Nicolas Novalbos on 26/9/21.
//

import UIKit
import PencilKit

class DrawingViewController: UIViewController {

    lazy var canvas: PKCanvasView = {
        
        var canv = PKCanvasView()
        canv.drawingPolicy = .anyInput
        canv.minimumZoomScale = 1
        canv.maximumZoomScale = 2
        canv.translatesAutoresizingMaskIntoConstraints = false
        return canv
    }()
    
    lazy var toolPicker : PKToolPicker = {
        
        var toolP = PKToolPicker()
        toolP.addObserver(self)
        return toolP
        
    }()
    
    var drawingData = Data()
    
    var drawingChanged: (Data) -> Void = {_ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        
        if let drawing = try? PKDrawing(data: drawingData) {
            canvas.drawing = drawing
        }
    }
}

// MARK:- PK delegates
extension DrawingViewController : PKToolPickerObserver, PKCanvasViewDelegate {
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        drawingChanged(canvasView.drawing.dataRepresentation())
    }
}
