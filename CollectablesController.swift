//
//  CollectablesController.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/17/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class CollectablesController {

    // Spawning Coins and Lifes
    func getCollectable() -> SKSpriteNode {
        
        var collectable = SKSpriteNode()
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 7)) >= 4 {
            //Spawn Life
            if GameplayController.instance.life! < 2 {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
                
            } else {
                collectable.name = "Empty"
            }
            //Spawn Coin
        } else {
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
        }

        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.darkCloudAndCollectables
        collectable.physicsBody?.collisionBitMask = ColliderType.player
        collectable.physicsBody?.contactTestBitMask = ColliderType.player
        collectable.zPosition = 2
        
        return collectable
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

}
