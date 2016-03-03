//
//  ViewController.swift
//  iosStopWatchApp
//
//  Created by 桑古　昌輝 on 2016/03/02.
//  Copyright © 2016年 桑古　昌輝. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var startTime: NSTimeInterval? = nil
    var timer: NSTimer? = nil
    var elapsedTime: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonEnabled(true, stop: false, reset: false)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update() {
        if let t = self.startTime {
            let time: Double = NSDate.timeIntervalSinceReferenceDate() - t + self.elapsedTime
            let sec: Int = Int(time)
            let msec: Int = Int((time - Double(sec)) * 100.0)
            
            self.timerLabel.text = NSString(format: "%02d:%02d:%02d", sec/60, sec%60, msec) as String
        }
    }
    
    func setButtonEnabled(start:Bool, stop:Bool, reset:Bool) {
        self.startButton.enabled = start
        self.stopButton.enabled = stop
        self.resetButton.enabled = reset
        
    }
    
    @IBAction func startTimer(sender: AnyObject) {
        self.startTime =
            NSDate.timeIntervalSinceReferenceDate()
        self.timer =
            NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        setButtonEnabled(false, stop: true, reset: false)
    }
    
    @IBAction func stopTimer(sender: AnyObject) {
        setButtonEnabled(true, stop: false, reset: true)
        if let t = self.startTime {
            self.elapsedTime += NSDate.timeIntervalSinceReferenceDate() - t
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    @IBAction func resetTimer(sender: AnyObject) {
        self.startTime = nil
        self.elapsedTime = 0.0
        self.timerLabel.text = "00:00:00"
        setButtonEnabled(true, stop: false, reset: false)
    }

}

