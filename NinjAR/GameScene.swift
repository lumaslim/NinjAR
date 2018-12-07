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
        // Anchor coordinates for relative placement
        print(anchorPoint)
        anchorPoint = CGPoint(x: 0, y: 0)
        print(anchorPoint)
        // Setup scene
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        //
        addChild(player)
        
        for _ in 1..<5 {
            print("makeMonster where is it")
            makeMonster()
        }
        
        print("Setup finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func addMob() {
    
    }
    func makeMonster() {
        let monster = SKSpriteNode(imageNamed: "monster")
      
        // Monster spawn
        // Does position use top-left as for relation to origin coordinates?
        let spawnYRandom = random(min: monster.size.height, max: size.height)
        let spawnXRightWall = size.width - monster.size.width
        
        monster.position = CGPoint(x: spawnXRightWall, y: spawnYRandom)
        
        addChild(monster)
        
        // Monster movement
        let moveDurationRandom = TimeInterval(random(min: 1.0, max: 4.0)) // feels redundant
        let moveDestination = CGPoint(x: 1, y: 1)
        let moveAction = SKAction.move(to: moveDestination, duration: moveDurationRandom)
        
        monster.run(moveAction, withKey: "randomMove")
 
        print("Monster run")
    }
    
    // Swift 4 random unification API
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random(in: min..<max)
    }

}
