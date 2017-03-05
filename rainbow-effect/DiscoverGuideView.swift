//
//  DiscoverGuideView.swift
//  rainbow-effect
//
//  Created by JaminZhou on 2017/3/5.
//  Copyright © 2017年 Hangzhou Tomorning Technology Co., Ltd. All rights reserved.
//

import UIKit

class DiscoverGuideView: UIView {
    @IBOutlet weak var backS2: UIImageView!
    @IBOutlet weak var phone: UIImageView!
    @IBOutlet weak var lineView: UIImageView!
    @IBOutlet weak var textView1: UIView!
    @IBOutlet weak var textView2: UIView!
    @IBOutlet weak var cardBackView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var enterButton: UIButton!

    //constant
    @IBOutlet weak var constantTop: NSLayoutConstraint!
    @IBOutlet weak var constantWidth: NSLayoutConstraint!
    @IBOutlet weak var constantLineWidth: NSLayoutConstraint!
    @IBOutlet weak var constantTextTop1: NSLayoutConstraint!
    @IBOutlet weak var constantPhoneTop: NSLayoutConstraint!
    @IBOutlet weak var constantPhoneWidth: NSLayoutConstraint!
    @IBOutlet weak var constantTextTop2: NSLayoutConstraint!
    @IBOutlet weak var constantEnterBottom: NSLayoutConstraint!
    @IBOutlet weak var constantPageBottom: NSLayoutConstraint!
    @IBOutlet weak var constantCardTop: NSLayoutConstraint!
    @IBOutlet weak var constantCardWidth: NSLayoutConstraint!
    @IBOutlet weak var constantBackWidth2: NSLayoutConstraint!
    @IBOutlet weak var constantBackTop2: NSLayoutConstraint!
    @IBOutlet weak var constantLogoWidth1: NSLayoutConstraint!
    @IBOutlet weak var constantLogoWidth2: NSLayoutConstraint!
    
    //
    var pagingScrollView: UIScrollView!
    var birdView: DiscoverBirdView!
    var cardView: DiscoverScrollView!
    var backTop: CGFloat!
    var backWidth: CGFloat!
    
    var pageIndex = 0 {
        didSet {
            if pageIndex != oldValue {
                pageControl.currentPage = pageIndex
            }
        }
    }
    
    var index = 0 {
        didSet {
            if index != oldValue {
                if index >= 1 {
                    if birdView == nil {
                        birdView = DiscoverBirdView(frame: bounds)
                        birdView.alpha = 0.0
                        insertSubview(birdView, belowSubview: pageControl)
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                            self.birdView.alpha = 1.0
                        }, completion: { (value) in
                            self.birdView.startAnimation()
                        })
                        
                        textView2.alpha = 0.0
                        enterButton.alpha = 0.0
                        textView2.isHidden = false
                        enterButton.isHidden = false
                        
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                            self.textView2.alpha = 1.0
                            self.enterButton.alpha = 1.0
                            self.pageControl.alpha = 0.0
                        }, completion: { (value) in
                            self.pageControl.isHidden = true
                        })
                        lineAnimation()
                    }
                }
            } else {
                if birdView != nil {
                    birdView.removeFromSuperview()
                    birdView = nil
                }
            }
            if index < 1 && textView2.isHidden == false {
                textView2.isHidden = true
                enterButton.isHidden = true
                pageControl.isHidden = false
                pageControl.alpha = 1.0
                constantLineWidth.constant = 0
                lineView.isHidden = true
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configConstant()
        addPagingScrollView()
        addCardView()
    }
    
    override var frame: CGRect {
        didSet {
            if pagingScrollView != nil {pagingScrollView.frame = bounds}
        }
    }
    
    func configConstant() {
        backTop = 196*KRatio
        backWidth = 223*KRatio
        constantLineWidth.constant = 0
        layoutIfNeeded()
        
        constantTextTop1.constant = 45*KRatio
        constantPhoneTop.constant = 142*KRatio
        constantTextTop2.constant = 274*KRatio
        constantEnterBottom.constant = 23*KRatio
        constantPageBottom.constant = 8*KRatio
        constantPhoneWidth.constant = 251*KRatio
        constantCardTop.constant = 196*KRatio
        constantBackTop2.constant = 196*KRatio
        constantCardWidth.constant = 223*KRatio
        constantBackWidth2.constant = 223*KRatio
        constantLogoWidth1.constant = 99*KRatio
        constantLogoWidth2.constant = 90*KRatio
    }
    
    func addPagingScrollView() {
        pagingScrollView = UIScrollView(frame: bounds)
        pagingScrollView.contentSize = CGSize(width: bounds.size.width*2, height: bounds.size.height)
        pagingScrollView.isPagingEnabled = true
        pagingScrollView.showsHorizontalScrollIndicator = false
        pagingScrollView.delegate = self
        insertSubview(pagingScrollView, belowSubview: enterButton)

        addTextLabel(text: "发现每日新惊奇", index: 0)
    }
    
    func addCardView() {
        cardBackView.clipsToBounds = true
        cardView = DiscoverScrollView(frame: CGRect(x: 16, y: 95, width: cardBackView.frame.size.width-32, height: cardBackView.frame.size.height-95))
        cardBackView.addSubview(cardView)
        
        addCard(image: #imageLiteral(resourceName: "discover_card"))
    }
    
    func addTextLabel(text: String, index: Int) {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor(red: 61/255, green: 64/255, blue: 72/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14*KRatio, weight: UIFontWeightLight)
        label.sizeToFit()
        label.center = CGPoint(x: (0.5+CGFloat(index))*bounds.size.width, y: 102*KRatio)
        pagingScrollView.addSubview(label)
    }
    
    func addCard(image: UIImage) {
        let width = cardView.frame.size.width
        let height = cardView.frame.size.height
        let x = CGFloat(cardView.subviews.count)*width
        let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: width, height: height))
        imageView.image = image
        cardView.addSubview(imageView)
        cardView.contentSize = CGSize(width: x+width, height: height)
    }
    
    func lineAnimation() {
        lineView.isHidden = false
        constantLineWidth.constant = enterButton.frame.size.width+9
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }) { (value) in
            
        }
    }
}

extension DiscoverGuideView: UIScrollViewDelegate {
    func scrollViewDidScroll( _ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let width = bounds.size.width
        if (offsetX >= 0 && offsetX <= width) {
            let ratio = offsetX/width
            constantTop.constant = backTop*(1-ratio)
            constantWidth.constant = backWidth + (width-backWidth)*ratio
            layoutIfNeeded()
            textView1.alpha = 1-ratio
            phone.alpha = 1-ratio
            cardBackView.alpha = 1-ratio
        } else if (offsetX > width) {
            if constantTop.constant != 0 {
                constantTop.constant = 0
                constantWidth.constant = width
                layoutIfNeeded()
                textView1.alpha = 0
                phone.alpha = 0
                cardBackView.alpha = 0
            }
        } else {
            if constantTop.constant != backTop {
                constantTop.constant = backTop
                constantWidth.constant = backWidth
                layoutIfNeeded()
                textView1.alpha = 1
                phone.alpha = 1
                cardBackView.alpha = 1
            }
        }
        
        pageIndex = Int((offsetX+width/2)/width)
        index = Int(offsetX/width)
        
        if offsetX <= 0 {cardView.contentOffset = CGPoint(x: cardView.frame.size.width*offsetX/width, y: 0)}
    }
}
