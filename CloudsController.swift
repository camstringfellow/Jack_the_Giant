//
//  CloudsController.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/15/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class CloudsController {

    var lastCloudPositionY = CGFloat()
    
    func shuffle( cloudsArray: [SKSpriteNode]) -> [SKSpriteNode] {
        
        //        for var i = cloudsArray.count - 1; i > 0; i-- {
        var cloudsArray = cloudsArray
        
        for i in (1...cloudsArray.count-1).reversed() {
            
            let j = Int(arc4random_uniform(UInt32(i-1)))
        
            swap(&cloudsArray[i], &cloudsArray[j])

        }
        
        return cloudsArray
    }
    
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    func createClouds() -> [SKSpriteNode] {
        
        var clouds = [SKSpriteNode]()
        
        //for i = 0; i < 2; i++
        for i in 0..<2 {
            
            let cloud1 = SKSpriteNode(imageNamed: "Cloud 1")
            cloud1.name = "1"
            let cloud2 = SKSpriteNode(imageNamed: "Cloud 2")
            cloud2.name = "2"
            let cloud3 = SKSpriteNode(imageNamed: "Cloud 3")
            cloud3.name = "3"
            let darkCloud = SKSpriteNode(imageNamed: "Dark Cloud")
            darkCloud.name = "Dark Cloud"
            
            cloud1.xScale = 0.9
            cloud1.yScale = 0.9
            cloud2.xScale = 0.9
            cloud2.yScale = 0.9
            cloud3.xScale = 0.9
            cloud3.yScale = 0.9
            darkCloud.xScale = 0.9
            darkCloud.yScale = 0.9
            
            // add physics bodies to clouds
            
            clouds.append(cloud1)
            clouds.append(cloud2)
            clouds.append(cloud3)
            clouds.append(darkCloud)
        }
        
        clouds = shuffle(cloudsArray: clouds)
        
        return clouds
    }
    
    
    func arrageCloudsInScene(scene: SKScene, distanceBetweenClouds: CGFloat, center: CGFloat, minX: CGFloat, maxX: CGFloat, initialClouds: Bool) {
        
        var clouds = createClouds()
        var positionY = CGFloat()
        
        //check to make sure Dark Cloud isnt first cloud
        if initialClouds {
            
            while(clouds[0].name == "Dark Cloud") {
                //shuffle cloud array
                clouds = shuffle(cloudsArray: clouds)
            }
        }
        
        //initialize cloud position
        if initialClouds {
            positionY = center - 100
        } else {
            positionY = lastCloudPositionY
        }
        
        var random = 0
        
        for i in 0...clouds.count - 1 {
            
            var randomX = CGFloat()
            
            if random == 0 {
                randomX = randomBetweenNumbers(firstNum: center + 90, secondNum: maxX)
                random = 1
            } else if random == 1 {
                randomX = randomBetweenNumbers(firstNum: center - 90, secondNum: minX)
                random = 0
            }
            
            
            //set cloud position
            clouds[i].position = CGPoint(x: randomX, y: positionY)
            clouds[i].zPosition = 3
            
            //add clouds to scene
            scene.addChild(clouds[i])
            //create new cloud location
            positionY -= distanceBetweenClouds
            lastCloudPositionY = positionY
        }
     }
     
}
