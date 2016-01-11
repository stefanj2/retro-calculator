//
//  ViewController.swift
//  retro-calculator
//
//  Created by Stefan Jansen on 1/11/16.
//  Copyright © 2016 Stefan Jansen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case empty = "empty"
        
    }
    
    var btnSound: AVAudioPlayer! //button audio
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.empty
    var result = ""
    
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: AnyObject) {
        playsound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onClearPress(sender: AnyObject) {
    playsound()
    clear()
    }
    
    
    @IBAction func onDividePress(sender: AnyObject) {
        proccesOperation(Operation.Divide)
    }
    @IBAction func onMultiplyPress(sender: AnyObject) {
        proccesOperation(Operation.Multiply)
    }
    @IBAction func OnSubtractPress(sender: AnyObject) {
        proccesOperation(Operation.Subtract)
    }
    @IBAction func onAddPress(sender: AnyObject) {
        proccesOperation(Operation.Add)
    }
    @IBAction func onEqualPres(sender: AnyObject) {
        proccesOperation(currentOperation)
    }
 
    func proccesOperation(op: Operation) {
        
        if currentOperation != Operation.empty {
            // run some math
            
            if runningNumber != "" {
            
            rightValStr = runningNumber
            runningNumber = ""
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
           
                
                
                }
            
            leftValStr = result
            outputLbl.text = result
            
            currentOperation = op
            }
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    
        
    }
    func clear() {
        runningNumber = ""
        result = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.empty
        outputLbl.text = "0"
    }
    
    func playsound() {
        if btnSound.playing {
            btnSound.stop()
            btnSound.play()
        } else {
            btnSound.play()
        }
        
    }
    




}
  



