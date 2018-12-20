//
//  SKView+DebugPerfConfigurable.swift
//  NinjAR
//
//  Created by SLim on 20/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import SpriteKit.SKView

//protocol DebugPerfConfigurable {
//    func setPerformanceOptimisation<T>(on view: T, enable toggle: Bool) -> Void
//
//    func setDebugOptions<T>(on view: T, enable toggle: Bool) -> Void
//}
extension SKView {
    func setPerformanceOptimisation(enable toggle: Bool = true) {
        // Performance optimisation avoid calculating superfluous order.
        self.ignoresSiblingOrder = toggle
    }
    func setShowDebug(enable toggle: Bool) {
        // Debug stats
        self.showsFPS = toggle
        self.showsNodeCount = toggle
        self.showsFields = toggle
        self.showsDrawCount = toggle
        self.showsQuadCount = toggle
    }
}


