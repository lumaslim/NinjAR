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
//        anchorPoint = CGPoint(x: 0, y: 0)
        print(anchorPoint)
        // Setup scene
        backgroundColor = SKColor.white
        player.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        
        //
        addChild(player)
        let s = CGSize(width: 500, height: 999)
        for _ in 1..<5 {
            print("makeMonster where is it")
            
            let mon = makeMonster()
            
            mon.scale(to: s)
            print(mon)
            addChild(mon)
        }
        
        print("Setup finished")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan:: start ", touches)
        let pts = [
            CGPoint(0, 0),
            CGPoint(0, size.height),
            CGPoint(size.width, 0), // 1000,0 scaled to 700,24.5 ? with aspectfill and gamescene on ipadpro12.9 res
            CGPoint(size.width, size.height)
        ]
        let monsters = [makeMonster(), makeMonster(), makeMonster(), makeMonster()]

        
        let szWidth = size.width
        let szHeight = size.height
        //        let spawnXRightWall = size.width - monster.size.width
        //        let spawnYRandom = random(min: monster.size.height, max: size.height)
        for (index, eaMonster) in monsters.enumerated() {
            addChild(eaMonster)
            positionMobNodeInParent(eaMonster, at: pts[index])
            let moveIt = getMonsterMoveAction()
            setMonsterMove(monster: eaMonster, move: moveIt)
        }
        
        print("touchesBegan:: end")
        
        
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
// - MARK: Monster
extension GameScene {
    // lol
    func spawn(monster: SKSpriteNode, onParent gameScene: GameScene) {
        gameScene.addChild(monster)
    }
    func makeMonster() -> SKSpriteNode {
        return SKSpriteNode(imageNamed: "monster")
    }
    
    // welp superfluous
    func positionMobNodeInParent(_ monster: SKSpriteNode, at point: CGPoint) {
        // Does position use top-left origin for relative coordinates?
        //        let spawnXRightWall = size.width - monster.size.width
        //        let spawnYRandom = random(min: monster.size.height, max: size.height)
        
        monster.position = point
    }
    func setMonsterMove(monster: SKSpriteNode, move moveAction: SKAction) {
        monster.run(moveAction, withKey: "randomMove")
    }
    func getMonsterMoveAction() -> SKAction {
        // Strange behaviour depending on portrait landscape. landscape seems to work as expected.
        // Monster movement
        let moveDurationRandom = TimeInterval(random(min: 1.0, max: 6.5)) // feels redundant
        let moveDestination = CGPoint(x: 768, y: 1024) // 768,1024 ends up near the tap point of 470,0 ... Strange
        let moveAction = SKAction.move(to: moveDestination, duration: moveDurationRandom)
        
        return moveAction
    }
}
