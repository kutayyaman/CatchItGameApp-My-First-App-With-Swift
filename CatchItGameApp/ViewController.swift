//
//  ViewController.swift
//  CatchItGameApp
//
//  Created by kutayyaman on 22.08.2020.
//  Copyright © 2020 kutayyaman. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabelAsil: UILabel!
    @IBOutlet var completeOfView: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    //games objects,etc
    var isGameStart=false
    var greenCircleImage:CircleImage?=nil
    var redCircleImage:CircleImage?=nil
    
    //Timer
    var timer = Timer()
    var gecenSure=0.0
    var timeInterval=1.0
    var score=0
    
    //GestureRecognizer
    var gestureRecognizerForRedCircle:UITapGestureRecognizer?=nil
    var gestureRecognizerForGreenCircle:UITapGestureRecognizer?=nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let highScore = UserDefaults.standard.object(forKey: "highScore")
        if let myHighScore = highScore as? String{
            highScoreLabel.text = myHighScore
        }
        greenCircleImage=CircleImage(screenHeight: Int(self.view.frame.size.height), screenWidht: Int(self.view.frame.size.width), circleWidth: 60, circleHeight: 60, imagePath: "yesil.png", x:100,y:100)
        if let imageView = greenCircleImage?.imageView{
            view.addSubview(imageView)
        }
        redCircleImage=CircleImage(screenHeight: Int(self.view.frame.size.height), screenWidht: Int(self.view.frame.size.width), circleWidth: 60, circleHeight: 60, imagePath: "kirmizi.png",x:200,y:200)
        if let imageView2 = redCircleImage?.imageView{
            view.addSubview(imageView2)
        }
        
        greenCircleImage?.changeLocationOfImageRandomly()
        redCircleImage?.changeLocationOfImageRandomly()
        
        gestureRecognizerForRedCircle = UITapGestureRecognizer(target: self, action: #selector(redCircleTapped))
        gestureRecognizerForGreenCircle = UITapGestureRecognizer(target: self, action: #selector(greenCircleTapped))
        
        greenCircleImage?.addGestureRecognizer(recognizer: gestureRecognizerForGreenCircle!)
        redCircleImage?.addGestureRecognizer(recognizer: gestureRecognizerForRedCircle!)
        completeOfView.addGestureRecognizer(gestureRecognizerForRedCircle!)
    }
    
    @objc func redCircleTapped(){
        if(startButton.isHidden){
            startButton.isHidden=false
            timer.invalidate()
            if let highScoreLabelText=highScoreLabel.text{
                if let highScoreLabelTextInt=Int(highScoreLabelText) {
                    if score > highScoreLabelTextInt {
                        UserDefaults.standard.set("\(score)", forKey: "highScore")
                        highScoreLabel.text = String(score)
                        
                        
                    }
                }
            }
            let alert = UIAlertController(title: "Game Over", message: "Good Luck To Next Time", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.replay()
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert,animated: true,completion: nil)
        }
        
    }
    @objc func greenCircleTapped(){
        if(startButton.isHidden){
            score+=1
            scoreLabelAsil.text=String(score)
        }
        
        
    }

    func replay(){
        score=0
        scoreLabelAsil.text="0"
        startButton.isHidden=true
        greenCircleImage?.changeLocationOfImageRandomly()
        redCircleImage?.changeLocationOfImageRandomly()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    @IBAction func startButtonClicked(_ sender: Any) {
        replay()
    }
    @objc func timerFunction(){
        if Bool.random() {
            greenCircleImage?.hideImage()
            redCircleImage?.showImage()
            if Bool.random(){
                greenCircleImage?.showImage()
            }
        }
        else{
            greenCircleImage?.showImage()
            redCircleImage?.hideImage()
            if Bool.random(){
                redCircleImage?.showImage()
            }
        }
        greenCircleImage?.changeLocationOfImageRandomly()
        redCircleImage?.changeLocationOfImageRandomly()
        gecenSure+=timeInterval;
        if(timeInterval>0.5){
        if Int(gecenSure)%5==0 {
            timer.invalidate()
            timeInterval=0.98*timeInterval
            timer=Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
            }
        }
        else{
            
        }
    }
}

