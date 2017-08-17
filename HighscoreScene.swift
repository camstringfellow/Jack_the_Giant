//
//  HighscoreScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/16/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // High score for given difficulty 
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name ==  "Back" {
                
                let scene = MainMenuScene(fileNamed: "MainMenu")
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1))
                
            }

        }
        
    }
    
}
