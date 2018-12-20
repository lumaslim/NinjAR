//
//  GameScene.swift
//  NinjAR
//
//  Created by SLim on 5/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    
    let player: SKSpriteNode = SKSpriteNode(imageNamed: "player")
    
    override func didMove(to view: SKView) {
        print("GameScene size", size)
        
        // Anchor coordinates for relative placement
        print(anchorPoint)

        // Setup scene

        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        // Setup physics
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        // Spawn player
        addChild(player)
    

        
        print("Setup finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan:: start ", touches)
        let spawnPoints = [
            CGPoint(0, 0),
            CGPoint(0, size.height),
            CGPoint(size.width, 0), // 1000,0 scaled to 700,24.5 ? with aspectfill and gamescene on ipadpro12.9 res
            CGPoint(size.width, size.height)
        ]

        print("touchesBegan:: end")
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded begin")
        guard let firstTouch = touches.first else { return }
        let touchLocationInScene = firstTouch.location(in: self)
        
        
        
    }
}

extension GameScene {
    // Swift 4 random unification API
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random(in: min..<max)
    }
    
}
extension CGPoint {
    init(_ convenientX: CGFloat, _ convenientY: CGFloat) {
        self.init(x: convenientX, y: convenientY)
    }
}


// - MARK: Collision detection contact
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Pew pew contact", contact)
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
    }
}

