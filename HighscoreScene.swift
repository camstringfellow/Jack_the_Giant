//
//  HighscoreScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/16/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var scoreLabel: SKLabelNode?
    private var coinLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        // High score for given difficulty
        getReference()
        setScore()
        
    }
    
    private func getReference() {
        scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode!
        coinLabel = self.childNode(withName: "Coin Label") as? SKLabelNode!
    }
    
    private func setScore() {
        if GameManager.instance.getEasyDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getEasyDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getEasyDifficultyCoinScore())
        } else if GameManager.instance.getMediumDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getMediumDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getMediumDifficultyCoinScore())
        } else if GameManager.instance.getHardDifficulty() == true {
            scoreLabel?.text = String(GameManager.instance.getHardDifficultyScore())
            coinLabel?.text = String(GameManager.instance.getHardDifficultyCoinScore())
        }
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
