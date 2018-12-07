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
        guard let scene = SKScene(fileNamed: "GameScene") else { return }
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
        
        
        // Performance optimisation.
        view.ignoresSiblingOrder = true
        // Debug
        view.showsFPS = true
        view.showsNodeCount = true
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
