//
//  GameScene.swift
//  NinjAR
//
//  Created by SLim on 5/12/18.
//  Copyright © 2018 SLim. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    // Interesting bit flags
    // Doesn't Swift have nicer bitmask functionality?
    static let none : UInt32 = 0            // 0000 0000 0000 0000
    static let all : UInt32 = UInt32.max    // 1111 1111 1111 1111
    static let monster: UInt32 = 0b1        // Says 1 but b1 notation ??// 0000 0000 0000 0001
    static let projectile: UInt32 = 0b10     // 0000 0000 0000 0010
        // 0x1, 0x2??
}
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
        let monsters = [makeMonster(), makeMonster(), makeMonster(), makeMonster()]

        //        let spawnXRightWall = size.width - monster.size.width
        //        let spawnYRandom = random(min: monster.size.height, max: size.height)
        for (index, monster) in monsters.enumerated() {
            
            
            // Spawn
            addChild(monster)
            positionMobNodeInParent(monster, at: spawnPoints[index])
            // Physics and collision
            guard let _ = setupPhysics(onMonster: monster) else { return }
            
            // Movement
            monster.run(getMonsterMoveChainDespawnSequence(), withKey: "MoveDespawn")
            
        }
        
        print("touchesBegan:: end")
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("GameScene:: touchesEnded begin")
        guard let firstTouch = touches.first else { return }
        let touchLocationInScene = firstTouch.location(in: self)
        
        let projectile = shootProjectile(at: touchLocationInScene)
        print("GameScene:: touchesEnded end")
        
        // Physics and detection
        guard let _: SKPhysicsBody = setupPhysics(onProjectile: projectile) else { return }
        
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
// - MARK: Monstera
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
    func getMonsterMoveChainDespawnSequence() -> SKAction {
        // Sequence of multiple actions is also an SKAction
        return SKAction.sequence([
            getMonsterMoveAction(),
            getDespawnMonsterAction()
        ])
    }
    func getDespawnMonsterAction() -> SKAction {
        // Removes node from the parent. e.g. SCNNode mob that runs this action.
        return SKAction.removeFromParent()
    }
    func getMonsterMoveAction() -> SKAction {
        print("movin", size)
        // Strange behaviour depending on portrait landscape. landscape seems to work as expected.
        // Monster movement
        let moveDurationRandom = TimeInterval(random(min: 1.0, max: 6.5)) // feels redundant
        let moveDestination = CGPoint(x: size.width / 2, y: size.height / 2) // 768,1024 ends up near the tap point of 470,0 ... Strange
        let moveAction = SKAction.move(to: moveDestination, duration: moveDurationRandom)
        
        return moveAction
    }
}
// Generalise the commonalities between monster player and projectiles. Mob and projectiles?
// - MARK: Projectiles
extension GameScene {
    func shootProjectile(at proposedTarget: CGPoint) -> SKSpriteNode {
        let projectile = SKSpriteNode(imageNamed: "projectile")
        projectile.position = player.position
        let directionalOffset = proposedTarget - projectile.position
        
        // Set up vectors for directional shooting and movement action.
        let direction = directionalOffset.normalized()
        let shootDistance: CGPoint = direction * size.width // arbitrary distance to go the distance... and hit the target
        let destination: CGPoint = shootDistance + projectile.position
        
        // Attach the projectile to view the spawning shoot effect)
        addChild(projectile)
        
        // Shoot motion
        let projectileArbitrarySpeedRatioSecs = TimeInterval(2.0)
        let projectileMoveAction = SKAction.move(to: destination, duration: projectileArbitrarySpeedRatioSecs)
        let projectileDone = SKAction.removeFromParent()
        let projectileShootActionsDoneChain = SKAction.sequence([projectileMoveAction, projectileDone])

        projectile.run(projectileShootActionsDoneChain, withKey: "ShootDone")
        
        return projectile
    }
//    func projectileMoveActionsDoneChain() -> SKAction {
//
//    }
}

// - MARK: Mob Physics and collision detection
extension GameScene: SKPhysicsContactDelegate {
    func setupPhysics(onMonster monster: SKSpriteNode) -> SKPhysicsBody? {
        monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
        
        guard let monsterPhysics = monster.physicsBody else { return nil }
        monsterPhysics.isDynamic = true
        monsterPhysics.categoryBitMask = PhysicsCategory.monster
        // Intersection notification on AND the bit categories.
        monsterPhysics.contactTestBitMask = PhysicsCategory.projectile
        // Bouncy contact
        monsterPhysics.collisionBitMask = PhysicsCategory.none
        
        return monsterPhysics // returns the physicsbody configured.
    }
    
    func setupPhysics(onProjectile projectile: SKSpriteNode) -> SKPhysicsBody? {
        let projectilePhysics = SKPhysicsBody(circleOfRadius: projectile.size.width)
        
        projectilePhysics.isDynamic = true
        projectilePhysics.categoryBitMask = PhysicsCategory.projectile
        projectilePhysics.contactTestBitMask = PhysicsCategory.monster
        
        // seems redundant to test contact with both monster->projectile and projectile->monster
        // rip tutorial games programming where is good software design patterns complexity
        projectilePhysics.collisionBitMask = PhysicsCategory.none
        // Precision important for fast moving phys clipping detection issues
        projectilePhysics.usesPreciseCollisionDetection = true
        
        // oops
        projectile.physicsBody = projectilePhysics
        
        return projectilePhysics
    }
    
    func projectileDidCollide(projectile: SKSpriteNode, hit monster: SKSpriteNode) {
        print("Pew pew hit")
        projectile.removeFromParent()
        monster.removeFromParent()
    }
    func didBegin(_ contact: SKPhysicsContact) {
        print("Pew pew contact", contact)
        
    }
}

