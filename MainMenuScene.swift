//
//  MainMenuScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/16/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit


class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name ==  "Start Game" {
                
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenHorizontal(withDuration: 1))
                
            }
            
            if atPoint(location).name ==  "High Score" {
                
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1))
                
            }
            
            if atPoint(location).name ==  "Options" {
                
                let scene = OptionsScene(fileNamed: "OptionsScene")
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1))
                
            }
            
            // QUIT BUTTON
            
        }
        
    }
    
}



