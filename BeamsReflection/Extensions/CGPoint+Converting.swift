//
//  CGPoint+Converting.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    
    func convertedY() -> CGPoint {
        return CGPoint(x: self.x, y: -self.y)
    }
    
    func nextPoint(directionVector: DirectionVector) -> CGPoint {
        return CGPoint(x: self.x + directionVector.x, y: self.y + directionVector.y)
    }
    
    func roundedPoint(for rect: CGRect) -> CGPoint {
        var roundedPoint = CGPoint(x: self.x, y: self.y)
        if self.x > rect.maxX {
            roundedPoint.x = floor(x)
        }
        if self.x < rect.minX {
            roundedPoint.x = floor(x)
        }
        
        if self.y > rect.minY {
            roundedPoint.y = floor(y)
        }
        if self.y < -rect.maxY {
            roundedPoint.y = ceil(y)
        }

        return roundedPoint
    }

}
