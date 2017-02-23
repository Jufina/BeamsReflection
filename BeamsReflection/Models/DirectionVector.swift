//
//  DirectionVector.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

final class DirectionVector {
    var x: CGFloat!
    var y: CGFloat!
    
    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    func normalize() {
        let distance = distanceToPoint(point1: CGPoint(x: self.x, y: self.y), point2: CGPoint.zero)
        self.x = self.x/distance
        self.y = self.y/distance
    }
    
    private func distanceToPoint(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let distance = sqrt(pow(Double(point2.x - point1.x),2) + pow(Double(point2.y - point1.y),2))
        return CGFloat(distance)
    }
    
    func invertX() {
        self.x = -self.x
    }
    
    func invertY() {
        self.y = -self.y
    }
}
