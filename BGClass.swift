//
//  BG Class.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/15/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class BGClass: SKSpriteNode {
    
    // Creates a continuous loop for the background
    func moveBG(camera: SKCameraNode){
        if self.position.y - self.size.height > camera.position.y {
            self.position.y -= self.size.height * 3
            
        }
    }
    
}
