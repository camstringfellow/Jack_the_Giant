//
//  AudioManager.swift
//  Jack the Giant
//
//  Created by Cameron Stringfellow on 9/20/17.
//  Copyright © 2017 Stringfellow. All rights reserved.
//

import AVFoundation

//Must be singleton so that you can access it anywhere in the app
class AudioManager {
    
    static let instance = AudioManager()
    //So no other classes can create an object from this class
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func playBGMusic() {
        
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3")
        
        var err: NSError?
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        } catch let err1 as NSError {
            err = err1
        }
        
        if err != nil {
            print("We have a problem")
        }
        
    }
    
    func stopBGMusic() {
        
        if (audioPlayer?.isPlaying)! {
            audioPlayer?.stop()
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil
    }
    
}
