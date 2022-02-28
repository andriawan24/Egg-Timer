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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressTimer: UIProgressView!
    @IBOutlet weak var retryButton: UIButton!
    
    var player: AVPlayer!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var secondsRemaining = 0
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        progressTimer.progress = 0.0
        progressTimer.isHidden = true
        retryButton.isHidden = true
    }
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        timer.invalidate()
        
        if let hardness = sender.currentTitle {
            if let score = eggTimes[hardness] {
                timerLabel.text = hardness
                totalTime = score
                startCountDown()
            }
        }
    }
    
    @IBAction func onRetryClicked(_ sender: UIButton) {
        
        player.pause()
        timerLabel.text = "How do you like your eggs?"
        progressTimer.isHidden = true
        retryButton.isHidden = true
    }
    
    func startCountDown() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressTimer.isHidden = false
            progressTimer.progress = percentageProgress
            retryButton.isHidden = true
            secondsPassed += 1
        } else {
            progressTimer.progress = 0.0
            progressTimer.isHidden = true
            timerLabel.text = "DONE!"
            secondsPassed = 0
            retryButton.isHidden = false
            playSound()
            timer.invalidate()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = AVPlayer.init(url: url!)
        player.play()
    }
}
