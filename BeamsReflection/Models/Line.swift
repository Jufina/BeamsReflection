//
//  Line.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

final class Line {
    let a: CGFloat
    let b: CGFloat
    let c: CGFloat
    
    init(firstPoint: CGPoint, secondPoint: CGPoint) {
        self.a = secondPoint.y - firstPoint.y
        self.b = firstPoint.x - secondPoint.x
        self.c = firstPoint.x*(firstPoint.y - secondPoint.y) + firstPoint.y*(secondPoint.x - firstPoint.x)
    }
}

