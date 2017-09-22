//
//  GameplayScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/14/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudsController()
    
    //Camera
    var mainCamera:SKCameraNode?
    
    //Background
    var bg1: BGClass?
    var bg2: BGClass?
    var bg3: BGClass?
    
    //Player
    var player: Player?
    var canMove = false
    var moveLeft = false
    
    var center: CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private let minPlayerX = CGFloat(-214)
    private let maxPlayerX = CGFloat(214)
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    private var pausePanel = SKSpriteNode()
    
    //Clouds
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-115)
    let maxX = CGFloat(115)
    
    
    override func didMove(to view: SKView) {
        initializeVariables()
        physicsWorld.contactDelegate = self
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        print("didEndContact was called")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("didBegin was called")
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        //if the first node that makes contact's name is "Player"
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            //Play the life sound
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
            //increment the life score
            GameplayController.instance.incrementLife()
            //remove life from game
            secondBody.node?.removeFromParent()
            
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            //Play the coin sound
            self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
            //increment the coin score
            GameplayController.instance.incrementCoin()
            //remove coin from game
            secondBody.node?.removeFromParent()
        
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            
            //Kill the player
            
            //pause the scene
            self.scene?.isPaused = true
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(String(describing: GameplayController.instance.life!))"
            } else {
                // Show end score panel
                createEndScorePanel()
            }
            
            firstBody.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
            
            
            
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            // --- PLAYER ACTION --- //
            
            if atPoint(location).name != "Pause" && atPoint(location).name != "Resume" && atPoint(location).name != "Quit" {
                
                if self.scene?.isPaused == false {
                    if location.x > center! {
                        moveLeft = false
                        player?.animatePlayer(moveLeft: moveLeft)
                    } else {
                        moveLeft = true
                        player?.animatePlayer(moveLeft: moveLeft)
                    }
                }
            }
            
            // --- PAUSE BUTTON ACTION --- //
            
            if atPoint(location).name == "Pause" {
                self.scene?.isPaused = true
                
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                
                createPausePanel()
            }
            
            // --- PAUSE MENU ACTIONS --- //
            
            if atPoint(location).name == "Resume" {
                pausePanel.removeFromParent()
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                self.scene?.isPaused = false
            }
            
            if atPoint(location).name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
                scene?.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
        
        canMove = true
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    // --- INITIALIZE VARIABLES -- //
    func initializeVariables() {
        
        //create delegate for physics contact
        physicsWorld.contactDelegate? = self
        
        center = (self.scene?.size.height)! / (self.scene?.size.width)!
        
        //initilize palyer
        player = self.childNode(withName: "Player") as? Player!
        player?.initilizePlayerAndAnimation()

        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        //continuous background
        getBackgrounds()
        
        //get labels
        getLabels()
        
        //initilize coin, score, and life values
        GameplayController.instance.initilizeVariables()
        
        cloudsController.arrageCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
        setCameraSpeed()
        
    }
    
    //continuous background
    func getBackgrounds() {
        bg1 = (self.childNode(withName: "BG1") as? BGClass)!
        bg2 = (self.childNode(withName: "BG2") as? BGClass)!
        bg3 = (self.childNode(withName: "BG3") as? BGClass)!
    }
    
    
    func managePlayer() {
        
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        //Keep player from going off screen right
        if (player?.position.x)! > maxPlayerX {
            player?.position.x = maxPlayerX
        }
        
        //Keep player from going off screen left
        if (player?.position.x)! < minPlayerX {
            player?.position.x = minPlayerX
        }
        
        //if the player goes out of bounds UP
        if (player?.position.y)! - (player?.size.height)! * 3.7 > (mainCamera?.position.y)! {
            //kill player
            print("The player is out of bounds UP")
            //stop(pasue) the game
            self.scene?.isPaused = true
            
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(String(describing: GameplayController.instance.life!))"
            } else {
                // Show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        
        //if the player goes out of bounds DOWN
        if (player?.position.y)! + (player?.size.height)! * 3.7 < (mainCamera?.position.y)! {
            //kill player
            print("The player is out of bounds DOWN")
            //stop(pasue) the game
            self.scene?.isPaused = true
            
            GameplayController.instance.life! -= 1
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(String(describing: GameplayController.instance.life!))"
            } else {
                // Show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
    }
    
    
    // move camera downwards
    func moveCamera() {
        
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        
        self.mainCamera?.position.y -= cameraSpeed
    }
    
 
    //continuous background
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    
    // Creating new clouds
    func createNewClouds() {
        //if we pass where we need to make new clouds
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrageCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: false)
            
            checkForChildsOutOfScreen()
        }
    }
    
    
    func checkForChildsOutOfScreen() {
        
        for child in children {
            
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                
                let childName = child.name?.components(separatedBy: " ")
                
                if childName![0] != "BG" {
                    
                    print("The child that was removed is \(child.name!)")
                    child.removeFromParent()
                }
            }
        }
    }
    
    func getLabels() {
        
        //Connecting the variables in gameplayController to nodes in gameplayScene
        GameplayController.instance.scoreText = self.mainCamera?.childNode(withName: "Score Text") as? SKLabelNode
        GameplayController.instance.lifeText = self.mainCamera?.childNode(withName: "Life Score") as? SKLabelNode
        GameplayController.instance.coinText = self.mainCamera?.childNode(withName: "Coin Score") as? SKLabelNode
    }
    
    
    func createPausePanel() {
        
        //Creates Pause Panel
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel.xScale = 1.6
        pausePanel.yScale = 1.6
        pausePanel.zPosition = 4
        
        pausePanel.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2)
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 5
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeButton.position = CGPoint(x: (pausePanel.position.x), y: (pausePanel.position.y) + 25)
     
        quitButton.name = "Quit"
        quitButton.zPosition = 5
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitButton.position = CGPoint(x: (pausePanel.position.x), y: (pausePanel.position.y) - 45)
        
        pausePanel.addChild(quitButton)
        pausePanel.addChild(resumeButton)
        
        self.mainCamera?.addChild(pausePanel)
    }
    
    func createEndScorePanel() {
        
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8
        endScorePanel.xScale = 1
        endScorePanel.yScale = 1
        
        scoreLabel.fontSize = 50
        scoreLabel.zPosition = 7
        
        coinLabel.fontSize = 50
        coinLabel.zPosition = 7

        scoreLabel.text = "\(GameplayController.instance.score!)"
        coinLabel.text = "\(GameplayController.instance.coin!)"
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        endScorePanel.position = CGPoint(x: (mainCamera?.frame.size.width)! / 2, y: (mainCamera?.frame.size.height)! / 2)
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x + 40, y: endScorePanel.position.y + 55)
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 40, y: endScorePanel.position.y - 60)
        
        mainCamera?.addChild(endScorePanel)
        
        
    }
    
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty() {
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        } else if GameManager.instance.getMediumDifficulty() {
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        } else if GameManager.instance.getHardDifficulty() {
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    @objc private func playerDied() {
        if GameplayController.instance.life! >= 0 {
            
            GameManager.instance.gameRestartedPlayerDied = true
            
            let scene = GameplayScene(fileNamed: "GameplayScene")
            scene?.scaleMode = .aspectFill
            
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1.5))
            
        } else {
            
            if GameManager.instance.getEasyDifficulty() {
               
                let highScore = GameManager.instance.getEasyDifficultyScore()
                let coinScore = GameManager.instance.getEasyDifficultyCoinScore()
                
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setEasyDifficultyScore(easyDifficultyScore: Int32(GameplayController.instance.score!))
                }
                
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32(GameplayController.instance.coin!))
                }
                
            } else if GameManager.instance.getMediumDifficulty() {
                
                let highScore = GameManager.instance.getMediumDifficultyScore()
                let coinScore = GameManager.instance.getMediumDifficultyCoinScore()
                
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setMediumDifficultyScore(mediumDifficultyScore: Int32(GameplayController.instance.score!))
                }
                
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32(GameplayController.instance.coin!))
                }
                
            } else if GameManager.instance.getHardDifficulty() {
                
                let highScore = GameManager.instance.getHardDifficultyScore()
                let coinScore = GameManager.instance.getHardDifficultyCoinScore()
                
                
                if highScore < GameplayController.instance.score! {
                    GameManager.instance.setHardDifficultyScore(hardDifficultyScore: Int32(GameplayController.instance.score!))
                }
                
                if coinScore < GameplayController.instance.coin! {
                    GameManager.instance.setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32(GameplayController.instance.coin!))
                }
                
            }
            
            GameManager.instance.saveData()
            
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene?.scaleMode = .aspectFill
            
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            
        }
    
    }
    
}














