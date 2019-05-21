//
//  ViewController.swift
//  rainbow-effect
//
//  Created by JaminZhou on 2017/3/5.
//  Copyright © 2017年 Hangzhou Tomorning Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var guideView: DiscoverGuideView!

    override func viewDidLoad() {
        super.viewDidLoad()
        showGuide()
    }
    
    func showGuide() {
        guideView = Bundle.main.loadNibNamed("DiscoverGuideView", owner: self, options: nil)![0] as? DiscoverGuideView
        guideView.frame = view.bounds
        guideView.commonInit()
        view.addSubview(guideView)
    }

}

