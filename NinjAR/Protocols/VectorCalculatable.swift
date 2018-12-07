//
//  VectorCalculatable.swift
//  NinjAR
//
//  Created by SLim on 7/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//
import Foundation
import struct CoreGraphics.CGGeometry.CGPoint
import struct CoreGraphics.CGGeometry.CGFloat

infix operator +-: AdditionPrecedence
infix operator ☺️: AdditionPrecedence // lol

protocol VectorCalculatable  {
    
    static func +(left: Self, right: Self) -> Self
    static func +-(left: Self, right: Self) -> Self
    static func -(left: Self, right: Self) -> Self
    //    static func *(left: Self, right: Self) -> Self
    //    static func /(left: Self, right: Self) -> Self
    static func *(point: Self, scalar: CGFloat) -> Self
    static func /(point: Self, scalar: CGFloat) -> Self
    
    
    func length() -> CGFloat
    
    func normalized() -> CGPoint
    
}

