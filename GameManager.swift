//
//  GameController.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 8/17/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager()
    private init() {}
    
    private var gameData: GameData?
    
    var gameStartedFromMainMenu = false
    var gameRestartedPlayerDied = false
    
    func initalizeGameData() {
        
        if !FileManager.default.fileExists(atPath: getFilePath()) {
            //set up game with inital values
            gameData = GameData()
            
            gameData?.setEasyDifficultyScore(easyDifficultyScore: 0)
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0)
            
            gameData?.setMediumDifficultyScore(mediumDifficultyScore: 0)
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0)
            
            gameData?.setHardDifficultyScore(hardDifficultyScore: 0)
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0)
            
            gameData?.setEasyDifficulty(easyDifficulty: false)
            gameData?.setMediumDifficulty(mediumDifficulty: true)
            gameData?.setHardDifficulty(hardDifficulty: false)
            
            gameData?.setIsMusicOn(isMusicOn: false)
            
            saveData()
            
        }
        
        loadData()
        
    }
    
    
    // Save and load data
    func loadData() {
        //set game data
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath()) as? GameData
    }
    
    //Calls encode
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath())
        }
        
    }
    
    private func  getFilePath() -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return (url?.appendingPathComponent("Game Manager").path)!
    }
    
    //EASY
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.gameData?.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore)
    }
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyCoinScore)
    }
    func getEasyDifficultyScore() -> Int32 {
        return (self.gameData?.getEasyDifficultyScore())!
    }
    func getEasyDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getEasyDifficultyCoinScore())!
    }
    //MEDIUM
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.gameData?.setMediumDifficultyScore(mediumDifficultyScore: mediumDifficultyScore)
    }
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumDifficultyCoinScore)
    }
    func getMediumDifficultyScore() -> Int32 {
        return (self.gameData?.getMediumDifficultyScore())!
    }
    func getMediumDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getMediumDifficultyCoinScore())!
    }
    //HARD
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.gameData?.setHardDifficultyScore(hardDifficultyScore: hardDifficultyScore)
    }
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardDifficultyCoinScore)
    }
    func getHardDifficultyScore() -> Int32 {
        return (self.gameData?.getHardDifficultyScore())!
    }
    func getHardDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getHardDifficultyCoinScore())!
    }
    
    func setEasyDifficulty(easyDifficulty: Bool) {
        gameData?.setEasyDifficulty(easyDifficulty: easyDifficulty)
    }
    func getEasyDifficulty() -> Bool {
        return (gameData?.getEasyDifficulty())!
    }
    func setMediumDifficulty(mediumDifficulty: Bool) {
        gameData?.setMediumDifficulty(mediumDifficulty: mediumDifficulty)
    }
    func getMediumDifficulty() -> Bool {
        return (gameData?.getMediumDifficulty())!
    }
    func setHardDifficulty(hardDifficulty: Bool) {
        gameData?.setHardDifficulty(hardDifficulty: hardDifficulty)
    }
    func getHardDifficulty() -> Bool {
        return (gameData?.getHardDifficulty())!
    }
    
    func setIsMusicOn(isMusicOn: Bool) {
        gameData?.setIsMusicOn(isMusicOn: isMusicOn)
    }
    func getIsMusicOn() -> Bool {
        return (gameData?.getIsMusicOn())!
    }
    
    
    
}
















