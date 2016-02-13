//
//  ViewController.swift
//  Calculator
//
//  Created by Kaleb Bataran on 2/4/16.
//  Copyright © 2016 kaydot. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
	
	//Outlets
	@IBOutlet weak var calcDisplay: UILabel!

	var btnSound: AVAudioPlayer!
	
	//Properties
	var leftNumber = ""
	var rightNumber = ""
	var prevOperator = ""
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		calcDisplay.text = ""
		
		//Button sound
		let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
		let soundURL = NSURL(fileURLWithPath: path!)
		do {
			try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
			btnSound.prepareToPlay()
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	@IBAction func numberPressed(btn: UIButton) {
		
		//no leading zeros
		if rightNumber == "" && btn.tag == 0 {
			return
		}
	
		rightNumber += "\(btn.tag)"
		calcDisplay.text = rightNumber
		playSound()
		
	}
	
	@IBAction func clearButtonPressed(sender: AnyObject) {
		
		playSound()
		leftNumber = ""
		rightNumber = ""
		calcDisplay.text = rightNumber
		prevOperator = ""
		
	}
	
	func runLogic(op: String) {
		
		playSound()
		
		if prevOperator == "" {
			prevOperator = op
			leftNumber = rightNumber
			rightNumber = ""
			return
		}
		
		if rightNumber != "" {
			
			if prevOperator == "/" {
				leftNumber = "\(Double(leftNumber)! / Double(rightNumber)!)"
				
			} else if prevOperator == "*" {
				leftNumber = "\(Double(leftNumber)! * Double(rightNumber)!)"
				
			} else if prevOperator == "+" {
				leftNumber = "\(Double(leftNumber)! + Double(rightNumber)!)"
				
			} else if prevOperator == "-" {
				leftNumber = "\(Double(leftNumber)! - Double(rightNumber)!)"
				
			}
			
			calcDisplay.text = leftNumber
			rightNumber = ""
			
		}
		
		prevOperator = op
	}
	
	@IBAction func equalsButtonPressed(sender: AnyObject) {
		runLogic("=")
	}
	
	@IBAction func divideButtonPressed(sender: AnyObject) {
		runLogic("/")
	}
	
	@IBAction func multiplyButtonPressed(sender: AnyObject) {
		runLogic("*")
	}
	
	@IBAction func addButtonPressed(sender: AnyObject) {
		runLogic("+")
	}
	
	@IBAction func	subtractButtonPressed(sender: AnyObject){
		runLogic("-")
	}

	func playSound(){
		
		if btnSound.playing{
			btnSound.stop()
		}
		btnSound.play()
		
	}

}

