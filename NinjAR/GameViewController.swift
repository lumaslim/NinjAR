//
//  GameViewController.swift
//  NinjAR
//
//  Created by SLim on 5/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController:: viewDidLoad()")
        // Load ref to storyboard view... (Lame! just do full programmatic!)
        guard let view = self.view as! SKView? else { return }
        // Load the SKScene from 'GameScene.sks'
        guard let scene = GameScene(fileNamed: "GameScene") else { return }
        // Set the scale mode to scale to fit the window
        
        print("GameVC scene scene.size", scene.size)
        scene.scaleMode = .aspectFill
        
        view.backgroundColor = UIColor.red
        // Present the scene
        view.presentScene(scene)
        
        setPerformanceOptimisation(on: view)
        setShowDebug(on: view, enable: true)
        print("GameViewController:: viewDidLoad() finished")
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

// Trade-off
protocol PerfOptimisable {
    
}
protocol DebugShowable {
    func setPerformanceOptimisation(on view: SKView)
    
    func setShowDebug(on view: SKView, enable toggle: Bool)
}
// 4 mainstream uses for protocol-oriented programming Swift extensions
// private access control. logic segregation / pragma replacement.
// Old article https://www.natashatherobot.com/using-swift-extensions/
// Newer https://cocoacasts.com/four-clever-uses-of-swift-extensions
// Popular Swifty paradigms: Functional Programming, Reactive, Struct Protocol Extension
//
// extend SKView vs just logic on viewcontrollers?
extension GameViewController: DebugShowable {
    func setPerformanceOptimisation(on view: SKView) {
        // Performance optimisation avoid calculating superfluous order.
        view.ignoresSiblingOrder = true
    }
    func setShowDebug(on view: SKView, enable toggle: Bool) {
        // Debug stats
        view.showsFPS = toggle
        view.showsNodeCount = toggle
        view.showsFields = toggle
        view.showsDrawCount = toggle
        view.showsQuadCount = toggle
    }
}

