//
//  CircleImage.swift
//  CatchItGameApp
//
//  Created by kutayyaman on 22.08.2020.
//  Copyright © 2020 kutayyaman. All rights reserved.
//

import Foundation
import UIKit
class CircleImage{
    var screenHeight:Int
    var screenWidht:Int
    var circleWidth:Int
    var circleHeight:Int
    let imagePath:String
    let image : UIImage?
    let imageView : UIImageView?
    var x:Int
    var y:Int
    
    
    init(screenHeight:Int,screenWidht:Int,circleWidth:Int,circleHeight:Int,imagePath:String,x:Int,y:Int) {
        self.screenHeight=screenHeight
        self.screenWidht=screenWidht
        self.circleWidth=circleWidth
        self.circleHeight=circleHeight
        self.imagePath=imagePath
        self.x=x
        self.y=y
        
        if let myImage = UIImage(named: self.imagePath){
            self.image = myImage
            self.imageView = UIImageView(image: self.image)
            imageView?.frame=CGRect(x: x, y: y, width: self.circleWidth, height: self.circleHeight)
            imageView?.isUserInteractionEnabled=true
        }else{
            image=nil
            imageView=nil
        }
        
    }
    
    func hideImage()  {
        imageView?.isHidden=true
    }
    func showImage(){
        imageView?.isHidden=false
    }
    func changeLocationOfImageRandomly(){
        let xStart = self.circleWidth
        let xEnd = self.screenWidht - (self.circleWidth)
        let yStart = self.circleHeight
        let yEnd = self.screenHeight - (self.circleHeight)
        let x = Int.random(in: xStart...xEnd)
        let y = Int.random(in: yStart...yEnd)
        imageView?.frame=CGRect(x: x, y: y, width: self.circleWidth, height: self.circleHeight)
    }
    func addGestureRecognizer(recognizer : UITapGestureRecognizer){
        imageView?.addGestureRecognizer(recognizer)
        
    }
    
}
