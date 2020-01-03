//
//  CurveView.swift
//  sberservice
//
//  Created by admin on 7/31/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import UIKit

class CurveView: UIView {

 
    
    override func draw(_ rect: CGRect) {
        
        let start: CGPoint = CGPoint(x: 0, y: self.bounds.height)
        
    
        let curvePath = UIBezierPath()
        
        let controlPoint = CGPoint(x: self.bounds.width/2.32, y: -self.bounds.height/6.0)
        let endPoint = CGPoint(x: self.bounds.width, y: self.bounds.height/4.85)
        
        curvePath.move(to: start)
        curvePath.addLine(to: CGPoint(x: 0, y: self.bounds.height/7))
        curvePath.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        curvePath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        curvePath.close()
        
         
        curvePath.lineWidth = 0.0
        curvePath.stroke()
        
        let mask = CAShapeLayer()
        mask.path = curvePath.cgPath
        self.layer.mask = mask
        
      
      
        
        
        
        
    }
    
    

}
