//
//  SSViewController.swift
//  NyanAway
//
//  Created by Ramon Gebben on 22/07/15.
//  Copyright (c) 2015 PindakaasGang. All rights reserved.
//

import UIKit
import AVFoundation

class SSViewController: UIViewController {
    
    @IBOutlet var displayTimeLabel: UILabel!
    var startTime = NSTimeInterval()
    var timer:NSTimer = NSTimer()
    var ding:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAudio()
        ding.play()
        startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(sender: AnyObject) {
        startTimer()
    }
    
    @IBAction func stop(sender: AnyObject) {
        stopTimer()
    }
    
    func startTimer(){
        if (!timer.valid) {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
        
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        displayTimeLabel.text = strMinutes+":"+strSeconds+":"+strFraction
    }
    
    func prepareAudio() {
        var path = NSBundle.mainBundle().pathForResource("ding", ofType: "mp3")
        ding = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: path!), error: nil)
        ding.prepareToPlay()
    }
    
}