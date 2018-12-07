//
//  Vectorisable.swift
//  NinjAR
//
//  Created by SLim on 7/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import Foundation
import struct CoreGraphics.CGGeometry.CGPoint
import struct CoreGraphics.CGGeometry.CGFloat

extension CGPoint: VectorCalculatable {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    static func +-(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y - right.y)
    }
    static func *(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    static func /(point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / scalar, y: point.y / scalar)
    }
    
    #if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
    #endif
    
    
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    // Normalise 1-unit vector with magnitude.  / length = 1
    func normalized() -> CGPoint {
        return self / length()
    }
    
}
