//
//  ViewController.swift
//  DrawingApp
//
//  Created by Anastasia Burak on 9.12.21.
//

import UIKit
import PencilKit
import PhotosUI

class ViewController: UIViewController, PKToolPickerObserver, PKCanvasViewDelegate {

    @IBOutlet weak var canvasView: PKCanvasView!
    
    var drawing = PKDrawing()
    var toolPicker: PKToolPicker!
    let canvasWidth: CGFloat = 768
    let canvasOverscrollHeight: CGFloat = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolPicker = PKToolPicker()
        canvasView.delegate = self
        canvasView.drawing = drawing
        
        canvasView.drawingPolicy = .anyInput
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
            
        canvasView.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let canvasScale = canvasView.bounds.width / canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
        // Scroll to the top.
        updateContentSizeForDrawing()
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    // Hide the home indicator, as it will affect latency.
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        updateContentSizeForDrawing()
    }
    
    func updateContentSizeForDrawing() {
        // Update the content size to match the drawing.
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
        
        // Adjust the content size to always be bigger than the drawing height.
        if !drawing.bounds.isNull {
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + self.canvasOverscrollHeight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }
        canvasView.contentSize = CGSize(width: canvasWidth * canvasView.zoomScale, height: contentHeight)
    }

    @IBAction func saveDrawing(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
         
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
                self.showAlert("Great", "We save your drawing into galery")
            } completionHandler: { success, error in
                if error != nil {
                    self.showAlert("Error", "Change settings to allow aplication save photo to your gallery")
                }
            }
        }
    }
    
    @IBAction func deleteButtonWasPressed(_ sender: Any) {
        canvasView.drawing = PKDrawing()
    }
    
 
    
}

