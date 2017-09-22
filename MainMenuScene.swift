//
//  MainMenuScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/16/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit


class MainMenuScene: SKScene {
    
    private var musicBtn: SKSpriteNode?
    private let musicOn = SKTexture(imageNamed: "Music On Button")
    private let musicOff = SKTexture(imageNamed: "Music Off Button")
    
    
    override func didMove(to view: SKView) {
        musicBtn = self.childNode(withName: "Music") as? SKSpriteNode
        GameManager.instance.initalizeGameData()
        setMusic()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name ==  "Start Game" {
                
                GameManager.instance.gameStartedFromMainMenu = true
                
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenHorizontal(withDuration: 1))
                
            }
            
            if atPoint(location).name ==  "High Score" {
                
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.left, duration: 1))
                
            }
            
            if atPoint(location).name ==  "Options" {
                
                let scene = OptionsScene(fileNamed: "OptionsScene")
                
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                
                scene?.scaleMode = .aspectFill
                
                self.view?.presentScene(scene!, transition: SKTransition.push(with: SKTransitionDirection.right, duration: 1))
                
            }
            
            //if user clicks music button
            if atPoint(location) == musicBtn {
                handleMusicButton()
            }
            
        }
        
    }
    
    private func setMusic() {
        if GameManager.instance.getIsMusicOn() {
            
            if AudioManager.instance.isAudioPlayerInitialized() {
            
            AudioManager.instance.playBGMusic()
            musicBtn?.texture = musicOff
            
            }
        }
    }
    
    private func handleMusicButton() {
        if GameManager.instance.getIsMusicOn() {
            //the music is playing, turn it off
            AudioManager.instance.stopBGMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: false)
            musicBtn?.texture = musicOn
        } else {
            //the music is not playing, turn it on
            AudioManager.instance.playBGMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: true)
            musicBtn?.texture = musicOff
        }
        
        GameManager.instance.saveData()
        
    }

    
}



