//
//  Beam.swift
//  BeamsReflection
//
//  Created by jufina on 23.02.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import UIKit

final class Beam {
    
    let borders: CGRect!
    
    init(borders: CGRect) {
        self.borders = borders
    }
}

private protocol BeamCreation {
    func buildBezierPath(center: CGPoint, touchPoint: CGPoint) -> UIBezierPath
    func pathPoints(touch: CGPoint, center: CGPoint) -> [CGPoint]
    func intersectPoints(center: CGPoint, point: CGPoint, vector: DirectionVector, isFirstPoint: Bool) -> [CGPoint]
}

private protocol Helpers {
    func isRealIntersectPoint(vector: DirectionVector, point1: CGPoint, point2: CGPoint) -> Bool
    func isSameDirection(direction1: CGFloat, direction2: CGFloat) -> Bool
    func pointInRect(point: CGPoint) -> Bool
}


//MARK: - BeamCreation

extension Beam: BeamCreation {
    
    func buildBezierPath(center: CGPoint, touchPoint: CGPoint) -> UIBezierPath {
        let pointsInPath = pathPoints(touch: touchPoint, center: center)
        let path = UIBezierPath()
        let initialPoint = center
        path.move(to: initialPoint)
        pointsInPath.forEach { (point) in
            path.addLine(to: point)
        }
        
        return path
    }

    fileprivate func pathPoints(touch: CGPoint, center: CGPoint) -> [CGPoint] {
        var beamPoints = [CGPoint]()
        
        let touchPoint = touch.convertedY()
        let centerPoint = center.convertedY()
        let directX =  touchPoint.x - centerPoint.x
        let directY =  touchPoint.y - centerPoint.y
        let directionVector: DirectionVector = DirectionVector(x: directX, y: directY)
        directionVector.normalize()
        
        var point = touchPoint
        var isFirstPoint = true
        
        for _ in 0...Constants.numberOfReflections {
            let intersectionPoints = intersectPoints(center: centerPoint, point: point, vector: directionVector, isFirstPoint: isFirstPoint)
            guard let intersectPoint = intersectionPoints.first else {
                Swift.print("WARNING: No intersect points!")
                
                continue
            }
            
            if intersectionPoints.count > 1 {
                
                directionVector.invertX()
                directionVector.invertY()
            } else {
                if intersectPoint.x == borders.minX || intersectPoint.x == borders.maxX {
                    directionVector.invertX()
                }
                if intersectPoint.y == borders.minY || intersectPoint.y == -borders.maxY {
                    directionVector.invertY()
                }
                
            }
            beamPoints.append(intersectPoint.convertedY())
            point = intersectPoint
            isFirstPoint = false
        }
        
        return beamPoints
    }
    
    fileprivate func intersectPoints(center: CGPoint, point: CGPoint, vector: DirectionVector, isFirstPoint: Bool) -> [CGPoint] {
        var firstPoint: CGPoint
        var secondPoint: CGPoint

        if isFirstPoint {
            secondPoint = point
            firstPoint = center
        } else {
            firstPoint = point
            secondPoint = point.nextPoint(directionVector: vector)
        }
        
        
        let line = Line(firstPoint: firstPoint, secondPoint: secondPoint)
        let left = CGPoint(x: borders.minX, y: -(line.a*borders.minX + line.c)/line.b)
        let right = CGPoint(x: borders.maxX, y: -(line.a*borders.maxX + line.c)/line.b)
        let top = CGPoint(x: -(line.b*borders.minY + line.c)/line.a, y: borders.minY)
        let bottom = CGPoint(x: -(line.b*(-borders.maxY) + line.c)/line.a, y: -borders.maxY)
        
        var intersections = [ left.roundedPoint(for: borders),
                              right.roundedPoint(for: borders),
                              top.roundedPoint(for: borders),
                              bottom.roundedPoint(for: borders) ]
        
        
        intersections = intersections.filter { (point) -> Bool in
            return isRealIntersectPoint(vector: vector, point1: secondPoint, point2: point)
        }
        
        
        
        return intersections
    }

}


//MARK: - Helpers

extension Beam: Helpers {
    fileprivate func isRealIntersectPoint(vector: DirectionVector, point1: CGPoint, point2: CGPoint) -> Bool {
        var sameXDirection: Bool
        var sameYDirection: Bool
        let coordinatesInRange = pointInRect(point: point2)
        
        let pointsDirectionByX = point2.x - point1.x
        let pointsDirectionByY = point2.y - point1.y
        sameXDirection = vector.x == 0 ? true : isSameDirection(direction1: pointsDirectionByX, direction2: vector.x)
        sameYDirection = vector.y == 0 ? true : isSameDirection(direction1: pointsDirectionByY, direction2: vector.y)
        
        return sameXDirection && sameYDirection && coordinatesInRange
    }
    
    fileprivate func isSameDirection(direction1: CGFloat, direction2: CGFloat) -> Bool {
        return (direction1 > 0) == (direction2 > 0)
    }
    
    fileprivate func pointInRect(point: CGPoint) -> Bool {
        return (point.x >= borders.minX && point.x <= borders.maxX) && (point.y <= borders.minY && point.y >= -borders.maxY)
    }
}
