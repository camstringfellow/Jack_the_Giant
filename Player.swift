//
//  Player.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/14/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let player: UInt32 = 0
    static let cloud: UInt32 = 1
    static let darkCloudAndCollectables: UInt32 = 2
}

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    private var lastY = CGFloat()
    
    func initilizePlayerAndAnimation() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        //definie physics body as rectangle around player
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 50, height: self.size.height - 5))
        self.physicsBody?.affectedByGravity = true
        //who is the physics body
        self.physicsBody?.categoryBitMask = ColliderType.player
        //what stops it
        self.physicsBody?.collisionBitMask = ColliderType.cloud
        //alert when contacted
        self.physicsBody?.contactTestBitMask = ColliderType.darkCloudAndCollectables
        //doesnt topple over when falling
        self.physicsBody?.allowsRotation = false
        //stops player from bouncing
        self.physicsBody?.restitution = 0
        
        
        
        lastY = self.position.y
        
    }
    
    //flips through pictures making him walk
    func animatePlayer(moveLeft: Bool) {
        
        //flip player
        if moveLeft {
            //left
            self.xScale = -fabs(self.xScale)
        } else {
            //right
            self.xScale = fabs(self.xScale)
        }
        
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    //stops walking
    func stopPlayerAnimation() {
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func movePlayer(moveLeft: Bool) {
        
        if moveLeft {
            self.position.x -= 7
        } else {
            self.position.x += 7
        }
    }
    
    func setScore() {
        if self.position.y < lastY {
            GameplayController.instance.incrementScore()
            lastY = self.position.y 
        }
    }
    
}
