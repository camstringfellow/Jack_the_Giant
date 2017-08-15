//
//  Player.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/14/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    
    func initilizePlayerAndAnimation() {
        
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
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
}
