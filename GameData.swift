//
//  GameData.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 9/1/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import Foundation

class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultScore = "EasyDifficultScore"
        static let MediumDifficultScore = "MediumDifficultScore"
        static let HardDifficultScore = "HardDifficultScore"

        static let EasyDifficultCoinScore = "EasyDifficultCoinScore"
        static let MediumDifficultCoinScore = "MediumDifficultCoinScore"
        static let HardDifficultCoinScore = "HardDifficultCoinScore"
        
        static let EasyDifficult = "EasyDifficult"
        static let MediumDifficult = "MediumDifficult"
        static let HardDifficult = "HardDifficult"
        
        static let Music = "Music"
        
    }
    
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()
    
    private var easyDifficulty = false
    private var mediumDifficulty = false
    private var hardDifficulty = false
    
    private var isMusicOn = false
    
    override init() {}
    
    //Load all data for specified keys
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultScore)
        self.easyDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultCoinScore)
       
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultScore)
        self.mediumDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultCoinScore)
        
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultScore)
        self.hardDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultCoinScore)
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficult)
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficult)
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficult)
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music)
        
    }
    
    
    //Called when we save our data
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.easyDifficultyScore, forKey: Keys.EasyDifficultScore)
        aCoder.encode(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultCoinScore)
        
        aCoder.encode(self.mediumDifficultyScore, forKey: Keys.MediumDifficultScore)
        aCoder.encode(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultCoinScore)
        
        aCoder.encode(self.hardDifficultyScore, forKey: Keys.HardDifficultScore)
        aCoder.encode(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultCoinScore)
        
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficult)
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficult)
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficult)
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music)
        
        
    }
    
    //Easy Difficulty
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore
    
    }
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.easyDifficultyCoinScore
    }
    
    //Medium Difficulty
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore
        
    }
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.mediumDifficultyCoinScore
    }
    
    //Hard Difficulty
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore
        
    }
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.hardDifficultyCoinScore
    }
    
    func setEasyDifficulty(easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty
    }
    
    func setHardDifficulty(hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty
    }
    
    func setIsMusicOn(isMusicOn: Bool) {
        self.isMusicOn = isMusicOn
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }
    
}






