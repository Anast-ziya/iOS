//
//  ProgressCircleView.swift
//  WaterReminder
//
//  Created by Anastasia Burak on 15.11.21.
//

import UIKit

class ProgressCircleView: UIView {
    
    private let trackLayer = CAShapeLayer()
    private let shapeLayer = CAShapeLayer()
    private let startAngle = CGFloat(-Double.pi / 2)
    private let endAngle = CGFloat(3 * Double.pi / 2)
    
    private var currentProgress: Float = 0
    
    func createCircularPath() {
        center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 120, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        // create track layer
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(red: 130/255, green: 139/255, blue: 151/255, alpha: 0.3).cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)
        
        //create a circular layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor(red: 241/255, green: 154/255, blue: 56/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
    }
    
    func progressAnimation(duration: TimeInterval) {
        let newProgress = WaterManager.shared.goalsProgress ?? 0
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.fromValue = currentProgress
        circularProgressAnimation.toValue = newProgress
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        shapeLayer.add(circularProgressAnimation, forKey: "progressAnimation")
        
        currentProgress = newProgress
    }
    
}
