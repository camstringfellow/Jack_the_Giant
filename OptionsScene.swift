//
//  OptionsScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/16/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class OptionsScene: SKScene {
    
    private var easyBtn: SKSpriteNode?
    private var mediumBtn: SKSpriteNode?
    private var hardBtn: SKSpriteNode?
    
    private var sign: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        initializeVariables()
        setSign()
    }
    
    func initializeVariables() {
        
        easyBtn = self.childNode(withName: "Easy Button") as? SKSpriteNode!
        mediumBtn = self.childNode(withName: "Medium Button") as? SKSpriteNode!
        hardBtn = self.childNode(withName: "Hard Button") as? SKSpriteNode!
        sign = self.childNode(withName: "Sign") as? SKSpriteNode!
    }
    
    func setSign() {
        
        if GameManager.instance.getEasyDifficulty() == true {
            sign?.position.y = (easyBtn?.position.y)!
        } else if GameManager.instance.getMediumDifficulty() == true {
            sign?.position.y = (mediumBtn?.position.y)!
        } else if GameManager.instance.getHardDifficulty() == true {
            sign?.position.y = (hardBtn?.position.y)!
        }
        
        
    }
    
    private func setDifficulty(difficulty: String) {
        switch difficulty {
        case "easy":
            GameManager.instance.setEasyDifficulty(easyDifficulty: true)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: false)
            GameManager.instance.setHardDifficulty(hardDifficulty: false)
            
            //break
        case "medium":
            GameManager.instance.setEasyDifficulty(easyDifficulty: false)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: true)
            GameManager.instance.setHardDifficulty(hardDifficulty: false)
           // break
        case "hard":
            GameManager.instance.setEasyDifficulty(easyDifficulty: false)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: false)
            GameManager.instance.setHardDifficulty(hardDifficulty: true)
         //   break
        default:
            break
        }
        GameManager.instance.saveData()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            //easy button
            if atPoint(location) == easyBtn {
                sign?.position.y = (easyBtn?.position.y)!
                setDifficulty(difficulty: "easy")
            }
            //medium button
            if atPoint(location) == mediumBtn {
                sign?.position.y = (mediumBtn?.position.y)!
                setDifficulty(difficulty: "medium")
            }
            //hard button
            if atPoint(location) == hardBtn {
                sign?.position.y = (hardBtn?.position.y)!
                setDifficulty(difficulty: "hard")
            }
            
            sign?.zPosition = 4
            
            //back button
            if atPoint(location).name ==  "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1))
            }
        }
    }
    
    
    
}
