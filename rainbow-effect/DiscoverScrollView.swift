//
//  DiscoverScrollView.swift
//  rainbow-effect
//
//  Created by JaminZhou on 2017/3/5.
//  Copyright © 2017年 Hangzhou Tomorning Technology Co., Ltd. All rights reserved.
//

import UIKit

class DiscoverScrollView: UIScrollView {
    let angleRatio: CGFloat = 0.5
    let rotationX: CGFloat = -1.0
    let rotationY: CGFloat = 0.0
    let rotationZ: CGFloat = 0.0
    let translateX: CGFloat = 0.25
    let translateY: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        isPagingEnabled = true
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentOffsetX = contentOffset.x;
        for view in subviews {
            let t1 = view.layer.transform
            view.layer.transform = CATransform3DIdentity
            var distanceFromCenterX = view.frame.origin.x - contentOffsetX
            view.layer.transform = t1
            distanceFromCenterX = distanceFromCenterX * 100 / frame.size.width
            let angle = distanceFromCenterX * angleRatio
            let offset = distanceFromCenterX
            let translateX = frame.size.width * self.translateX * offset / 100
            let translateY = frame.size.width * self.translateY * fabs(offset) / 100
            let t = CATransform3DMakeTranslation(translateX, translateY, 0)
            view.layer.transform = CATransform3DRotate(t, (angle / 180.0 * CGFloat(M_PI)), self.rotationX, self.rotationY, self.rotationZ)
        }
    }
    
}
