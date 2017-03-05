//
//  DiscoverBirdView.swift
//  rainbow-effect
//
//  Created by JaminZhou on 2017/3/5.
//  Copyright © 2017年 Hangzhou Tomorning Technology Co., Ltd. All rights reserved.
//

import UIKit

let KRatio = UIScreen.main.bounds.width/375.0
class DiscoverBirdView: UIView {
    
    var birdView: FLAnimatedImageView!
    var rainbow: UIImageView!
    
    let birdCenterX = -6*KRatio
    let birdTop = 32*KRatio
    let birdWidth = 92*KRatio
    let birdHeight = 106*KRatio

    let rainbowAngle:CGFloat = 36
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        //add rainbow
        rainbow = UIImageView(image: #imageLiteral(resourceName: "rainbow.jpg"))
        rainbow.frame = CGRect(x: 0, y: 0, width: 1264, height: 1264)
        rainbow.transform = CGAffineTransform(rotationAngle: rainbowAngle/180*CGFloat(M_PI))
        rainbow.center = CGPoint(x: frame.size.width, y: frame.size.height)
        addSubview(rainbow)
        
        //add mask
        let mask = #imageLiteral(resourceName: "discover_rainbow_mask")
        let maskRatio = mask.size.height/mask.size.width
        let maskView = UIImageView(image: mask)
        let maskWidth = frame.size.width
        let maskHeight = maskWidth*maskRatio
        maskView.frame = CGRect(x: 0, y: frame.size.height-maskHeight, width: maskWidth, height: maskHeight)
        addSubview(maskView)
        
        //add cloud
        let cloud = #imageLiteral(resourceName: "discover_cloud")
        let cloudRatio = cloud.size.height/cloud.size.width
        let cloudView = UIImageView(image: cloud)
        let cloudWidth = frame.size.width
        let cloudHeight = cloudWidth*cloudRatio
        cloudView.frame = CGRect(x: 0, y: 0, width: cloudWidth, height: cloudHeight)
        addSubview(cloudView)
        
        //add bird
        birdView = FLAnimatedImageView(frame: CGRect(x: 0, y: 0, width: birdWidth, height: birdHeight))
        birdView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        birdView.center = CGPoint(x: frame.size.width/2+birdCenterX, y: birdTop)
        birdView.image = #imageLiteral(resourceName: "discover_bird_normal")
        addSubview(birdView)
    }
    
    func startAnimation() {
        let birdPath = Bundle.main.path(forResource: "discover_bird", ofType: "gif")
        let birdData = NSData(contentsOfFile: birdPath!)
        birdView.animatedImage = FLAnimatedImage(animatedGIFData: birdData as Data!)
        
        rotationAnimation(rainbow)
    }
    
    func rotationAnimation(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = (360+rainbowAngle)/180*CGFloat(M_PI)
        animation.duration = 10
        animation.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        view.layer.add(animation, forKey: "rotationAnimation")
    }
}
