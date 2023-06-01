//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer = AVAudioPlayer()
    
    var timer = Timer()
    var secondsRemaining = 0
    var totalTime = 300
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressBar.progress = 0

        titleLabel.text = sender.currentTitle!

        totalTime = eggTimes[sender.currentTitle!]!
    
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsRemaining < totalTime {
            secondsRemaining += 1
            progressBar.progress = Float(secondsRemaining) / Float(totalTime)
        } else {
            timer.invalidate()

            titleLabel.text = "DONE!"

            playAlarm()

        }
    }
    
    func playAlarm() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {return}
        
        do {
            player  = try AVAudioPlayer(contentsOf:  url, fileTypeHint: AVFileType.wav.rawValue)
            
            player.play()
            
            titleLabel.text = "How do you like your eggs?"
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
