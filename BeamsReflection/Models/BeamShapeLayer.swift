//
//  BeamShapeLayer.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

final class BeamShapeLayer: CAShapeLayer {
    let color: UIColor!
    let beam: Beam!
    let point: CGPoint!
    let center: CGPoint!
    
    init(color: UIColor, beam: Beam, point: CGPoint, center: CGPoint) {
        self.color = color
        self.beam = beam
        self.point = point
        self.center = center
        
        super.init()
        setupBeamLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private protocol Setup: class {
    func setupBeamLayer()
}

extension BeamShapeLayer: Setup {
    func setupBeamLayer() {
        let shapeLayerPath = UIBezierPath()
        shapeLayerPath.lineCapStyle = .round
        self.fillColor = nil
        self.lineWidth = Constants.ShapeLayer.lineWidth
        self.strokeColor = color.cgColor
        self.frame = beam.borders
        
        let path = beam.buildBezierPath(center: center, touchPoint: point)
        shapeLayerPath.append(path)
        self.path = shapeLayerPath.cgPath
    }
}
