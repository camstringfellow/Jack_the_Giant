//
//  GameplayScene.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/14/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {
    
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
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    //Clouds
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-115)
    let maxX = CGFloat(115)
    
    
    override func didMove(to view: SKView) {
        initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            } else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
        }
        canMove = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initializeVariables() {
        center = (self.scene?.size.height)! / (self.scene?.size.width)!
        
        //initilize palyer
        player = self.childNode(withName: "Player") as? Player!
        player?.initilizePlayerAndAnimation()

        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode!
        
        //continuous background
        getBackgrounds()
        
        cloudsController.arrageCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
        
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
    }
    
    // move camera downwards
    func moveCamera() {
        self.mainCamera?.position.y -= 3
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
            
            cloudsController.arrageCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
        
    }
    
    
}














