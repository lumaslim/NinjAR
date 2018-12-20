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
        
        // Load ref to storyboard view... instead of programmatic...
        guard let view = self.view as! SKView? else { return }
        
        guard let scene = GameScene(fileNamed: "GameScene") else { return }
        // Set the scale mode to scale to fit the window
        

        scene.scaleMode = .aspectFill
        
        view.setPerformanceOptimisation(enable: true)
        view.setShowDebug(enable: true)
        
        // Present the scene
        view.presentScene(scene)
        
        print("GameVC", self.view.bottomAnchor)
        print("GameVC scene scene.size", scene.size)
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
